import 'package:flutter_dotenv/flutter_dotenv.dart';

class OpenRouterConstants {
  OpenRouterConstants._();

  static String get baseUrl =>
      dotenv.env['OPEN_ROUTER_BASE_URL'] ?? 'https://openrouter.ai/api/v1';

  static String get apiKey => dotenv.env['OPEN_ROUTER_API_KEY'] ?? '';

  static const String chatEndpoint = '/chat/completions';

  // Verify exact model ID at: https://openrouter.ai/models
  static const String model = 'deepseek/deepseek-v4-flash:free';

  static const String appName = 'Blueprint Mobile';
}
