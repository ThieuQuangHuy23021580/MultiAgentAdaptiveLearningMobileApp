import 'package:multi_agent_adaptive_learning_app/features/ai/data/models/agent_model.dart';
import 'package:multi_agent_adaptive_learning_app/features/solo_session/data/models/chat_models.dart';

class AIState {
  const AIState({
    this.agents = const [],
    this.selectedAgent,
    this.isLoading = false,
    this.errorMessage,
  });

  final List<AgentModel> agents;
  final AgentModel? selectedAgent;
  final bool isLoading;
  final String? errorMessage;

  AIState copyWith({
    List<AgentModel>? agents,
    AgentModel? selectedAgent,
    bool clearSelectedAgent = false,
    bool? isLoading,
    String? errorMessage,
    bool clearErrorMessage = false,
  }) {
    return AIState(
      agents: agents ?? this.agents,
      selectedAgent: clearSelectedAgent
          ? null
          : (selectedAgent ?? this.selectedAgent),
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearErrorMessage
          ? null
          : (errorMessage ?? this.errorMessage),
    );
  }
}
