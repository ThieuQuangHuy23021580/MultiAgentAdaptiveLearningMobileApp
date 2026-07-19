import 'dart:ui';

import 'package:flutter/material.dart';

class HistoryErrorCard extends StatelessWidget {
  const HistoryErrorCard({
    required this.title,
    required this.message,
    required this.onRefresh,
  });

  final String title;
  final String message;
  final VoidCallback onRefresh;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xffFEF2F2),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xffFECACA)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Color(0xff991B1B),
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          Text(message, style: const TextStyle(color: Color(0xff991B1B))),
          const SizedBox(height: 8),
          TextButton(onPressed: onRefresh, child: const Text('Retry')),
        ],
      ),
    );
  }
}
