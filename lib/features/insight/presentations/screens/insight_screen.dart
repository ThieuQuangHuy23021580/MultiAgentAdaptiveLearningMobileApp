import 'package:flutter/material.dart';
import 'package:multi_agent_adaptive_learning_app/cores/theme/app_colors.dart';
import 'package:multi_agent_adaptive_learning_app/features/insight/presentations/widgets/ai/ai_summary_card.dart';
import 'package:multi_agent_adaptive_learning_app/features/insight/presentations/widgets/charts/focus_chart_card.dart';
import 'package:multi_agent_adaptive_learning_app/features/insight/presentations/widgets/header/insights_header.dart';
import 'package:multi_agent_adaptive_learning_app/features/insight/presentations/widgets/insights_app_bar.dart';
import 'package:multi_agent_adaptive_learning_app/features/insight/presentations/widgets/metrics/metrics_grid.dart';

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
