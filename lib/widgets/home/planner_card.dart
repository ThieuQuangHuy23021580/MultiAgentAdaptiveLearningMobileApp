import 'package:flutter/material.dart';
import 'package:multi_agent_adaptive_learning_app/cores/theme/app_colors.dart';
import 'package:multi_agent_adaptive_learning_app/widgets/home/glass_card.dart';

class PlannerCard extends StatelessWidget {
  const PlannerCard({super.key});

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
            child: const Icon(Icons.calendar_month, color: AppColors.primary),
          ),

          const Spacer(),

          Text("Study Planner", style: Theme.of(context).textTheme.titleMedium),

          const SizedBox(height: 8),

          const Text("Upcoming: Physics Midterm in 4 days"),

          const SizedBox(height: 16),

          FilledButton(onPressed: () {}, child: const Text("View Schedule")),
        ],
      ),
    );
  }
}
