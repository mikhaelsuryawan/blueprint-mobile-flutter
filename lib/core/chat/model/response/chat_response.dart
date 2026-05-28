import '../request/chat_request.dart';

enum ChatMessageRole { user, assistant, system }

extension ChatMessageRoleX on ChatMessageRole {
  String get value {
    switch (this) {
      case ChatMessageRole.user:
        return 'user';
      case ChatMessageRole.assistant:
        return 'assistant';
      case ChatMessageRole.system:
        return 'system';
    }
  }

  static ChatMessageRole fromString(String value) {
    switch (value) {
      case 'assistant':
        return ChatMessageRole.assistant;
      case 'system':
        return ChatMessageRole.system;
      default:
        return ChatMessageRole.user;
    }
  }
}

class ChatMessage {
  final String id;
  final String content;
  final ChatMessageRole role;
  final DateTime createdAt;
  final bool isStreaming;
  final bool isError;

  const ChatMessage({
    required this.id,
    required this.content,
    required this.role,
    required this.createdAt,
    this.isStreaming = false,
    this.isError = false,
  });

  ChatMessage copyWith({
    String? content,
    bool? isStreaming,
    bool? isError,
  }) {
    return ChatMessage(
      id: id,
      content: content ?? this.content,
      role: role,
      createdAt: createdAt,
      isStreaming: isStreaming ?? this.isStreaming,
      isError: isError ?? this.isError,
    );
  }

  /// Convert to API request format
  ChatMessageRequest toRequest() => ChatMessageRequest(
        role: role.value,
        content: content,
      );

  factory ChatMessage.user(String content) => ChatMessage(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        content: content,
        role: ChatMessageRole.user,
        createdAt: DateTime.now(),
      );

  factory ChatMessage.assistantStreaming() => ChatMessage(
        id: '${DateTime.now().microsecondsSinceEpoch}_ai',
        content: '',
        role: ChatMessageRole.assistant,
        createdAt: DateTime.now(),
        isStreaming: true,
      );
}
