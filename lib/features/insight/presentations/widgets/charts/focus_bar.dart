import 'package:flutter/material.dart';
import 'package:multi_agent_adaptive_learning_app/cores/theme/app_colors.dart';

class FocusBar extends StatelessWidget {
  const FocusBar({
    super.key,
    required this.value,
    required this.maxValue,
    required this.highlight,
  });

  final double value;
  final double maxValue;
  final bool highlight;

  @override
  Widget build(BuildContext context) {
    final height = (value / maxValue) * 170;

    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: height),
            duration: const Duration(milliseconds: 700),
            curve: Curves.easeOutCubic,
            builder: (_, h, __) {
              return Container(
                width: 24,
                height: h,
                decoration: BoxDecoration(
                  color: highlight
                      ? AppColors.primary
                      : AppColors.surfaceHighest,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(8),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
