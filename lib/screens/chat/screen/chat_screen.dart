import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/chat/bloc/chat_bloc.dart';
import '../../../core/chat/repository/chat_repository.dart';
import '../body/chat_body.dart';

/// Thin screen — provides BLoC, stays out of UI logic.
class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ChatBloc(
        repository: ChatRepository(),
      ),
      child: const ChatBody(),
    );
  }
}
