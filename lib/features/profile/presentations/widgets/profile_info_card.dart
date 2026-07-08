import 'package:flutter/material.dart';
import 'package:multi_agent_adaptive_learning_app/cores/theme/app_colors.dart';
import 'package:multi_agent_adaptive_learning_app/features/profile/data/models/profile_model.dart';
import 'package:multi_agent_adaptive_learning_app/features/profile/presentations/widgets/profile_info_tile.dart';

class ProfileInfoCard extends StatelessWidget {
  final ProfileModel profile;

  const ProfileInfoCard({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceLowest,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.outlineVariant.withOpacity(.20)),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          ProfileInfoTile(
            icon: Icons.mail_rounded,
            title: "Email",
            value: profile.email,
          ),

          _divider(),

          ProfileInfoTile(
            icon: Icons.cake_rounded,
            title: "Born",
            value: profile.birthYear.toString(),
          ),

          _divider(),

          ProfileInfoTile(
            icon: Icons.school_rounded,
            title: "Education",
            value: profile.education,
          ),
        ],
      ),
    );
  }

  Widget _divider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Divider(
        height: 1,
        thickness: 1,
        color: AppColors.outlineVariant.withOpacity(.12),
      ),
    );
  }
}
