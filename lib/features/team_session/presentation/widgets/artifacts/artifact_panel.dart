import 'package:flutter/material.dart';
import 'package:multi_agent_adaptive_learning_app/features/team_session/data/models/artifact_item.dart';

import '../../../../../cores/theme/app_colors.dart';
import '../common/glass_panel.dart';
import 'artifact_chip.dart';

class ArtifactPanel extends StatelessWidget {
  const ArtifactPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final artifacts = [
      const ArtifactItem(title: "Summary", icon: Icons.description_outlined),

      const ArtifactItem(title: "Roadmap", icon: Icons.route_outlined),

      const ArtifactItem(title: "Quiz", icon: Icons.quiz_outlined),

      const ArtifactItem(title: "Flashcards", icon: Icons.style_outlined),
    ];

    return GlassPanel(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Expanded(
                child: Text(
                  "ARTIFACTS",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                    letterSpacing: 1,
                  ),
                ),
              ),

              Icon(Icons.auto_awesome, color: AppColors.primary, size: 20),
            ],
          ),

          const SizedBox(height: 8),

          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: artifacts
                .map(
                  (artifact) => ArtifactChip(artifact: artifact, onTap: () {}),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
