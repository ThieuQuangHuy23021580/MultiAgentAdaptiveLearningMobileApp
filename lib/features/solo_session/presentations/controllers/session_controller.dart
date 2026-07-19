import 'package:flutter/foundation.dart';

import 'package:multi_agent_adaptive_learning_app/features/solo_session/data/models/chat_models.dart';
import 'package:multi_agent_adaptive_learning_app/features/solo_session/data/services/chat_api_service.dart';

class SessionController {
  SessionController({required ChatApiService api}) : _api = api;

  final ChatApiService _api;

  static const String fallbackSessionId = 'session-test-1';

  static const String userId = '1';

  ///------------------------------------------------------------
  /// Load session list
  ///------------------------------------------------------------

  Future<List<ChatSessionSummary>> loadSessions() async {
    try {
      return await _api.getSessions(userId: userId);
    } on ApiException {
      rethrow;
    } catch (e, stackTrace) {
      debugPrint(
        'SessionController.loadSessions(): '
        '$e\n$stackTrace',
      );

      rethrow;
    }
  }

  ///------------------------------------------------------------
  /// Create
  ///------------------------------------------------------------

  Future<ChatSessionSummary> createSession({required String title}) {
    return _api.createSession(userId: userId, title: title.trim());
  }

  ///------------------------------------------------------------
  /// Rename
  ///------------------------------------------------------------

  Future<ChatSessionSummary> renameSession({
    required String sessionId,
    required String title,
  }) {
    return _api.renameSession(sessionId: sessionId, title: title.trim());
  }

  ///------------------------------------------------------------
  /// Update Summary
  ///------------------------------------------------------------

  Future<ChatSessionSummary> updateSummary({
    required String sessionId,
    required String summary,
  }) {
    return _api.updateSessionSummary(
      sessionId: sessionId,
      summary: summary.trim(),
    );
  }

  ///------------------------------------------------------------
  /// Delete
  ///------------------------------------------------------------

  Future<void> deleteSession(String sessionId) {
    return _api.deleteSession(sessionId);
  }

  ///------------------------------------------------------------
  /// Resolve current session
  ///------------------------------------------------------------

  String resolveCurrentSession({
    required List<ChatSessionSummary> sessions,
    required String currentSessionId,
  }) {
    if (sessions.isEmpty) {
      return fallbackSessionId;
    }

    final exists = sessions.any((session) => session.id == currentSessionId);

    if (exists) {
      return currentSessionId;
    }

    return sessions.first.id;
  }

  ///------------------------------------------------------------
  /// Replace / Insert
  ///------------------------------------------------------------

  List<ChatSessionSummary> upsertSession({
    required List<ChatSessionSummary> sessions,
    required ChatSessionSummary session,
  }) {
    final result = List<ChatSessionSummary>.from(sessions);

    final index = result.indexWhere((item) => item.id == session.id);

    if (index == -1) {
      result.insert(0, session);
    } else {
      result[index] = session;
    }

    return result;
  }

  ///------------------------------------------------------------
  /// Remove
  ///------------------------------------------------------------

  List<ChatSessionSummary> removeSession({
    required List<ChatSessionSummary> sessions,
    required String sessionId,
  }) {
    return sessions
        .where((session) => session.id != sessionId)
        .toList(growable: false);
  }

  ///------------------------------------------------------------
  /// Local fallback
  ///------------------------------------------------------------

  List<ChatSessionSummary> fallbackSessions() {
    return const [
      ChatSessionSummary(
        id: fallbackSessionId,
        title: 'Solo mentor session',
        sessionMode: 'solo',
        status: 'active',
      ),
    ];
  }
}
