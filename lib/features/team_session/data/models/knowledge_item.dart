import 'package:flutter/material.dart';

enum KnowledgeType { pdf, website, video, book }

class KnowledgeItem {
  final String title;
  final KnowledgeType type;
  final String? source;
  final IconData? customIcon;

  const KnowledgeItem({
    required this.title,
    required this.type,
    this.source,
    this.customIcon,
  });
}
