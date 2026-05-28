class ChatMessageRequest {
  final String role;
  final String content;

  const ChatMessageRequest({
    required this.role,
    required this.content,
  });

  Map<String, dynamic> toJson() => {
        'role': role,
        'content': content,
      };
}

class ChatRequest {
  final String model;
  final List<ChatMessageRequest> messages;
  final bool stream;
  final int maxTokens;
  final double temperature;

  const ChatRequest({
    required this.model,
    required this.messages,
    this.stream = true,
    this.maxTokens = 2048,
    this.temperature = 0.7,
  });

  Map<String, dynamic> toJson() => {
        'model': model,
        'messages': messages.map((m) => m.toJson()).toList(),
        'stream': stream,
        'max_tokens': maxTokens,
        'temperature': temperature,
      };
}
