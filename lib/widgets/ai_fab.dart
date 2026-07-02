import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:multi_agent_adaptive_learning_app/cores/theme/app_colors.dart';

class AIFloatingButton extends StatelessWidget {
  final VoidCallback onPressed;

  const AIFloatingButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(28),
              onTap: onPressed,
              child: Container(
                width: 58,
                height: 58,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(.16),
                  borderRadius: BorderRadius.circular(28),
                  border: Border.all(color: Colors.white.withOpacity(.55)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.08),
                      blurRadius: 18,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.auto_awesome,
                  color: AppColors.primary,
                  size: 28,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
