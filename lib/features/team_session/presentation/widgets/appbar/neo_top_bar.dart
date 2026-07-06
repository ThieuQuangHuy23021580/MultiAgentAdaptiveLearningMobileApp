import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:auto_size_text/auto_size_text.dart';

import '../../../../../cores/theme/app_colors.dart';

class NeoTopBar extends StatelessWidget implements PreferredSizeWidget {
  final String sessionTitle;

  final String sessionType;

  final VoidCallback? onMenuPressed;

  final VoidCallback? onClosePressed;

  const NeoTopBar({
    super.key,
    required this.sessionTitle,
    this.sessionType = "Multi-Agent Adaptive Learning",
    this.onMenuPressed,
    this.onClosePressed,
  });

  @override
  Size get preferredSize => const Size.fromHeight(108);

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;

    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
        child: Container(
          height: preferredSize.height + topPadding,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(.82),
            border: Border(
              bottom: BorderSide(color: Colors.grey.withOpacity(.12)),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.03),
                blurRadius: 22,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _circleButton(Icons.menu_rounded, onMenuPressed),

                  const SizedBox(width: 18),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),

                        AutoSizeText(
                          sessionTitle,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          minFontSize: 16,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                            height: 1.2,
                          ),
                        ),

                        AutoSizeText(
                          sessionType,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          minFontSize: 12,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 16),

                  _circleButton(Icons.close_rounded, onClosePressed),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _circleButton(IconData icon, VoidCallback? onTap) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(100),
        child: Ink(
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(.60),
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white.withOpacity(.45)),
          ),
          child: Icon(icon, color: AppColors.primary, size: 24),
        ),
      ),
    );
  }
}
