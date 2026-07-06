import 'package:flutter/material.dart';

class SessionTab extends StatelessWidget {
  final String title;
  final bool hasNotification;

  const SessionTab({
    super.key,
    required this.title,
    this.hasNotification = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(title),

        if (hasNotification) ...[
          const SizedBox(width: 6),

          Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: Color(0xFF22C55E), // Green 500
              shape: BoxShape.circle,
            ),
          ),
        ],
      ],
    );
  }
}
