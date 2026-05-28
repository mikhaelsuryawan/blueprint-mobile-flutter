import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:lottie/lottie.dart';

import '../../../config/language/app_localizations.dart';
import '../../../config/themes/app_colors.dart';
import '../../../config/themes/notifiers/theme_manager.dart';
import '../../../constants/assets_path.dart';
import '../../../core/ai_chat/model/request/open_router_chat_request.dart';
import '../../../core/ai_chat/repository/ai_chat_repository.dart';
import '../../../utils/responsive_configuration.dart';
import '../../../widgets/default_appbar.dart';
import '../../../widgets/textfield/textfield_default.dart';

class ChatMessage {
  final String content;
  final bool isUser;
  final DateTime timestamp;

  ChatMessage({
    required this.content,
    required this.isUser,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();
}

class AiChatBody extends StatefulWidget {
  const AiChatBody({super.key});

  @override
  State<AiChatBody> createState() => _AiChatBodyState();
}

class _AiChatBodyState extends State<AiChatBody>
    with SingleTickerProviderStateMixin {
  static const _envApiKey = 'OPENROUTER_API_KEY';
  static const _envModel = 'OPENROUTER_MODEL';
  static const _defaultModel = 'deepseek/deepseek-v4-flash:free';

  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<ChatMessage> _messages = [];
  final FocusNode _focusNode = FocusNode();
  late AnimationController _animationController;
  late Animation<double> _animation;

  final AiChatRepository _aiChatRepository = AiChatService();
  bool _awaitingAssistant = false;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _setAnimation();
  }

  _setAnimation() {
    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.easeOut);

    _animation.addListener(() => setState(() {}));
    _animationController.forward();
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    _focusNode.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || !_scrollController.hasClients) return;
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  String _openRouterApiKey() => (dotenv.env[_envApiKey] ?? '').trim();

  String _openRouterModelId() {
    final fromEnv = (dotenv.env[_envModel] ?? '').trim();
    return fromEnv.isEmpty ? _defaultModel : fromEnv;
  }

  List<OpenRouterChatMessage> _historyAsOpenRouterMessages() {
    return _messages
        .map(
          (message) => OpenRouterChatMessage(
            role: message.isUser ? 'user' : 'assistant',
            content: message.content,
          ),
        )
        .toList();
  }

  Future<String?> _sendOpenRouterChatCompletion({
    required String apiKey,
  }) async {
    final response = await _aiChatRepository.sendMessage(
      apiKey: apiKey,
      request: OpenRouterChatRequest(
        model: _openRouterModelId(),
        messages: _historyAsOpenRouterMessages(),
      ),
    );
    return response.content;
  }

  Future<void> _sendMessage() async {
    final text = _messageController.text.trim();
    if (text.isEmpty || _awaitingAssistant) return;

    final loc = GetAppLocalizations(context);
    final apiKey = _openRouterApiKey();
    if (apiKey.isEmpty) {
      setState(() {
        _messages.add(ChatMessage(content: text, isUser: true));
        _messageController.clear();
        _messages.add(
          ChatMessage(content: loc.aiChatMissingApiKey, isUser: false),
        );
      });
      _scrollToBottom();
      return;
    }

    setState(() {
      _messages.add(ChatMessage(content: text, isUser: true));
      _messageController.clear();
      _awaitingAssistant = true;
    });
    _scrollToBottom();

    try {
      final reply = await _sendOpenRouterChatCompletion(apiKey: apiKey);

      if (!mounted) return;
      setState(() {
        _awaitingAssistant = false;
        if (reply == null || reply.isEmpty) {
          _messages.add(
            ChatMessage(content: loc.aiChatNoResponse, isUser: false),
          );
        } else {
          _messages.add(ChatMessage(content: reply, isUser: false));
        }
      });
    } on AiChatRepositoryException catch (error) {
      if (!mounted) return;
      setState(() {
        _awaitingAssistant = false;
        _messages.add(
          ChatMessage(
            content: error.message?.isNotEmpty == true
                ? error.message!
                : loc.aiChatErrorGeneric,
            isUser: false,
          ),
        );
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _awaitingAssistant = false;
        _messages.add(
          ChatMessage(content: loc.aiChatErrorGeneric, isUser: false),
        );
      });
    }

    _scrollToBottom();
  }

  Widget _buildAssistantLoadingRow() {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: pxToSp(context, 18),
        vertical: pxToSp(context, 8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: pxToSp(context, 28),
            height: pxToSp(context, 28),
            decoration: BoxDecoration(
              color: colorScheme.primaryContainer,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.smart_toy_outlined,
              size: pxToSp(context, 25),
              color: colorScheme.onPrimaryContainer,
            ),
          ),
          SizedBox(width: pxToSp(context, 12)),
          Flexible(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.75,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: pxToSp(context, 18),
                vertical: pxToSp(context, 12),
              ),
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(pxToSp(context, 12)),
                  topRight: Radius.circular(pxToSp(context, 12)),
                  bottomLeft: Radius.circular(pxToSp(context, 4)),
                  bottomRight: Radius.circular(pxToSp(context, 12)),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: pxToSp(context, 20),
                    height: pxToSp(context, 20),
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Theme.of(context).textTheme.titleMedium?.color ??
                          AppColors.accent_light,
                    ),
                  ),
                  SizedBox(width: pxToSp(context, 12)),
                  Text(
                    GetAppLocalizations(context).aiChatLoading,
                    style: AppThemeNotifier.getTextStyleFromTheme(
                      color: colorScheme.onSurfaceVariant,
                      fontWeight: FontWeight.w400,
                      baseStyle: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(ChatMessage message) {
    final isUser = message.isUser;
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: pxToSp(context, 18), vertical: pxToSp(context, 8)),
      child: Row(
        mainAxisAlignment:
            isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isUser) ...[
            Container(
              width: pxToSp(context, 28),
              height: pxToSp(context, 28),
              decoration: BoxDecoration(
                color: colorScheme.primaryContainer,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.smart_toy_outlined,
                size: pxToSp(context, 25),
                color: colorScheme.onPrimaryContainer,
              ),
            ),
            SizedBox(width: pxToSp(context, 12)),
          ],
          Flexible(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.75,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: pxToSp(context, 18),
                vertical: pxToSp(context, 12),
              ),
              decoration: BoxDecoration(
                color: isUser
                    ? AppColors.accent_light
                    : colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(pxToSp(context, 12)),
                  topRight: Radius.circular(pxToSp(context, 12)),
                  bottomLeft: Radius.circular(
                      isUser ? pxToSp(context, 12) : pxToSp(context, 4)),
                  bottomRight: Radius.circular(
                      isUser ? pxToSp(context, 4) : pxToSp(context, 12)),
                ),
              ),
              child: Text(
                message.content,
                style: AppThemeNotifier.getTextStyleFromTheme(
                  color:
                      isUser ? AppColors.white_FFFFFF : colorScheme.onSurface,
                  fontWeight: FontWeight.w400,
                  baseStyle: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ),
          ),
          if (isUser) ...[
            SizedBox(width: pxToSp(context, 12)),
            Container(
              width: pxToSp(context, 28),
              height: pxToSp(context, 28),
              decoration: BoxDecoration(
                color: colorScheme.secondaryContainer,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.person_outline,
                size: pxToSp(context, 18),
                color: colorScheme.onSecondaryContainer,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildInputField() {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: pxToSp(context, 18),
        vertical: pxToSp(context, 18),
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: TextfieldDefault(
                controller: _messageController,
                onChanged: (value) {
                  // Handle text changes if needed
                },
                textColor: colorScheme.onSurface,
                enabledBorderColor: AppColors.accent_light,
                hintText: GetAppLocalizations(context).aiChatHintMessage,
                textInputAction: TextInputAction.newline,
                textInputType: TextInputType.multiline,
                maxLength: 1000,
                minLine: 1,
                maxLine: 5,
              ).animate().fadeIn(duration: 600.ms).slideX(),
            ),
            SizedBox(width: pxToSp(context, 12)),
            Container(
              width: pxToSp(context, 48),
              height: pxToSp(context, 48),
              padding: EdgeInsets.all(pxToSp(context, 4)),
              decoration: BoxDecoration(
                color: AppColors.accent_light,
                borderRadius: BorderRadius.circular(pxToSp(context, 12)),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(pxToSp(context, 12)),
                  onTap: _awaitingAssistant ? null : () => _sendMessage(),
                  child: Icon(
                    Icons.send_rounded,
                    color: colorScheme.onSecondary,
                    size: pxToSp(context, 32),
                  ),
                ),
              ),
            ).animate().fadeIn(duration: 600.ms).slideX(begin: 1),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: pxToSp(context, 50),
            height: pxToSp(context, 50),
            child: Lottie.asset(
              Assets.flutterLottie,
              controller: _animationController,
              fit: BoxFit.contain, // keep aspect ratio
              onLoaded: (composition) {
                _animationController
                  ..duration = composition.duration
                  ..forward();
              },
            ),
          ),
          SizedBox(height: pxToSp(context, 20)),
          Text(
            GetAppLocalizations(context).aiChatEmptyTitle,
            style: AppThemeNotifier.getTextStyleFromTheme(
              color: colorScheme.onSurfaceVariant,
              baseStyle: Theme.of(context).textTheme.titleMedium,
            ),
          ).animate().fadeIn(duration: 600.ms).move(),
          SizedBox(height: pxToSp(context, 6)),
          Text(
            GetAppLocalizations(context).aiChatEmptySubtitle,
            style: AppThemeNotifier.getTextStyleFromTheme(
              color: colorScheme.onSurfaceVariant,
              baseStyle: Theme.of(context).textTheme.bodyMedium,
            ),
          ).animate().fadeIn(duration: 600.ms, delay: 300.ms).move(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(
        context: context,
        textTitle: GetAppLocalizations(context).aiChat,
        showBackButton: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: _messages.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    controller: _scrollController,
                    padding:
                        EdgeInsets.symmetric(vertical: pxToSp(context, 18)),
                    itemCount: _messages.length + (_awaitingAssistant ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index < _messages.length) {
                        return _buildMessageBubble(_messages[index]);
                      }
                      return _buildAssistantLoadingRow();
                    },
                  ),
          ),
          _buildInputField(),
        ],
      ),
    );
  }
}
