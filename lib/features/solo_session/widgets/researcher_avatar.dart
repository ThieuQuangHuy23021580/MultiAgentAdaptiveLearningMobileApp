import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../../cores/theme/app_colors.dart';

class ResearcherAvatar extends StatefulWidget {
  const ResearcherAvatar({super.key});

  @override
  State<ResearcherAvatar> createState() => _ResearcherAvatarState();
}

class _ResearcherAvatarState extends State<ResearcherAvatar>
    with TickerProviderStateMixin {
  late final AnimationController glowController;
  late final AnimationController rotateController;

  @override
  void initState() {
    super.initState();

    glowController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    rotateController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 18),
    )..repeat();
  }

  @override
  void dispose() {
    glowController.dispose();
    rotateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      height: 250,
      child: AnimatedBuilder(
        animation: Listenable.merge([glowController, rotateController]),
        builder: (_, __) {
          final glow = 18 + glowController.value * 16;

          return Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 220,
                height: 220,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(.15),
                      blurRadius: 80,
                      spreadRadius: glow,
                    ),
                  ],
                ),
              ),

              Transform.rotate(
                angle: rotateController.value * pi * 2,
                child: Container(
                  width: 205,
                  height: 205,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.primary.withOpacity(.18),
                      width: 2,
                    ),
                  ),
                ),
              ),

              Transform.rotate(
                angle: -(rotateController.value * pi * 2),
                child: Container(
                  width: 182,
                  height: 182,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white.withOpacity(.85),
                      width: 1.5,
                    ),
                  ),
                ),
              ),

              ClipOval(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
                  child: Container(
                    width: 170,
                    height: 170,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.white.withOpacity(.55),
                          Colors.white.withOpacity(.18),
                        ],
                      ),
                      border: Border.all(color: Colors.white.withOpacity(.75)),
                    ),
                  ),
                ),
              ),

              Hero(
                tag: "researcher-avatar",
                child: Container(
                  width: 145,
                  height: 145,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: const DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        "https://images.unsplash.com/photo-1516321318423-f06f85e504b3?w=800",
                      ),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(.12),
                        blurRadius: 28,
                        offset: const Offset(0, 12),
                      ),
                    ],
                  ),
                ),
              ),

              Container(
                width: 170,
                height: 170,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white.withOpacity(.35)),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
