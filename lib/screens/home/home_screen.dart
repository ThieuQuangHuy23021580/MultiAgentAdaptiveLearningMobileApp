import 'package:flutter/material.dart';
import 'package:multi_agent_adaptive_learning_app/cores/theme/app_colors.dart';
import 'package:multi_agent_adaptive_learning_app/widgets/ai_fab.dart';
import 'package:multi_agent_adaptive_learning_app/widgets/ai_workspace.dart';
import 'package:multi_agent_adaptive_learning_app/widgets/bottom_nav.dart';
import 'package:multi_agent_adaptive_learning_app/widgets/continue_learning_card.dart';
import 'package:multi_agent_adaptive_learning_app/widgets/daily_focus_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      extendBody: true,

      appBar: AppBar(
        title: const Text(
          "Adapto AI",
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

      body: Stack(
        children: [
          /// Nội dung
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const DailyFocusCard(),

                  const SizedBox(height: 24),

                  const ContinueLearningCard(),

                  const SizedBox(height: 32),

                  const AIWorkspace(),

                  const SizedBox(height: 32),

                  /// Insight...
                  const SizedBox(height: 160), // để chừa chỗ cho BottomNav
                ],
              ),
            ),
          ),

          /// Bottom Navigation
          Positioned(
            left: 24,
            right: 24,
            bottom: 24,
            child: NeoBottomNav(
              currentIndex: index,
              onTap: (i) {
                setState(() {
                  index = i;
                });
              },
            ),
          ),

          /// AI FAB
          // Positioned(
          //   right: 34,
          //   bottom: 110,
          //   child: AIFloatingButton(onPressed: () {}),
          // ),
        ],
      ),
    );
  }
}
