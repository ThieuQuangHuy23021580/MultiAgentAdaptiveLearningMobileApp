import 'package:flutter/material.dart';
import 'package:multi_agent_adaptive_learning_app/features/home/presentations/widgets/analyzepdf_card.dart';
import 'package:multi_agent_adaptive_learning_app/features/home/presentations/widgets/flashcard_card.dart';
import 'package:multi_agent_adaptive_learning_app/features/home/presentations/widgets/planner_card.dart';
import 'package:multi_agent_adaptive_learning_app/features/home/presentations/widgets/quiz_card.dart';

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
            int columns = 1;

            if (constraints.maxWidth > 1100) {
              columns = 3;
            } else if (constraints.maxWidth > 700) {
              columns = 2;
            }

            const spacing = 20.0;

            final itemWidth =
                (constraints.maxWidth - (columns - 1) * spacing) / columns;

            return Wrap(
              spacing: spacing,
              runSpacing: spacing,
              children: [
                SizedBox(width: itemWidth, child: const AnalyzePDFCard()),
                SizedBox(width: itemWidth, child: const FlashCardCard()),
                SizedBox(width: itemWidth, child: const QuizCard()),
                SizedBox(width: itemWidth, child: const PlannerCard()),
              ],
            );
          },
        ),
      ],
    );
  }
}
