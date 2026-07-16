import 'dart:ui';

import 'package:flutter/material.dart';

class StorageCard extends StatelessWidget {
  const StorageCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(28),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.white.withOpacity(.26),
                Colors.white.withOpacity(.08),
              ],
            ),
            borderRadius: BorderRadius.circular(28),
            border: Border.all(color: Colors.white.withOpacity(.45)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Storage",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),

              const SizedBox(height: 18),

              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: LinearProgressIndicator(
                  value: .72,
                  minHeight: 10,
                  backgroundColor: Colors.white,
                  color: const Color(0xff3B82F6),
                ),
              ),

              const SizedBox(height: 14),

              Text(
                "72 GB of 100 GB used",
                style: TextStyle(color: Colors.grey.shade700),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
