import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../../cores/theme/app_colors.dart';

class TypingIndicator extends StatefulWidget {
  const TypingIndicator({super.key});

  @override
  State<TypingIndicator> createState() => _TypingIndicatorState();
}

class _TypingIndicatorState extends State<TypingIndicator>
    with TickerProviderStateMixin {
  late final AnimationController pulseController;
  late final AnimationController shimmerController;

  int currentText = 0;

  final texts = [
    "Thinking...",
    "Searching knowledge...",
    "Reading documents...",
    "Generating response...",
  ];

  Timer? timer;

  @override
  void initState() {
    super.initState();

    pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);

    shimmerController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    timer = Timer.periodic(const Duration(seconds: 3), (_) {
      if (!mounted) return;

      setState(() {
        currentText++;

        if (currentText >= texts.length) {
          currentText = 0;
        }
      });
    });
  }

  @override
  void dispose() {
    pulseController.dispose();
    shimmerController.dispose();
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.primary.withOpacity(.12),
          ),
          child: const Icon(
            Icons.auto_awesome,
            size: 18,
            color: AppColors.primary,
          ),
        ),

        const SizedBox(width: 12),

        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(22),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              child: AnimatedBuilder(
                animation: Listenable.merge([
                  pulseController,
                  shimmerController,
                ]),
                builder: (_, __) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 18,
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.white.withOpacity(.72),
                          Colors.white.withOpacity(.42),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(22),
                      border: Border.all(color: Colors.white.withOpacity(.82)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          texts[currentText],
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Color(0xff344054),
                          ),
                        ),

                        const SizedBox(height: 14),

                        Row(
                          children: List.generate(3, (index) {
                            final animation =
                                ((pulseController.value * 3) - index).clamp(
                                  0.0,
                                  1.0,
                                );

                            return Container(
                              margin: const EdgeInsets.only(right: 8),
                              child: Transform.scale(
                                scale: .75 + animation * .45,
                                child: Opacity(
                                  opacity: .35 + animation * .65,
                                  child: Container(
                                    width: 9,
                                    height: 9,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
