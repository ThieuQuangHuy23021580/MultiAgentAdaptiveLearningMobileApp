import 'package:flutter/material.dart';
import 'package:multi_agent_adaptive_learning_app/cores/theme/app_colors.dart';
import 'package:multi_agent_adaptive_learning_app/features/insights/models/ai_insight.dart';
import 'package:multi_agent_adaptive_learning_app/features/insights/widgets/ai/recommendation_tile.dart';

class AiSummaryCard extends StatelessWidget {
  const AiSummaryCard({super.key});

  static const AIInsight insight = AIInsight(
    title: "Learning Pattern",
    summary:
        "You reach peak cognitive performance between 9:00 AM and 11:00 AM. "
        "After approximately 45 minutes of continuous study, your retention "
        "begins to decline. Scheduling intensive learning sessions during the "
        "morning and taking short breaks every 45 minutes can significantly "
        "improve long-term retention.",
    recommendations: [
      "Use focused 45-minute study sessions.",
      "Move difficult reading tasks to the morning.",
    ],
  );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      height: 360,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.outline.withOpacity(.08)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.04),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            top: -50,
            right: -40,
            child: Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(.08),
                shape: BoxShape.circle,
              ),
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(.12),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.auto_awesome_rounded,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      insight.title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              Text(
                insight.summary,
                style: theme.textTheme.bodyMedium?.copyWith(
                  height: 1.55,
                  color: AppColors.onSurfaceVariant,
                ),
              ),

              const Spacer(),

              RecommendationTile(
                icon: Icons.lightbulb_outline_rounded,
                text: insight.recommendations[0],
              ),

              const SizedBox(height: 12),

              RecommendationTile(
                icon: Icons.schedule_rounded,
                text: insight.recommendations[1],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
