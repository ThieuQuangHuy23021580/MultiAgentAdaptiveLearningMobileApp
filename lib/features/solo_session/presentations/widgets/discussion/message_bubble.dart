import 'package:flutter/material.dart';
import 'package:multi_agent_adaptive_learning_app/features/solo_session/presentations/widgets/discussion/avatar.dart';
import 'package:multi_agent_adaptive_learning_app/features/solo_session/presentations/widgets/discussion/formatted_message.dart';

class MessageBubble extends StatelessWidget {
  final String agentName;

  final String avatar;

  final String message;

  final String time;

  final bool isPrimary;

  final bool isUser;

  const MessageBubble({
    super.key,
    required this.agentName,
    required this.avatar,
    required this.message,
    required this.time,
    this.isPrimary = false,
    this.isUser = false,
  });

  @override
  Widget build(BuildContext context) {
    if (!isUser) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AgentAvatar(image: avatar),

                const SizedBox(width: 14),

                Text(
                  agentName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),

                const SizedBox(width: 10),

                Text(
                  time,
                  style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
                ),
              ],
            ),

            const SizedBox(height: 10),

            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: isPrimary ? const Color(0xffE8F0FF) : Colors.white,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
                border: Border.all(color: Colors.grey.withOpacity(.18)),
              ),
              child: FormattedMessage(message: message, isUser: isUser),
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment:
            isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Flexible(
            child: Column(
              crossAxisAlignment:
                  isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      agentName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),

                    const SizedBox(width: 10),

                    Text(
                      time,
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: isPrimary ? const Color(0xffE8F0FF) : Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(isUser ? 20 : 4),
                      topRight: Radius.circular(isUser ? 4 : 20),
                      bottomRight: const Radius.circular(20),
                      bottomLeft: const Radius.circular(20),
                    ),
                    border: Border.all(color: Colors.grey.withOpacity(.18)),
                  ),
                  child: FormattedMessage(message: message, isUser: isUser),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
