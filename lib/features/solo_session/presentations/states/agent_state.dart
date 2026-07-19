import 'package:multi_agent_adaptive_learning_app/features/solo_session/data/models/chat_models.dart';

class AgentState {
  final List<AgentInfo> agents;

  final String selectedAgent;

  final bool isLoadingAgents;

  const AgentState({
    this.agents = const [],
    this.selectedAgent = 'mentor',
    this.isLoadingAgents = false,
  });

  AgentState copyWith({
    List<AgentInfo>? agents,
    String? selectedAgent,
    bool? isLoadingAgents,
  }) {
    return AgentState(
      agents: agents ?? this.agents,
      selectedAgent: selectedAgent ?? this.selectedAgent,
      isLoadingAgents: isLoadingAgents ?? this.isLoadingAgents,
    );
  }
}
