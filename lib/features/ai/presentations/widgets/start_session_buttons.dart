import 'package:flutter/material.dart';
import '../../../../cores/theme/app_colors.dart';

class StartSessionButton extends StatelessWidget {
  final VoidCallback onPressed;

  const StartSessionButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 230,
      height: 54,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: const Icon(Icons.play_arrow_rounded, size: 22),
        label: const Text(
          "Start Solo Session",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        style: ElevatedButton.styleFrom(
          elevation: 4,
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
        ),
      ),
    );
  }
}
