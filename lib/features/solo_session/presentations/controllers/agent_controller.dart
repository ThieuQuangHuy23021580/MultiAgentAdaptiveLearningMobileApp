import 'package:flutter/foundation.dart';

import 'package:multi_agent_adaptive_learning_app/features/solo_session/data/models/chat_models.dart';
import 'package:multi_agent_adaptive_learning_app/features/solo_session/data/services/chat_api_service.dart';

class AgentController {
  AgentController({required ChatApiService api}) : _api = api;

  final ChatApiService _api;

  static const List<String> _fallbackAgentNames = [
    'mentor',
    'planner',
    'research',
  ];

  /// ------------------------------------------------------------
  /// Load active agents from backend
  /// ------------------------------------------------------------
  Future<List<AgentInfo>> loadAgents() async {
    try {
      final agents = await _api.getAgents();

      return agents.where((agent) => agent.isActive).toList(growable: false);
    } catch (e, stackTrace) {
      debugPrint('AgentController.loadAgents(): $e\n$stackTrace');

      return const [];
    }
  }

  /// ------------------------------------------------------------
  /// Merge backend agents with local fallback agents
  /// ------------------------------------------------------------
  List<AgentInfo> buildAvailableAgents(List<AgentInfo> agents) {
    final available = List<AgentInfo>.from(agents);

    for (final fallbackName in _fallbackAgentNames) {
      final exists = available.any((agent) => agent.name == fallbackName);

      if (exists) continue;

      available.add(
        AgentInfo(
          id: fallbackName,
          name: fallbackName,
          description: _fallbackDescription(fallbackName),
          isActive: true,
        ),
      );
    }

    return available;
  }

  /// ------------------------------------------------------------
  /// Ensure selected agent always exists
  /// ------------------------------------------------------------
  String resolveSelectedAgent({
    required String current,
    required List<AgentInfo> availableAgents,
  }) {
    if (availableAgents.isEmpty) {
      return current;
    }

    final exists = availableAgents.any((agent) => agent.name == current);

    if (exists) {
      return current;
    }

    return availableAgents.first.name;
  }

  /// ------------------------------------------------------------
  /// Get current selected agent
  /// ------------------------------------------------------------
  AgentInfo currentAgent({
    required List<AgentInfo> availableAgents,
    required String selectedAgent,
  }) {
    return availableAgents.firstWhere(
      (agent) => agent.name == selectedAgent,
      orElse: () => availableAgents.first,
    );
  }

  /// ------------------------------------------------------------
  /// Local fallback description
  /// ------------------------------------------------------------
  String _fallbackDescription(String name) {
    switch (name) {
      case 'planner':
        return 'Lập kế hoạch học tập và chia nhỏ mục tiêu.';

      case 'research':
        return 'Tìm kiếm, tổng hợp và giải thích kiến thức.';

      case 'mentor':
      default:
        return 'Hướng dẫn học tập và giải đáp thắc mắc.';
    }
  }
}
