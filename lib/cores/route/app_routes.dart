import 'package:go_router/go_router.dart';
import 'package:multi_agent_adaptive_learning_app/features/ai/presentations/screens/ai_screen.dart';
import 'package:multi_agent_adaptive_learning_app/features/home/presentations/screens/home_screen.dart';
import 'package:multi_agent_adaptive_learning_app/features/insight/presentations/screens/insight_screen.dart';
import 'package:multi_agent_adaptive_learning_app/features/profile/presentations/screens/profile_screen.dart';
import 'package:multi_agent_adaptive_learning_app/features/workspace/presentations/screens/workspace_screen.dart';

import '../../navigation/main_navigation.dart';
import 'route_names.dart';

class AppRoutes {
  AppRoutes._();

  static final GoRouter router = GoRouter(
    initialLocation: RouteNames.home,

    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainNavigation(navigationShell: navigationShell);
        },

        branches: [
          /// HOME
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.home,
                name: RouteNames.home,
                builder: (_, __) => const HomeScreen(),
              ),
            ],
          ),

          /// WORKSPACE
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.workspace,
                name: RouteNames.workspace,
                builder: (_, __) => const WorkspaceScreen(),
              ),
            ],
          ),

          /// AI
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.ai,
                name: RouteNames.ai,
                builder: (_, __) => const AIScreen(),
              ),
            ],
          ),

          /// INSIGHT
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.insights,
                name: RouteNames.insights,
                builder: (_, __) => const InsightsScreen(),
              ),
            ],
          ),

          /// PROFILE
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.profile,
                name: RouteNames.profile,
                builder: (_, __) => const ProfileScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
