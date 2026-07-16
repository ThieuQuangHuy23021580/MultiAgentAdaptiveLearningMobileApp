import 'package:flutter/material.dart';
import '../../../../cores/theme/app_colors.dart';

class SwitchTeamModeButton extends StatelessWidget {
  final VoidCallback onPressed;

  const SwitchTeamModeButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onPressed,
      icon: const Icon(Icons.groups_rounded, size: 20),
      label: const Text(
        "Switch to Team Mode",
        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
      ),
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primary,
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
          side: BorderSide(color: Colors.grey.withOpacity(.25)),
        ),
      ),
    );
  }
}
