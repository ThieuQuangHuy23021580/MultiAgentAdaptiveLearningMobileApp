import 'package:flutter/material.dart';
import 'package:multi_agent_adaptive_learning_app/cores/theme/app_colors.dart';
import 'package:multi_agent_adaptive_learning_app/features/profile/data/models/profile_model.dart';
import 'package:multi_agent_adaptive_learning_app/features/profile/presentations/widgets/profile_avatar.dart';

class ProfileHeader extends StatelessWidget {
  final ProfileModel profile;

  const ProfileHeader({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        ProfileAvatar(imageUrl: profile.avatar, level: profile.level),

        const SizedBox(height: 20),

        Text(
          profile.name,
          textAlign: TextAlign.center,
          style: theme.textTheme.headlineMedium?.copyWith(
            color: AppColors.onSurface,
            fontWeight: FontWeight.w700,
            letterSpacing: -.8,
          ),
        ),

        const SizedBox(height: 6),

        Text(
          profile.title,
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyLarge?.copyWith(
            color: AppColors.secondary,
          ),
        ),
      ],
    );
  }
}
