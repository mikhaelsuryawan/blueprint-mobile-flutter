import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../constants/open_router_constants.dart';
import '../../../utils/services/api/dio_factory.dart';
import '../model/request/chat_request.dart';
import '../model/response/chat_response.dart';

class ChatRepository {
  Dio? _client;

  Dio get _dio {
    return _client ??= DioFactory.create(baseUrl: OpenRouterConstants.baseUrl);
  }

  /// Streams response chunks from OpenRouter SSE
  Stream<String> sendMessageStream(List<ChatMessage> messages) async* {
    final request = ChatRequest(
      model: OpenRouterConstants.model,
      messages:
          messages.where((m) => !m.isError).map((m) => m.toRequest()).toList(),
    );

    try {
      final response = await _dio.post(
        OpenRouterConstants.chatEndpoint,
        data: request.toJson(),
        options: Options(
          responseType: ResponseType.stream,
          headers: {
            'Authorization': 'Bearer ${OpenRouterConstants.apiKey}',
            'Content-Type': 'application/json',
            'X-Title': OpenRouterConstants.appName,
          },
        ),
      );

      final stream = response.data.stream as Stream<List<int>>;
      final buffer = StringBuffer();

      await for (final chunk in stream) {
        final raw = utf8.decode(chunk);
        buffer.write(raw);

        final lines = buffer.toString().split('\n');
        buffer.clear();
        buffer.write(lines.last); // keep incomplete line

        for (int i = 0; i < lines.length - 1; i++) {
          final line = lines[i].trim();
          if (line.isEmpty || !line.startsWith('data: ')) continue;

          final data = line.substring(6).trim();
          if (data == '[DONE]') return;

          try {
            final json = jsonDecode(data) as Map<String, dynamic>;
            final choices = json['choices'] as List<dynamic>?;
            if (choices == null || choices.isEmpty) continue;

            final delta = choices[0]['delta'] as Map<String, dynamic>?;
            final content = delta?['content'] as String?;
            if (content != null && content.isNotEmpty) yield content;
          } catch (_) {
            // Skip malformed SSE chunks
          }
        }
      }
    } on DioException catch (e) {
      throw _mapDioError(e);
    }
  }

  Exception _mapDioError(DioException e) {
    if (e.response != null) {
      final status = e.response!.statusCode;
      final data = e.response!.data;

      if (status == 401) {
        return Exception('Invalid API key. Check OPEN_ROUTER_API_KEY in .env');
      }
      if (status == 402) {
        // Free models still require $1 minimum credit added to your account
        return Exception(
          'OpenRouter requires minimum \$1 credit added to your account '
          'to use free models. Visit openrouter.ai/settings/credits',
        );
      }
      if (status == 429) {
        return Exception(
            'Rate limit exceeded (200 req/day for free models). Try again later.');
      }
      if (status == 503 || status == 502) {
        return Exception(
            'Model temporarily unavailable. Try again in a moment.');
      }

      return Exception('API Error $status.');
    }

    if (e.type == DioExceptionType.connectionTimeout) {
      return Exception('Connection timed out. Check your internet.');
    }
    if (e.type == DioExceptionType.receiveTimeout) {
      return Exception('Response timed out. The model may be slow right now.');
    }

    return Exception('Network error: ${e.message}');
  }
}
