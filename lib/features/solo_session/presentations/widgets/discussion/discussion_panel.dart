import 'package:flutter/material.dart';
import 'package:multi_agent_adaptive_learning_app/features/solo_session/presentations/widgets/discussion/typing_bubble.dart';
import '../common/glass_panel.dart';
import 'message_bubble.dart';

class DiscussionPanel extends StatelessWidget {
  const DiscussionPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return GlassPanel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "TEAM DISCUSSION",
            style: TextStyle(
              fontSize: 13,
              letterSpacing: 1.2,
              color: Color.fromARGB(255, 134, 134, 134),
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 20),

          Expanded(
            child: ListView(
              children: const [
                MessageBubble(
                  agentName: "Researcher",
                  avatar:
                      "https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=500",
                  time: "Just now",
                  message:
                      "I've gathered five recent papers about Neural Networks. Transformer architectures dominate recent research and several studies compare CNNs with Vision Transformers.",
                ),

                TypingIndicator(
                  agent: "Summarizer",
                  avatar:
                      "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=500",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
