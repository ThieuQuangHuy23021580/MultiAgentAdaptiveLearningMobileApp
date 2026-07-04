import 'package:flutter/material.dart';
import 'package:multi_agent_adaptive_learning_app/cores/theme/app_colors.dart';

import '../widgets/background_rings.dart';
import '../widgets/message_input.dart';
import '../widgets/quick_actions.dart';
import '../widgets/researcher_avatar.dart';
import '../widgets/session_app_bar.dart';
import '../widgets/speech_bubble.dart';

class SoloSessionPage extends StatefulWidget {
  const SoloSessionPage({super.key});

  @override
  State<SoloSessionPage> createState() => _SoloSessionPageState();
}

class _SoloSessionPageState extends State<SoloSessionPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController bobController;

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
          //--------------------------------------------------
          // Background
          //--------------------------------------------------
          const Positioned.fill(child: BackgroundRings()),

          //--------------------------------------------------
          // Main Content
          //--------------------------------------------------
          SafeArea(
            child: Column(
              children: [
                //--------------------------------------------------
                // App Bar
                //--------------------------------------------------
                const SessionAppBar(),

                //--------------------------------------------------
                // Center Content
                //--------------------------------------------------
                Expanded(
                  child: Center(
                    child: AnimatedBuilder(
                      animation: bobController,
                      builder: (_, __) {
                        final offset = -10 * bobController.value;

                        return Transform.translate(
                          offset: Offset(0, offset),
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Column(
                              children: [
                                //--------------------------------------------------
                                // Speech Bubble
                                //--------------------------------------------------
                                const SpeechBubble(
                                  text:
                                      "I'm searching for reliable resources...",
                                ),

                                const SizedBox(height: 34),

                                //--------------------------------------------------
                                // Avatar
                                //--------------------------------------------------
                                const ResearcherAvatar(),

                                const SizedBox(height: 34),

                                //--------------------------------------------------
                                // Name
                                //--------------------------------------------------
                                const Text(
                                  "Dr. Atlas",
                                  style: TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                const SizedBox(height: 8),

                                const Text(
                                  "Lead Researcher",
                                  style: TextStyle(
                                    fontSize: 17,
                                    color: Color(0xff6B7280),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),

                //--------------------------------------------------
                // Bottom Area
                //--------------------------------------------------
                const SafeArea(
                  top: false,
                  child: Column(
                    children: [
                      QuickActions(),

                      SizedBox(height: 18),

                      MessageInput(),

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
