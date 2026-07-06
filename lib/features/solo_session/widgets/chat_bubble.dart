import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:multi_agent_adaptive_learning_app/features/solo_session/data/conversation_message.dart';
import '../../../../cores/theme/app_colors.dart';

class ChatBubble extends StatelessWidget {
  final ConversationMessage message;

  const ChatBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final isAI = message.role == MessageRole.ai;

    return Align(
      alignment: isAI ? Alignment.centerLeft : Alignment.centerRight,
      child: Row(
        mainAxisAlignment: isAI
            ? MainAxisAlignment.start
            : MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (isAI) ...[
            Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary.withOpacity(.12),
              ),
              child: const Icon(
                Icons.auto_awesome,
                size: 18,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(width: 12),
          ],

          Flexible(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 16,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: isAI
                          ? [
                              Colors.white.withOpacity(.65),
                              Colors.white.withOpacity(.32),
                            ]
                          : [
                              AppColors.primary.withOpacity(.95),
                              AppColors.primary.withOpacity(.82),
                            ],
                    ),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: isAI
                          ? Colors.white.withOpacity(.75)
                          : Colors.white.withOpacity(.18),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(.06),
                        blurRadius: 24,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        message.text,
                        style: TextStyle(
                          height: 1.6,
                          fontSize: 15,
                          color: isAI ? const Color(0xff344054) : Colors.white,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          message.time,
                          style: TextStyle(
                            fontSize: 11,
                            color: isAI ? Colors.grey : Colors.white70,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          if (!isAI) ...[
            const SizedBox(width: 12),
            Container(
              width: 34,
              height: 34,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xffDDE5F4),
              ),
              child: const Icon(
                Icons.person,
                size: 18,
                color: Color(0xff667085),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
