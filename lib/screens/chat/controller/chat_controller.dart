import 'package:flutter/material.dart';

/// Handles local UI state: text input, scroll, focus.
/// No BLoC calls here — orchestration only.
class ChatController {
  final TextEditingController textController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  final FocusNode focusNode = FocusNode();

  bool get hasText => textController.text.trim().isNotEmpty;

  String consumeText() {
    final text = textController.text.trim();
    textController.clear();
    return text;
  }

  void scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void dispose() {
    textController.dispose();
    scrollController.dispose();
    focusNode.dispose();
  }
}
