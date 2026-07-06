import 'package:flutter/material.dart';
import 'package:multi_agent_adaptive_learning_app/features/solo_session/data/conversation_message.dart';
import 'package:multi_agent_adaptive_learning_app/features/solo_session/widgets/chat_bubble.dart';
import 'package:multi_agent_adaptive_learning_app/features/solo_session/widgets/typing_indicator.dart';

class ConversationList extends StatelessWidget {
  final List<ConversationMessage> messages;
  final bool isTyping;

  const ConversationList({
    super.key,
    required this.messages,
    required this.isTyping,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      reverse: true,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
      itemCount: messages.length + (isTyping ? 1 : 0),
      itemBuilder: (_, index) {
        if (isTyping && index == 0) {
          return const Padding(
            padding: EdgeInsets.only(bottom: 18),
            child: TypingIndicator(),
          );
        }

        final message =
            messages[messages.length - 1 - (index - (isTyping ? 1 : 0))];

        return Padding(
          padding: const EdgeInsets.only(bottom: 18),
          child: ChatBubble(message: message),
        );
      },
    );
  }
}
