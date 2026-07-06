import 'package:flutter/material.dart';
import 'package:multi_agent_adaptive_learning_app/features/solo_session/data/models/knowledge_item.dart'
    show KnowledgeItem, KnowledgeType;

import '../common/glass_panel.dart';
import 'knowledge_chip.dart';

class KnowledgePanel extends StatelessWidget {
  const KnowledgePanel({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      const KnowledgeItem(
        title: "Neural Architecture Search.pdf",
        type: KnowledgeType.pdf,
      ),

      const KnowledgeItem(
        title: "Attention Is All You Need",
        type: KnowledgeType.website,
      ),

      const KnowledgeItem(
        title: "Deep Learning Book",
        type: KnowledgeType.book,
      ),

      const KnowledgeItem(
        title: "MIT Neural Networks Lecture",
        type: KnowledgeType.video,
      ),
    ];

    return GlassPanel(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Expanded(
                child: Text(
                  "KNOWLEDGE BASE",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                    color: Color.fromARGB(255, 134, 134, 134),
                  ),
                ),
              ),

              Icon(
                Icons.library_books_rounded,
                color: Color(0xff2563EB),
                size: 20,
              ),
            ],
          ),

          const SizedBox(height: 16),

          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: items.length,
              itemBuilder: (_, index) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: KnowledgeChip(item: items[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
