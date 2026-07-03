import 'package:flutter/material.dart';
import 'package:multi_agent_adaptive_learning_app/cores/theme/app_colors.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'glass_card.dart';

class DailyFocusCard extends StatelessWidget {
  const DailyFocusCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: [
            Text(
              "Good Morning, Alex",
              style: Theme.of(context).textTheme.headlineMedium,
            ),

            const SizedBox(height: 8),

            Text(
              "You have 2 goals for today.",
              style: Theme.of(context).textTheme.bodyMedium,
            ),

            const SizedBox(height: 28),

            CircularPercentIndicator(
              radius: 70,

              lineWidth: 10,

              percent: .70,

              animation: true,

              animationDuration: 1200,

              circularStrokeCap: CircularStrokeCap.round,

              progressColor: AppColors.primary,

              backgroundColor: Colors.grey.shade300,

              center: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "70%",
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    "DAILY ARC",
                    style: TextStyle(
                      letterSpacing: 2,
                      color: Colors.grey,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
