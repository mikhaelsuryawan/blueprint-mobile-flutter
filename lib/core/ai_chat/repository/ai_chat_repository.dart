import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../utils/services/api/dio_factory.dart';
import '../model/request/open_router_chat_request.dart';
import '../model/response/open_router_chat_response.dart';

abstract class AiChatRepository {
  Future<OpenRouterChatResponse> sendMessage({
    required String apiKey,
    required OpenRouterChatRequest request,
  });
}

class AiChatService implements AiChatRepository {
  static const _baseUrl = 'https://openrouter.ai';
  static const _chatCompletionPath = '/api/v1/chat/completions';
  static const _appReferer = 'https://blueprint-mobile-flutter.local';
  static const _appTitle = 'Blueprint Mobile Flutter';

  Dio? _client;

  Dio get _dio {
    return _client ??= DioFactory.create(baseUrl: _baseUrl);
  }

  @override
  Future<OpenRouterChatResponse> sendMessage({
    required String apiKey,
    required OpenRouterChatRequest request,
  }) async {
    try {
      final response = await _dio.post(
        _chatCompletionPath,
        data: request.toJson(),
        options: Options(
          headers: {
            'Authorization': 'Bearer $apiKey',
            'HTTP-Referer': _appReferer,
            'X-OpenRouter-Title': _appTitle,
          },
          validateStatus: (_) => true,
        ),
      );

      if (response.statusCode == 200) {
        final data = _responseMap(response.data);
        return OpenRouterChatResponse.fromJson(data);
      }

      throw AiChatRepositoryException(
        statusCode: response.statusCode,
        message: _extractErrorMessage(response.data),
      );
    } on AiChatRepositoryException {
      rethrow;
    } on DioException catch (error) {
      throw AiChatRepositoryException(
        statusCode: error.response?.statusCode,
        message: _extractErrorMessage(error.response?.data),
      );
    }
  }

  Map<String, dynamic> _responseMap(dynamic data) {
    if (data is Map<String, dynamic>) return data;
    if (data is Map) return Map<String, dynamic>.from(data);
    if (data is String) {
      try {
        final decoded = jsonDecode(data);
        if (decoded is Map<String, dynamic>) return decoded;
        if (decoded is Map) return Map<String, dynamic>.from(decoded);
      } catch (_) {}
    }
    return const {};
  }

  String? _extractErrorMessage(dynamic data) {
    if (data is Map) {
      final error = data['error'];
      if (error is Map) {
        final message = error['message'];
        if (message is String && message.trim().isNotEmpty) {
          return message.trim();
        }
      }

      final message = data['message'];
      if (message is String && message.trim().isNotEmpty) {
        return message.trim();
      }
    }

    if (data is String && data.trim().isNotEmpty) {
      try {
        final decoded = jsonDecode(data);
        final decodedMessage = _extractErrorMessage(decoded);
        if (decodedMessage != null) return decodedMessage;
      } catch (_) {}
      return data.trim();
    }

    return null;
  }
}

class AiChatRepositoryException implements Exception {
  final int? statusCode;
  final String? message;

  const AiChatRepositoryException({
    this.statusCode,
    this.message,
  });
}
