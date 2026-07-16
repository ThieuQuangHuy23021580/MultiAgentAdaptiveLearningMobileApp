import 'package:flutter/material.dart';

import '../../../../../../cores/theme/app_colors.dart';
import '../widgets/workspace_grid.dart';
import '../widgets/workspace_header.dart';

class WorkspaceScreen extends StatelessWidget {
  const WorkspaceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,

        title: const Text(
          "Neo OS",
          style: TextStyle(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),

        leading: const Icon(Icons.menu),

        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: CircleAvatar(
              radius: 18,
              backgroundImage: NetworkImage("https://i.pravatar.cc/150"),
            ),
          ),
        ],
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 150),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              WorkspaceHeader(),

              SizedBox(height: 28),

              WorkspaceGrid(),
            ],
          ),
        ),
      ),
    );
  }
}
