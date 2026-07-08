import 'package:flutter/material.dart';
import 'package:multi_agent_adaptive_learning_app/cores/theme/app_colors.dart';
import 'package:multi_agent_adaptive_learning_app/widgets/home/glass_card.dart';

class AnalyzePDFCard extends StatelessWidget {
  const AnalyzePDFCard({super.key});

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
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.picture_as_pdf,
              color: AppColors.primary,
              size: 32,
            ),
          ),

          const SizedBox(height: 10),

          Text("Analyze PDF", style: Theme.of(context).textTheme.titleLarge),

          const SizedBox(height: 10),

          Text(
            "Drop a syllabus or textbook chapter here to instantly generate summaries, key terms and learning objectives.",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
