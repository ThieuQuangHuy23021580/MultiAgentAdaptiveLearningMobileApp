import 'package:flutter/material.dart';
import 'package:multi_agent_adaptive_learning_app/cores/theme/app_colors.dart';
import 'package:multi_agent_adaptive_learning_app/features/insights/widgets/charts/chart_header.dart';
import 'package:multi_agent_adaptive_learning_app/features/insights/widgets/charts/chart_line_painter.dart';
import 'package:multi_agent_adaptive_learning_app/features/insights/widgets/charts/focus_bar.dart';

class FocusChartCard extends StatelessWidget {
  const FocusChartCard({super.key});

  static const values = [2.0, 6.0, 4.0, 3.0, 7.0, 5.0, 2.0];

  static const days = ["M", "T", "W", "T", "F", "S", "S"];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      height: 360,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.outline.withOpacity(.08)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.04),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          const ChartHeader(),

          const SizedBox(height: 28),

          Expanded(
            child: Stack(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: List.generate(
                    values.length,
                    (index) => FocusBar(
                      value: values[index],
                      maxValue: 7,
                      highlight: index == 1 || index == 4,
                    ),
                  ),
                ),

                IgnorePointer(
                  child: CustomPaint(
                    size: Size.infinite,
                    painter: ChartLinePainter(values),
                  ),
                ),
              ],
            ),
          ),

          const Divider(),

          const SizedBox(height: 10),

          Row(
            children: days
                .map(
                  (e) => Expanded(
                    child: Center(
                      child: Text(
                        e,
                        style: TextStyle(color: AppColors.onSurfaceVariant),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
