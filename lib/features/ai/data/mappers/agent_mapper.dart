import 'package:flutter/material.dart';

import 'package:multi_agent_adaptive_learning_app/features/ai/data/models/agent_model.dart';
import 'package:multi_agent_adaptive_learning_app/features/solo_session/data/models/chat_models.dart';

class AgentMapper {
  const AgentMapper._();

  static AgentModel fromInfo(AgentInfo info) {
    switch (info.id.toLowerCase()) {
      case 'mentor':
        return AgentModel(
          id: info.id,
          name: info.name,
          role: 'Guidance & Strategy',
          description:
              info.description ??
              'Provides strategic direction and helps solve complex problems.',
          image:
              'https://images.unsplash.com/photo-1521737604893-d14cc237f11d?w=900',
          icon: Icons.school,
        );

      case 'research':
        return AgentModel(
          id: info.id,
          name: info.name,
          role: 'Data Extraction',
          description:
              info.description ??
              'Scours documents and extracts valuable information.',
          image:
              'https://images.unsplash.com/photo-1516321318423-f06f85e504b3?w=900',
          icon: Icons.manage_search,
        );

      case 'planner':
        return AgentModel(
          id: info.id,
          name: info.name,
          role: 'Plan & Roadmap',
          description:
              info.description ??
              'Breaks down goals into clear, organized tasks.',
          image:
              'https://images.unsplash.com/photo-1455390582262-044cdead277a?w=900',
          icon: Icons.summarize,
        );

      default:
        return AgentModel(
          id: info.id,
          name: info.name,
          role: 'AI Assistant',
          description: info.description ?? '',
          image:
              'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=900',
          icon: Icons.smart_toy,
        );
    }
  }
}
