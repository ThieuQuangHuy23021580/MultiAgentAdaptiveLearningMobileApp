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
    return ClipRRect(
      borderRadius: BorderRadius.circular(40),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
        child: Container(
          height: 68,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.white.withOpacity(0.20),
                Colors.white.withOpacity(0.08),
              ],
            ),
            color: Colors.white.withOpacity(.10),
            borderRadius: BorderRadius.circular(40),
            border: Border.all(
              color: Colors.white.withOpacity(.25),
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.12),
                blurRadius: 35,
                spreadRadius: 1,
                offset: const Offset(0, 18),
              ),

              BoxShadow(
                color: Colors.white.withOpacity(.15),
                blurRadius: 8,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: Row(
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
      ),
    );
  }

  Widget _item(IconData icon, int index) {
    final selected = index == currentIndex;

    return InkWell(
      borderRadius: BorderRadius.circular(30),
      onTap: () => onTap(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: selected ? AppColors.primary : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          size: 24,
          color: selected ? Colors.white : Colors.grey.shade700,
        ),
      ),
    );
  }
}
