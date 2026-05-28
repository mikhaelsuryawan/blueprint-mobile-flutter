import '../model/response/chat_response.dart';

enum ChatStatus { initial, loading, streaming, success, error }

class ChatState {
  final List<ChatMessage> messages;
  final ChatStatus status;
  final String? errorMessage;

  const ChatState({
    this.messages = const [],
    this.status = ChatStatus.initial,
    this.errorMessage,
  });

  bool get isEmpty => messages.isEmpty;
  bool get isLoading =>
      status == ChatStatus.loading || status == ChatStatus.streaming;

  ChatState copyWith({
    List<ChatMessage>? messages,
    ChatStatus? status,
    String? errorMessage,
  }) {
    return ChatState(
      messages: messages ?? this.messages,
      status: status ?? this.status,
      errorMessage: errorMessage,
    );
  }
}
