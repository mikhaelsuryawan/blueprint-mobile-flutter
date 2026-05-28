class OpenRouterChatRequest {
  final String model;
  final List<OpenRouterChatMessage> messages;

  const OpenRouterChatRequest({
    required this.model,
    required this.messages,
  });

  Map<String, dynamic> toJson() {
    return {
      'model': model,
      'messages': messages.map((message) => message.toJson()).toList(),
      'temperature': 0.7,
      'stream': false,
    };
  }
}

class OpenRouterChatMessage {
  final String role;
  final String content;

  const OpenRouterChatMessage({
    required this.role,
    required this.content,
  });

  Map<String, String> toJson() {
    return {
      'role': role,
      'content': content,
    };
  }
}
