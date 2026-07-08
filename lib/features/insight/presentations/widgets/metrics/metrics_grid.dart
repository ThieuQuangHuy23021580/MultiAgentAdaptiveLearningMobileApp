import 'package:flutter/material.dart';
import 'package:multi_agent_adaptive_learning_app/features/insight/data/models/metric_item.dart';
import 'package:multi_agent_adaptive_learning_app/features/insight/presentations/widgets/metrics/metric_card.dart';

class MetricsGrid extends StatelessWidget {
  const MetricsGrid({super.key});

  static const List<MetricItem> _metrics = [
    MetricItem(
      title: "Study Time",
      value: "24",
      suffix: "hrs",
      icon: Icons.timer_outlined,
    ),
    MetricItem(title: "Flashcards", value: "142", icon: Icons.style_outlined),
    MetricItem(
      title: "Accuracy",
      value: "87",
      suffix: "%",
      icon: Icons.check_circle_outline,
    ),
    MetricItem(
      title: "Docs Read",
      value: "18",
      icon: Icons.description_outlined,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        int crossAxisCount = 4;

        if (constraints.maxWidth < 1200) {
          crossAxisCount = 2;
        }

        if (constraints.maxWidth < 700) {
          crossAxisCount = 1;
        }

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _metrics.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            childAspectRatio: 1.7,
          ),
          itemBuilder: (_, index) {
            return MetricCard(metric: _metrics[index]);
          },
        );
      },
    );
  }
}
