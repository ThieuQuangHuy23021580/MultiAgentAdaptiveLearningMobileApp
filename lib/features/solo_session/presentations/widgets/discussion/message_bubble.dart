import 'package:flutter/material.dart';
import 'package:multi_agent_adaptive_learning_app/features/solo_session/presentations/widgets/discussion/avatar.dart';

class MessageBubble extends StatelessWidget {
  final String agentName;

  final String avatar;

  final String message;

  final String time;

  final bool isPrimary;

  const MessageBubble({
    super.key,
    required this.agentName,
    required this.avatar,
    required this.message,
    required this.time,
    this.isPrimary = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AgentAvatar(image: avatar),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
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
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    ),
                    border: Border.all(color: Colors.grey.withOpacity(.18)),
                  ),
                  child: Text(
                    message,
                    style: const TextStyle(height: 1.6, fontSize: 15),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
