import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/response/chat_response.dart';
import '../repository/chat_repository.dart';
import 'chat_event.dart';
import 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatRepository _repository;
  StreamSubscription<String>? _streamSubscription;

  ChatBloc({required ChatRepository repository})
      : _repository = repository,
        super(const ChatState()) {
    on<ChatSendMessageEvent>(_onSendMessage);
    on<ChatStreamChunkEvent>(_onStreamChunk);
    on<ChatStreamFinishedEvent>(_onStreamFinished);
    on<ChatStreamErrorEvent>(_onStreamError);
    on<ChatClearEvent>(_onClear);
    on<ChatRetryEvent>(_onRetry);
  }

  Future<void> _onSendMessage(
    ChatSendMessageEvent event,
    Emitter<ChatState> emit,
  ) async {
    if (state.isLoading) return;

    final userMessage = ChatMessage.user(event.content.trim());
    final assistantMessage = ChatMessage.assistantStreaming();

    final updatedMessages = [
      ...state.messages,
      userMessage,
      assistantMessage,
    ];

    emit(state.copyWith(
      messages: updatedMessages,
      status: ChatStatus.streaming,
      errorMessage: null,
    ));

    await _streamSubscription?.cancel();

    _streamSubscription = _repository
        .sendMessageStream(
          updatedMessages.where((m) => m.id != assistantMessage.id).toList(),
        )
        .listen(
          (chunk) => add(ChatStreamChunkEvent(
            chunk: chunk,
            assistantMessageId: assistantMessage.id,
          )),
          onDone: () => add(ChatStreamFinishedEvent(assistantMessage.id)),
          onError: (error) => add(ChatStreamErrorEvent(
            error: error.toString(),
            assistantMessageId: assistantMessage.id,
          )),
        );
  }

  void _onStreamChunk(
    ChatStreamChunkEvent event,
    Emitter<ChatState> emit,
  ) {
    final updated = state.messages.map((m) {
      if (m.id == event.assistantMessageId) {
        return m.copyWith(content: m.content + event.chunk);
      }
      return m;
    }).toList();

    emit(state.copyWith(messages: updated, status: ChatStatus.streaming));
  }

  void _onStreamFinished(
    ChatStreamFinishedEvent event,
    Emitter<ChatState> emit,
  ) {
    final updated = state.messages.map((m) {
      if (m.id == event.assistantMessageId) {
        return m.copyWith(isStreaming: false);
      }
      return m;
    }).toList();

    emit(state.copyWith(messages: updated, status: ChatStatus.success));
  }

  void _onStreamError(
    ChatStreamErrorEvent event,
    Emitter<ChatState> emit,
  ) {
    final updated = state.messages.map((m) {
      if (m.id == event.assistantMessageId) {
        return m.copyWith(
          content: event.error,
          isStreaming: false,
          isError: true,
        );
      }
      return m;
    }).toList();

    emit(state.copyWith(
      messages: updated,
      status: ChatStatus.error,
      errorMessage: event.error,
    ));
  }

  void _onClear(ChatClearEvent event, Emitter<ChatState> emit) {
    _streamSubscription?.cancel();
    emit(const ChatState());
  }

  void _onRetry(ChatRetryEvent event, Emitter<ChatState> emit) {
    final messages = state.messages;
    final lastUserIndex =
        messages.lastIndexWhere((m) => m.role == ChatMessageRole.user);
    if (lastUserIndex == -1) return;

    final lastContent = messages[lastUserIndex].content;
    final trimmed = messages.sublist(0, lastUserIndex);

    emit(state.copyWith(messages: trimmed));
    add(ChatSendMessageEvent(lastContent));
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
