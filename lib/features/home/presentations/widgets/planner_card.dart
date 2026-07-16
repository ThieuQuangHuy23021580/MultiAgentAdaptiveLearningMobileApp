import 'package:flutter/material.dart';
import 'package:multi_agent_adaptive_learning_app/cores/theme/app_colors.dart';
import 'package:multi_agent_adaptive_learning_app/features/home/presentations/widgets/glass_card.dart';

class PlannerCard extends StatelessWidget {
  const PlannerCard({super.key});

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
            child: const Icon(
              Icons.calendar_month,
              size: 32,
              color: AppColors.primary,
            ),
          ),

          const SizedBox(height: 10),

          Text("Study Planner", style: Theme.of(context).textTheme.titleLarge),

          const SizedBox(height: 10),

          const Text("Upcoming: Physics Midterm in 4 days"),

          const SizedBox(height: 16),

          FilledButton(onPressed: () {}, child: const Text("View Schedule")),
        ],
      ),
    );
  }
}
