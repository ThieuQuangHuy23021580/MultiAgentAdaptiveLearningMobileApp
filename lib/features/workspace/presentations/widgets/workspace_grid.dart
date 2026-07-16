import 'package:flutter/material.dart';

import 'storage_card.dart';
import 'workspace_card.dart';

class WorkspaceGrid extends StatelessWidget {
  const WorkspaceGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// Hàng 1
        Row(
          children: [
            Expanded(
              child: WorkspaceCard(
                icon: Icons.auto_awesome,
                color: const Color(0xff3B82F6),
                title: "AI Research",
                subtitle: "24 files",
              ),
            ),

            const SizedBox(width: 16),

            Expanded(
              child: WorkspaceCard(
                icon: Icons.code,
                color: const Color(0xff8B5CF6),
                title: "Flutter",
                subtitle: "18 files",
              ),
            ),
          ],
        ),

        const SizedBox(height: 16),

        /// Storage
        const StorageCard(),

        const SizedBox(height: 16),

        /// Hàng 2
        Row(
          children: [
            Expanded(
              child: WorkspaceCard(
                icon: Icons.psychology_alt,
                color: const Color(0xffF59E0B),
                title: "Machine Learning",
                subtitle: "42 files",
              ),
            ),

            const SizedBox(width: 16),

            Expanded(
              child: WorkspaceCard(
                icon: Icons.school,
                color: const Color(0xff10B981),
                title: "Study Notes",
                subtitle: "12 files",
              ),
            ),
          ],
        ),

        const SizedBox(height: 16),

        Row(
          children: [
            Expanded(
              child: WorkspaceCard(
                icon: Icons.analytics,
                color: const Color(0xffEF4444),
                title: "Analytics",
                subtitle: "9 reports",
              ),
            ),

            const SizedBox(width: 16),

            Expanded(
              child: WorkspaceCard(
                icon: Icons.folder_copy,
                color: const Color(0xff6366F1),
                title: "Resources",
                subtitle: "36 files",
              ),
            ),
          ],
        ),
      ],
    );
  }
}
