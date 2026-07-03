import 'package:flutter/material.dart';
import 'package:multi_agent_adaptive_learning_app/widgets/home/analyzepdf_card.dart';
import 'package:multi_agent_adaptive_learning_app/widgets/home/flashcard_card.dart';
import 'package:multi_agent_adaptive_learning_app/widgets/home/planner_card.dart';
import 'package:multi_agent_adaptive_learning_app/widgets/home/quiz_card.dart';

class AIWorkspace extends StatelessWidget {
  const AIWorkspace({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("AI Workspace", style: Theme.of(context).textTheme.headlineMedium),

        const SizedBox(height: 20),

        LayoutBuilder(
          builder: (context, constraints) {
            int crossAxisCount = 1;

            if (constraints.maxWidth > 1100) {
              crossAxisCount = 3;
            } else if (constraints.maxWidth > 700) {
              crossAxisCount = 2;
            }

            return GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              childAspectRatio: 1.1,
              children: const [
                AnalyzePDFCard(),
                FlashCardCard(),
                QuizCard(),
                PlannerCard(),
              ],
            );
          },
        ),
      ],
    );
  }
}
