import 'dart:ui';

import 'package:flutter/material.dart';

class BackgroundRings extends StatelessWidget {
  const BackgroundRings({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xffF8FAFD), Color(0xffEEF4FF)],
            ),
          ),
        ),

        Positioned(
          top: -160,
          left: -120,
          child: _glow(size: 340, color: const Color(0xffD9E8FF)),
        ),

        Positioned(
          top: 120,
          right: -120,
          child: _glow(size: 260, color: const Color(0xffE6F0FF)),
        ),

        Positioned(
          bottom: -180,
          left: -80,
          child: _glow(size: 360, color: const Color(0xffE9F4FF)),
        ),

        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
            child: Container(color: Colors.white.withOpacity(.02)),
          ),
        ),
      ],
    );
  }

  Widget _glow({required double size, required Color color}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            color.withOpacity(.85),
            color.withOpacity(.35),
            Colors.transparent,
          ],
        ),
      ),
    );
  }
}
