import 'package:flutter/material.dart';
import 'package:multi_agent_adaptive_learning_app/cores/theme/app_colors.dart';
import 'package:multi_agent_adaptive_learning_app/features/solo_session/data/conversation_message.dart';
import 'package:multi_agent_adaptive_learning_app/features/solo_session/widgets/agent_status_panel.dart';
import 'package:multi_agent_adaptive_learning_app/features/solo_session/widgets/conversation_list.dart';

import '../widgets/background_rings.dart';

import '../widgets/researcher_avatar.dart';
import '../widgets/session_app_bar.dart';

class SoloSessionPage extends StatefulWidget {
  const SoloSessionPage({super.key});

  @override
  State<SoloSessionPage> createState() => _SoloSessionPageState();
}

class _SoloSessionPageState extends State<SoloSessionPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController bobController;
  bool typing = true;

  final List<ConversationMessage> messages = [
    ConversationMessage.ai(
      "Hello 👋\n\nI'm Dr. Atlas.\nHow can I help your research today?",
    ),

    ConversationMessage.user("I need papers about Federated Learning."),

    ConversationMessage.ai(
      "Great!\nI'll search IEEE, ACM and arXiv for reliable papers.",
    ),
  ];

  @override
  void initState() {
    super.initState();

    bobController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    bobController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      resizeToAvoidBottomInset: true,

      body: Stack(
        children: [
          const Positioned.fill(child: BackgroundRings()),

          SafeArea(
            child: Column(
              children: [
                const SessionAppBar(),

                Expanded(
                  child: Column(
                    children: [
                      AnimatedBuilder(
                        animation: bobController,
                        builder: (_, __) {
                          final offset = -10 * bobController.value;

                          return Transform.translate(
                            offset: Offset(0, offset),
                            child: Column(
                              children: const [
                                ResearcherAvatar(),

                                SizedBox(height: 18),

                                Text(
                                  "Dr. Atlas",
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                SizedBox(height: 6),

                                Text(
                                  "Lead Researcher",
                                  style: TextStyle(color: Color(0xff6B7280)),
                                ),
                              ],
                            ),
                          );
                        },
                      ),

                      const SizedBox(height: 24),

                      Expanded(
                        child: ConversationList(
                          messages: messages,
                          isTyping: typing,
                        ),
                      ),

                      const SizedBox(height: 20),

                      const AgentStatusPanel(),
                    ],
                  ),
                ),

                //--------------------------------------------------
                // Bottom Area
                //--------------------------------------------------
                const SafeArea(
                  top: false,
                  child: Column(
                    children: [
                      // QuickActions(),
                      SizedBox(height: 18),

                      // MessageInput(),
                      SizedBox(height: 18),
                    ],
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
