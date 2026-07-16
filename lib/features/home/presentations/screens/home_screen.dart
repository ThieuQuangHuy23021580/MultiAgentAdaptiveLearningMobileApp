import 'package:flutter/material.dart';
import 'package:multi_agent_adaptive_learning_app/features/home/presentations/widgets/ai_workspace.dart';
import 'package:multi_agent_adaptive_learning_app/features/home/presentations/widgets/continue_learning_card.dart';
import 'package:multi_agent_adaptive_learning_app/features/home/presentations/widgets/daily_focus_card.dart';
import '../../../../../../cores/theme/app_colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
            children: const [
              DailyFocusCard(),

              SizedBox(height: 24),

              ContinueLearningCard(),

              SizedBox(height: 32),

              AIWorkspace(),

              SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
