import 'package:flutter/material.dart';
import 'package:multi_agent_adaptive_learning_app/features/ai/data/mappers/agent_mapper.dart';

import 'package:multi_agent_adaptive_learning_app/features/ai/data/models/agent_model.dart';
import 'package:multi_agent_adaptive_learning_app/features/ai/presentations/states/ai_state.dart';
import 'package:multi_agent_adaptive_learning_app/features/solo_session/presentations/controllers/agent_controller.dart';

class AIProvider extends ChangeNotifier {
  AIProvider({required AgentController agentController})
    : _agentController = agentController;

  final AgentController _agentController;

  AIState _state = const AIState();

  AIState get state => _state;

  Future<void> initialize() async {
    if (_state.agents.isNotEmpty) return;

    await loadAgents();
  }

  Future<void> loadAgents() async {
    _state = _state.copyWith(isLoading: true, clearErrorMessage: true);
    notifyListeners();

    try {
      final agentInfos = await _agentController.loadAgents();

      final agents = agentInfos
          .where((agent) => agent.isActive)
          .map(AgentMapper.fromInfo)
          .toList();

      AgentModel? selectedAgent = _state.selectedAgent;

      if (agents.isNotEmpty) {
        selectedAgent ??= agents.first;
      }

      _state = _state.copyWith(
        agents: agents,
        selectedAgent: selectedAgent,
        isLoading: false,
      );
    } catch (e) {
      _state = _state.copyWith(isLoading: false, errorMessage: e.toString());
    }

    notifyListeners();
  }

  void selectAgent(AgentModel agent) {
    if (_state.selectedAgent?.id == agent.id) {
      return;
    }

    _state = _state.copyWith(selectedAgent: agent);

    notifyListeners();
  }
}
