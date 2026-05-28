abstract class ChatEvent {
  const ChatEvent();
}

class ChatSendMessageEvent extends ChatEvent {
  final String content;
  const ChatSendMessageEvent(this.content);
}

class ChatStreamChunkEvent extends ChatEvent {
  final String chunk;
  final String assistantMessageId;
  const ChatStreamChunkEvent({
    required this.chunk,
    required this.assistantMessageId,
  });
}

class ChatStreamFinishedEvent extends ChatEvent {
  final String assistantMessageId;
  const ChatStreamFinishedEvent(this.assistantMessageId);
}

class ChatStreamErrorEvent extends ChatEvent {
  final String error;
  final String assistantMessageId;
  const ChatStreamErrorEvent({
    required this.error,
    required this.assistantMessageId,
  });
}

class ChatClearEvent extends ChatEvent {
  const ChatClearEvent();
}

class ChatRetryEvent extends ChatEvent {
  const ChatRetryEvent();
}
