import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:multi_agent_adaptive_learning_app/features/home/presentations/widgets/ai_fab.dart';
import 'package:multi_agent_adaptive_learning_app/features/home/presentations/widgets/bottom_nav.dart';

class MainNavigation extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const MainNavigation({super.key, required this.navigationShell});

  void _onTap(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,

      body: Stack(
        children: [
          navigationShell,

          Positioned(
            left: 24,
            right: 24,
            bottom: 24,
            child: NeoBottomNav(
              currentIndex: navigationShell.currentIndex,
              onTap: _onTap,
            ),
          ),

          // Positioned(
          //   right: 34,
          //   bottom: 110,
          //   child: AIFloatingButton(onPressed: () => _onTap(2)),
          // ),
        ],
      ),
    );
  }
}
