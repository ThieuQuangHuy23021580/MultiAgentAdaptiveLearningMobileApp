import 'package:flutter/material.dart';
import 'package:multi_agent_adaptive_learning_app/cores/theme/app_colors.dart';

class InsightsScreen extends StatelessWidget {
  const InsightsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const InsightsAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 24, 20, 140),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            InsightsHeader(),

            SizedBox(height: 24),

            MetricsGrid(),

            SizedBox(height: 24),

            FocusChartCard(),

            SizedBox(height: 24),

            AiSummaryCard(),
          ],
        ),
      ),
    );
  }
}
