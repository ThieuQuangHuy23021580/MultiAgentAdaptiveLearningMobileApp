import 'package:flutter/material.dart';

class MetricItem {
  const MetricItem({
    required this.title,
    required this.value,
    required this.icon,
    this.suffix,
    this.iconColor,
  });

  final String title;
  final String value;
  final String? suffix;
  final IconData icon;
  final Color? iconColor;
}
