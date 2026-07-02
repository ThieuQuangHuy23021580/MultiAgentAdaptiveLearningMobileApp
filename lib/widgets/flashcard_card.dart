import 'package:flutter/material.dart';
import 'package:multi_agent_adaptive_learning_app/cores/theme/app_colors.dart';
import 'package:multi_agent_adaptive_learning_app/widgets/glass_card.dart';

class FlashCardCard extends StatelessWidget {
  const FlashCardCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.surfaceHighest,
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(Icons.style, color: AppColors.primary),
          ),

          const Spacer(),

          Text(
            "Smart Flashcards",
            style: Theme.of(context).textTheme.titleMedium,
          ),

          const SizedBox(height: 8),

          const Text("15 due for review"),
        ],
      ),
    );
  }
}
