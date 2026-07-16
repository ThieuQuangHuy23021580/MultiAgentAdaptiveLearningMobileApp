import 'dart:ui';
import 'package:flutter/material.dart';

import '../../../../cores/theme/app_colors.dart';

class WorkspaceHeader extends StatelessWidget {
  const WorkspaceHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Title
        const Text(
          "My Workspace",
          style: TextStyle(
            fontSize: 34,
            fontWeight: FontWeight.w800,
            color: Color(0xff1F2937),
            letterSpacing: -.6,
          ),
        ),

        const SizedBox(height: 8),

        Text(
          "Organize your learning streams and AI projects.",
          style: TextStyle(
            fontSize: 16,
            height: 1.5,
            color: Colors.grey.shade600,
          ),
        ),

        const SizedBox(height: 28),

        Row(
          children: [
            Expanded(
              child: _glassButton(
                icon: Icons.tune_rounded,
                title: "Filter",
                filled: false,
              ),
            ),

            const SizedBox(width: 14),

            Expanded(
              child: _glassButton(
                icon: Icons.add_rounded,
                title: "New Stream",
                filled: true,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _glassButton({
    required IconData icon,
    required String title,
    required bool filled,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
        child: Container(
          height: 52,
          decoration: BoxDecoration(
            gradient: filled
                ? const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xff4F8CFF), AppColors.primary],
                  )
                : LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.white.withOpacity(.28),
                      Colors.white.withOpacity(.10),
                    ],
                  ),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: filled
                  ? Colors.transparent
                  : Colors.white.withOpacity(.45),
            ),
            boxShadow: [
              if (filled)
                BoxShadow(
                  color: AppColors.primary.withOpacity(.30),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 20,
                color: filled ? Colors.white : const Color(0xff374151),
              ),

              const SizedBox(width: 8),

              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: filled ? Colors.white : const Color(0xff374151),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
