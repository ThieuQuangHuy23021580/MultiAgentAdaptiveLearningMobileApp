import 'package:flutter/material.dart';
import 'package:multi_agent_adaptive_learning_app/cores/theme/app_colors.dart';

import 'glass_card.dart';

class ContinueLearningCard extends StatelessWidget {
  const ContinueLearningCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isMobile = constraints.maxWidth < 700;

          if (isMobile) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _bookCover(),
                const SizedBox(height: 24),
                _content(context),
              ],
            );
          }

          return Row(
            children: [
              SizedBox(width: 180, child: _bookCover()),
              const SizedBox(width: 28),
              Expanded(child: _content(context)),
            ],
          );
        },
      ),
    );
  }

  Widget _bookCover() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: AspectRatio(
        aspectRatio: 1,
        child: Image.network(
          "https://images.unsplash.com/photo-1516979187457-637abb4f9353?w=800",
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _content(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "RESUME SESSION",
          style: TextStyle(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
            fontSize: 12,
          ),
        ),

        const SizedBox(height: 12),

        Text(
          "Advanced Quantum Mechanics",
          style: Theme.of(
            context,
          ).textTheme.headlineLarge?.copyWith(fontSize: 30),
        ),

        const SizedBox(height: 18),

        Text(
          "Chapter 4: Wave Function Collapse.\nYou left off at section 4.2.",
          style: Theme.of(context).textTheme.bodyLarge,
        ),

        const SizedBox(height: 28),

        FilledButton.icon(
          style: FilledButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 18),
            shape: const StadiumBorder(),
          ),
          onPressed: () {},
          icon: const Icon(Icons.arrow_forward),
          label: const Text("Continue"),
        ),
      ],
    );
  }
}
