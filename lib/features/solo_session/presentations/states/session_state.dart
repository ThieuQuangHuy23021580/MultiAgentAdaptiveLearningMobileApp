import 'package:multi_agent_adaptive_learning_app/features/solo_session/data/models/chat_models.dart';

class SessionState {
  final List<ChatSessionSummary> sessions;

  final String currentSessionId;

  final bool isLoadingSessions;

  final bool isMutatingSession;

  final String? drawerErrorMessage;

  const SessionState({
    this.sessions = const [],
    this.currentSessionId = 'session-test-1',
    this.isLoadingSessions = false,
    this.isMutatingSession = false,
    this.drawerErrorMessage,
  });

  ChatSessionSummary? get currentSession {
    try {
      return sessions.firstWhere((session) => session.id == currentSessionId);
    } catch (_) {
      return null;
    }
  }

  SessionState copyWith({
    List<ChatSessionSummary>? sessions,
    String? currentSessionId,
    bool? isLoadingSessions,
    bool? isMutatingSession,
    String? drawerErrorMessage,
    bool clearDrawerError = false,
  }) {
    return SessionState(
      sessions: sessions ?? this.sessions,
      currentSessionId: currentSessionId ?? this.currentSessionId,
      isLoadingSessions: isLoadingSessions ?? this.isLoadingSessions,
      isMutatingSession: isMutatingSession ?? this.isMutatingSession,
      drawerErrorMessage: clearDrawerError
          ? null
          : drawerErrorMessage ?? this.drawerErrorMessage,
    );
  }
}
