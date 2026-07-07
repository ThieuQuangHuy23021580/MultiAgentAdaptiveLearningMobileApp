import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:multi_agent_adaptive_learning_app/cores/theme/app_colors.dart';

class InsightsAppBar extends StatelessWidget implements PreferredSizeWidget {
  const InsightsAppBar({super.key, this.onMenuPressed, this.onAvatarPressed});

  final VoidCallback? onMenuPressed;
  final VoidCallback? onAvatarPressed;

  @override
  Size get preferredSize => const Size.fromHeight(76);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
        child: AppBar(
          elevation: 0,
          centerTitle: false,
          scrolledUnderElevation: 0,
          backgroundColor: AppColors.background.withOpacity(.85),

          leadingWidth: 64,

          leading: Padding(
            padding: const EdgeInsets.only(left: 16),
            child: IconButton.filledTonal(
              onPressed: onMenuPressed,
              icon: const Icon(Icons.menu_rounded),
            ),
          ),

          titleSpacing: 4,

          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Learning Insights",
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.onBackground,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                "Weekly learning analytics",
                style: theme.textTheme.bodySmall?.copyWith(
                  color: AppColors.onSurfaceVariant,
                ),
              ),
            ],
          ),

          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: InkWell(
                borderRadius: BorderRadius.circular(100),
                onTap: onAvatarPressed,
                child: Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: AppColors.surfaceContainer,
                    borderRadius: BorderRadius.circular(22),
                    border: Border.all(
                      color: AppColors.outline.withOpacity(.15),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(22),
                    child: Image.network(
                      "https://i.pravatar.cc/150?img=12",
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) {
                        return Icon(
                          Icons.person_rounded,
                          color: AppColors.primary,
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
