class OpenRouterChatResponse {
  final String? content;

  const OpenRouterChatResponse({this.content});

  factory OpenRouterChatResponse.fromJson(Map<String, dynamic> json) {
    final choices = json['choices'];
    if (choices is! List || choices.isEmpty) {
      return const OpenRouterChatResponse();
    }

    final firstChoice = choices.first;
    if (firstChoice is! Map<String, dynamic>) {
      return const OpenRouterChatResponse();
    }

    final message = firstChoice['message'];
    if (message is! Map<String, dynamic>) {
      return const OpenRouterChatResponse();
    }

    final content = message['content'];
    if (content is String) {
      return OpenRouterChatResponse(content: content.trim());
    }

    if (content is List) {
      final text = content
          .whereType<Map<String, dynamic>>()
          .map((part) => part['text'])
          .whereType<String>()
          .join('\n')
          .trim();
      return OpenRouterChatResponse(content: text);
    }

    return const OpenRouterChatResponse();
  }
}
