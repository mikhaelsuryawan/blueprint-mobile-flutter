import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/chat/bloc/chat_bloc.dart';
import '../../../core/chat/bloc/chat_event.dart';
import '../../../core/chat/bloc/chat_state.dart';
import '../controller/chat_controller.dart';
import '../item/message_item.dart';

class ChatBody extends StatefulWidget {
  const ChatBody({super.key});

  @override
  State<ChatBody> createState() => _ChatBodyState();
}

class _ChatBodyState extends State<ChatBody> {
  late final ChatController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ChatController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onSend(BuildContext context) {
    if (!_controller.hasText) return;
    final text = _controller.consumeText();
    context.read<ChatBloc>().add(ChatSendMessageEvent(text));
    _controller.focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Chat'), // replace with AppLocalizations key
        actions: [
          BlocBuilder<ChatBloc, ChatState>(
            builder: (context, state) {
              if (state.isEmpty) return const SizedBox.shrink();
              return IconButton(
                icon: const Icon(Icons.delete_outline),
                tooltip: 'Clear chat',
                onPressed: () => _showClearDialog(context),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocConsumer<ChatBloc, ChatState>(
              listener: (context, state) {
                _controller.scrollToBottom();
              },
              builder: (context, state) {
                if (state.isEmpty) return _buildEmptyState(context, theme);

                return ListView.builder(
                  controller: _controller.scrollController,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  itemCount: state.messages.length,
                  itemBuilder: (context, index) {
                    final message = state.messages[index];
                    return MessageItem(
                      message: message,
                      onRetry: message.isError
                          ? () => context
                              .read<ChatBloc>()
                              .add(const ChatRetryEvent())
                          : null,
                    );
                  },
                );
              },
            ),
          ),
          const Divider(height: 1),
          _buildInput(context),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, ThemeData theme) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('🤖', style: TextStyle(fontSize: 52)),
          const SizedBox(height: 12),
          Text(
            'AI Chat', // replace with AppLocalizations key
            style: theme.textTheme.titleMedium,
          ),
          const SizedBox(height: 4),
          Text(
            'Ask me anything', // replace with AppLocalizations key
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.outline,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInput(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
        child: BlocBuilder<ChatBloc, ChatState>(
          builder: (context, state) {
            return Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller.textController,
                    focusNode: _controller.focusNode,
                    enabled: !state.isLoading,
                    minLines: 1,
                    maxLines: 5,
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.newline,
                    decoration: InputDecoration(
                      hintText:
                          'Type a message...', // replace with AppLocalizations key
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Theme.of(context).colorScheme.surfaceVariant,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                    ),
                    onChanged: (_) => setState(() {}),
                  ),
                ),
                const SizedBox(width: 8),
                state.isLoading
                    ? const SizedBox(
                        width: 44,
                        height: 44,
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: CircularProgressIndicator(strokeWidth: 2.5),
                        ),
                      )
                    : IconButton.filled(
                        onPressed:
                            _controller.hasText ? () => _onSend(context) : null,
                        icon: const Icon(Icons.send_rounded),
                      ),
              ],
            );
          },
        ),
      ),
    );
  }

  void _showClearDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Clear Chat'), // AppLocalizations key
        content:
            const Text('All messages will be deleted.'), // AppLocalizations key
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'), // AppLocalizations key
          ),
          FilledButton(
            onPressed: () {
              context.read<ChatBloc>().add(const ChatClearEvent());
              Navigator.pop(ctx);
            },
            child: const Text('Clear'), // AppLocalizations key
          ),
        ],
      ),
    );
  }
}
