import 'package:flutter/material.dart';
import 'package:multi_agent_adaptive_learning_app/features/ai/widgets/agent_carousel.dart';
import 'package:multi_agent_adaptive_learning_app/features/ai/widgets/start_session_buttons.dart';
import 'package:multi_agent_adaptive_learning_app/features/ai/widgets/team_mode_button.dart';
import 'package:multi_agent_adaptive_learning_app/features/solo_session/presentations/screens/solo_session_screen.dart';
import 'package:multi_agent_adaptive_learning_app/features/team_session/presentation/screens/team_session_screen.dart';

import '../../../../cores/theme/app_colors.dart';

class AIScreen extends StatelessWidget {
  const AIScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,

        title: const Text(
          "Neo OS",
          style: TextStyle(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),

        leading: const Icon(Icons.menu),

        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: CircleAvatar(
              radius: 18,
              backgroundImage: NetworkImage("https://i.pravatar.cc/150"),
            ),
          ),
        ],
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 150),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // SessionContextCard(),
              const Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  children: [
                    const Text(
                      "Select Your Agent",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    const Text(
                      "Choose a specialized AI to assist with your current task.",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Color(0xff667085)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              const AgentCarousel(),

              const SizedBox(height: 12),

              Align(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    StartSessionButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const SoloSessionScreen(),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 18),

                    SwitchTeamModeButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const TeamSessionScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }
}
