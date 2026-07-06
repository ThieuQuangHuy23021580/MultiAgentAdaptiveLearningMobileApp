import 'package:flutter/material.dart';

import '../../../../../cores/theme/app_colors.dart';

class SendButton extends StatelessWidget {
  final bool enabled;

  final VoidCallback onPressed;

  const SendButton({super.key, required this.enabled, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: enabled ? 1 : .88,
      duration: const Duration(milliseconds: 180),
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 180),
        opacity: enabled ? 1 : .45,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: enabled ? onPressed : null,
            borderRadius: BorderRadius.circular(100),
            child: Ink(
              width: 52,
              height: 52,
              decoration: const BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.send_rounded, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
