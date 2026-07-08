import 'package:flutter/material.dart';
import 'package:multi_agent_adaptive_learning_app/cores/theme/app_colors.dart';
import 'package:multi_agent_adaptive_learning_app/widgets/home/glass_card.dart';

class FlashCardCard extends StatelessWidget {
  const FlashCardCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: AppColors.surfaceHighest,
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(Icons.style, size: 32, color: AppColors.primary),
          ),

          const SizedBox(height: 10),

          Text(
            "Smart Flashcards",
            style: Theme.of(context).textTheme.titleLarge,
          ),

          const SizedBox(height: 10),

          const Text("15 due for review"),
        ],
      ),
    );
  }
}
