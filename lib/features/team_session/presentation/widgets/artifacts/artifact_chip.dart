import 'package:flutter/material.dart';
import 'package:multi_agent_adaptive_learning_app/features/team_session/data/models/artifact_item.dart';
import '../../../../../cores/theme/app_colors.dart';

class ArtifactChip extends StatelessWidget {
  final ArtifactItem artifact;
  final VoidCallback? onTap;

  const ArtifactChip({super.key, required this.artifact, this.onTap});

  @override
  Widget build(BuildContext context) {
    final generating = artifact.status == ArtifactStatus.generating;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(.72),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: Colors.grey.withOpacity(.18)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(artifact.icon, color: AppColors.primary, size: 20),

              const SizedBox(width: 10),

              Text(
                artifact.title,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),

              if (generating) ...[
                const SizedBox(width: 12),

                const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
