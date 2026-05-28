import 'package:flutter/material.dart';

import '../../../core/chat/model/response/chat_response.dart';

class MessageItem extends StatelessWidget {
  final ChatMessage message;
  final VoidCallback? onRetry;

  const MessageItem({
    super.key,
    required this.message,
    this.onRetry,
  });

  bool get _isUser => message.role == ChatMessageRole.user;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
      child: Column(
        crossAxisAlignment:
            _isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment:
                _isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (!_isUser) ...[
                CircleAvatar(
                  radius: 14,
                  backgroundColor: colorScheme.secondaryContainer,
                  child: const Text('🤖', style: TextStyle(fontSize: 13)),
                ),
                const SizedBox(width: 8),
              ],
              Flexible(
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.75,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: message.isError
                        ? colorScheme.errorContainer
                        : _isUser
                            ? colorScheme.primary
                            : colorScheme.surfaceVariant,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(18),
                      topRight: const Radius.circular(18),
                      bottomLeft: Radius.circular(_isUser ? 18 : 4),
                      bottomRight: Radius.circular(_isUser ? 4 : 18),
                    ),
                  ),
                  child: message.isStreaming && message.content.isEmpty
                      ? _TypingIndicator(color: colorScheme.onSurfaceVariant)
                      : Text(
                          message.content,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: message.isError
                                ? colorScheme.onErrorContainer
                                : _isUser
                                    ? colorScheme.onPrimary
                                    : colorScheme.onSurfaceVariant,
                          ),
                        ),
                ),
              ),
            ],
          ),
          if (message.isStreaming && message.content.isNotEmpty)
            Padding(
              padding: EdgeInsets.only(
                top: 4,
                left: _isUser ? 0 : 44,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 10,
                    height: 10,
                    child: CircularProgressIndicator(
                      strokeWidth: 1.5,
                      color: colorScheme.primary,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Typing...', // AppLocalizations key
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: colorScheme.outline,
                    ),
                  ),
                ],
              ),
            ),
          if (message.isError && onRetry != null)
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child: TextButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh, size: 14),
                label: const Text('Retry'), // AppLocalizations key
                style: TextButton.styleFrom(
                  visualDensity: VisualDensity.compact,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _TypingIndicator extends StatefulWidget {
  final Color color;
  const _TypingIndicator({required this.color});

  @override
  State<_TypingIndicator> createState() => _TypingIndicatorState();
}

class _TypingIndicatorState extends State<_TypingIndicator>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat();
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _controller.dispose(); // ✅ Always dispose AnimationController
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (_, __) => Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(3, (i) {
          final delay = i / 3;
          final value = (_animation.value - delay).clamp(0.0, 1.0);
          final offset = -4.0 * (1 - (value * 2 - 1).abs());
          return Transform.translate(
            offset: Offset(0, offset),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: Container(
                width: 7,
                height: 7,
                decoration: BoxDecoration(
                  color: widget.color,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
