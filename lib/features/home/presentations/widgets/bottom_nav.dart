import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:multi_agent_adaptive_learning_app/cores/theme/app_colors.dart';

class NeoBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const NeoBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.18),
            blurRadius: 55,
            spreadRadius: -8,
            offset: const Offset(0, 28),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(40),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 45, sigmaY: 45),
          child: Container(
            height: 76,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white.withOpacity(.22),
                  Colors.white.withOpacity(.12),
                  Colors.white.withOpacity(.04),
                ],
                stops: const [0.0, 0.45, 1.0],
              ),
              borderRadius: BorderRadius.circular(40),
              border: Border.all(
                color: Colors.white.withOpacity(.55),
                width: 1.2,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(.08),
                  blurRadius: 60,
                  spreadRadius: -8,
                  offset: const Offset(0, 20),
                ),

                BoxShadow(
                  color: Colors.white.withOpacity(.18),
                  blurRadius: 14,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Stack(
              children: [
                // Highlight mép trên
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 26),
                  height: 2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    gradient: LinearGradient(
                      colors: [
                        Colors.white.withOpacity(.95),
                        Colors.white.withOpacity(.35),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),

                Positioned.fill(
                  child: IgnorePointer(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.white.withOpacity(.18),
                            Colors.transparent,
                            Colors.white.withOpacity(.05),
                          ],
                          stops: const [0.0, 0.45, 1.0],
                        ),
                      ),
                    ),
                  ),
                ),

                Positioned.fill(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _item(Icons.home_rounded, 0),
                      _item(Icons.grid_view_rounded, 1),
                      _item(Icons.auto_awesome_rounded, 2),
                      _item(Icons.insights_rounded, 3),
                      _item(Icons.person_rounded, 4),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 1,
                  left: 22,
                  right: 22,
                  child: Container(
                    height: 1,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.black.withOpacity(.06),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _item(IconData icon, int index) {
    final selected = index == currentIndex;

    return InkWell(
      borderRadius: BorderRadius.circular(30),
      onTap: () => onTap(index),
      child: AnimatedScale(
        scale: selected ? 1.02 : 1.0,
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOut,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOut,
          transform: Matrix4.identity()..translate(0.0, selected ? -2.0 : 0.0),
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: selected
                ? const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF3B82F6), // sáng hơn
                      Color(0xFF2563EB), // đậm hơn
                    ],
                  )
                : null,
            color: selected ? null : Colors.transparent,
            boxShadow: selected
                ? [
                    BoxShadow(
                      color: const Color(0xFF2563EB).withOpacity(0.35),
                      blurRadius: 16,
                      spreadRadius: -2,
                      offset: const Offset(0, 6),
                    ),
                  ]
                : null,
          ),
          child: Icon(
            icon,
            size: 24,
            color: selected ? Colors.white : const Color(0xFF4B5563),
          ),
        ),
      ),
    );
  }
}
