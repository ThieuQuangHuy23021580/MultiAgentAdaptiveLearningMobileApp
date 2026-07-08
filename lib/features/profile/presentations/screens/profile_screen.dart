import 'package:flutter/material.dart';
import 'package:multi_agent_adaptive_learning_app/cores/theme/app_colors.dart';
import 'package:multi_agent_adaptive_learning_app/features/profile/data/mocks/fake_profile.dart';
import 'package:multi_agent_adaptive_learning_app/features/profile/presentations/widgets/profile_action_buttons.dart';
import 'package:multi_agent_adaptive_learning_app/features/profile/presentations/widgets/profile_header.dart';
import 'package:multi_agent_adaptive_learning_app/features/profile/presentations/widgets/profile_info_card.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profile =
        fakeProfile; // Replace with actual profile data in a real app

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            24,
            28,
            24,
            120, // chừa BottomNav
          ),
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ProfileHeader(profile: profile),

              const SizedBox(height: 32),

              ProfileInfoCard(profile: profile),

              const SizedBox(height: 24),

              ProfileActionButtons(onEdit: () {}, onShare: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
