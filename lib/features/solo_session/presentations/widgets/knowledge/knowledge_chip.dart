import 'package:flutter/material.dart';
import 'package:multi_agent_adaptive_learning_app/features/solo_session/data/models/knowledge_item.dart'
    show KnowledgeItem, KnowledgeType;

class KnowledgeChip extends StatelessWidget {
  final KnowledgeItem item;

  const KnowledgeChip({super.key, required this.item});

  IconData get icon {
    if (item.customIcon != null) {
      return item.customIcon!;
    }

    switch (item.type) {
      case KnowledgeType.pdf:
        return Icons.picture_as_pdf_rounded;

      case KnowledgeType.website:
        return Icons.language_rounded;

      case KnowledgeType.video:
        return Icons.smart_display_rounded;

      case KnowledgeType.book:
        return Icons.menu_book_rounded;
    }
  }

  Color get color {
    switch (item.type) {
      case KnowledgeType.pdf:
        return Colors.red;

      case KnowledgeType.website:
        return Colors.blue;

      case KnowledgeType.video:
        return Colors.deepPurple;

      case KnowledgeType.book:
        return Colors.orange;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 14),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.65),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.grey.withOpacity(.18)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 20),

          const SizedBox(width: 10),

          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 170),
            child: Text(
              item.title,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
