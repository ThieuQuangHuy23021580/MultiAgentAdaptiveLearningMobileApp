import 'package:flutter/foundation.dart';

import 'package:multi_agent_adaptive_learning_app/features/solo_session/data/models/chat_models.dart';
import 'package:multi_agent_adaptive_learning_app/features/solo_session/data/services/chat_api_service.dart';
import 'package:multi_agent_adaptive_learning_app/features/solo_session/presentations/controllers/agent_controller.dart';
import 'package:multi_agent_adaptive_learning_app/features/solo_session/presentations/controllers/chat_controller.dart';
import 'package:multi_agent_adaptive_learning_app/features/solo_session/presentations/controllers/session_controller.dart';
import 'package:multi_agent_adaptive_learning_app/features/solo_session/presentations/states/agent_state.dart';
import 'package:multi_agent_adaptive_learning_app/features/solo_session/presentations/states/chat_state.dart';
import 'package:multi_agent_adaptive_learning_app/features/solo_session/presentations/states/session_state.dart';

class SoloSessionProvider extends ChangeNotifier {
  SoloSessionProvider({
    required AgentController agentController,
    required SessionController sessionController,
    required ChatController chatController,
    String initialAgent = 'mentor',
  }) : _agentController = agentController,
       _sessionController = sessionController,
       _chatController = chatController {
    _agentState = _agentState.copyWith(selectedAgent: initialAgent);
  }

  final AgentController _agentController;
  final SessionController _sessionController;
  final ChatController _chatController;

  static const String userId = '1';

  ChatState _chatState = const ChatState();
  SessionState _sessionState = const SessionState();
  AgentState _agentState = const AgentState();

  ChatState get chatState => _chatState;

  SessionState get sessionState => _sessionState;

  AgentState get agentState => _agentState;

  List<ChatMessage> get messages => _chatState.messages;

  List<ChatSessionSummary> get sessions => _sessionState.sessions;

  List<AgentInfo> get agents =>
      _agentController.buildAvailableAgents(_agentState.agents);

  String get currentSessionId => _sessionState.currentSessionId;

  String get selectedAgent => _agentState.selectedAgent;

  AgentInfo get currentAgent => _agentController.currentAgent(
    availableAgents: agents,
    selectedAgent: selectedAgent,
  );

  bool get isLoadingHistory => _chatState.isLoadingHistory;

  bool get isLoadingSessions => _sessionState.isLoadingSessions;

  bool get isLoadingAgents => _agentState.isLoadingAgents;

  bool get isSending => _chatState.isSending;

  bool get isMutatingSession => _sessionState.isMutatingSession;

  String? get errorMessage => _chatState.errorMessage;

  String? get drawerErrorMessage => _sessionState.drawerErrorMessage;

  Future<void> bootstrap() async {
    await loadAgents();
    await loadSessions(selectInitialSession: true);
    await loadHistory();
  }

  Future<void> loadAgents() async {
    _agentState = _agentState.copyWith(isLoadingAgents: true);
    notifyListeners();

    final agents = await _agentController.loadAgents();

    final availableAgents = _agentController.buildAvailableAgents(agents);

    _agentState = _agentState.copyWith(
      agents: availableAgents,
      selectedAgent: _agentController.resolveSelectedAgent(
        current: _agentState.selectedAgent,
        availableAgents: availableAgents,
      ),
      isLoadingAgents: false,
    );

    notifyListeners();
  }

  void selectAgent(String agentName) {
    _agentState = _agentState.copyWith(selectedAgent: agentName);

    notifyListeners();
  }

  Future<void> loadSessions({bool selectInitialSession = false}) async {
    _sessionState = _sessionState.copyWith(
      isLoadingSessions: true,
      clearDrawerError: true,
    );

    notifyListeners();

    try {
      final sessions = await _sessionController.loadSessions();

      String currentSessionId = _sessionState.currentSessionId;

      if (selectInitialSession) {
        currentSessionId = _sessionController.resolveCurrentSession(
          sessions: sessions,
          currentSessionId: _sessionState.currentSessionId,
        );
      }

      _sessionState = _sessionState.copyWith(
        sessions: sessions,
        currentSessionId: currentSessionId,
        isLoadingSessions: false,
      );
    } on ApiException catch (e) {
      _sessionState = _sessionState.copyWith(
        sessions: _sessionController.fallbackSessions(),
        drawerErrorMessage: e.message,
        isLoadingSessions: false,
      );
    } catch (_) {
      _sessionState = _sessionState.copyWith(
        sessions: _sessionController.fallbackSessions(),
        drawerErrorMessage:
            'Cannot connect to the backend. Check FastAPI server.',
        isLoadingSessions: false,
      );
    }

    notifyListeners();
  }

  Future<void> loadHistory() async {
    _chatState = _chatState.copyWith(isLoadingHistory: true, clearError: true);

    notifyListeners();

    try {
      final history = await _chatController.loadHistory(
        sessionId: _sessionState.currentSessionId,
      );

      _chatState = _chatState.copyWith(
        messages: _chatController.replaceHistory(history: history),
        isLoadingHistory: false,
      );
    } on ApiException catch (e) {
      _chatState = _chatState.copyWith(
        errorMessage: e.message,
        isLoadingHistory: false,
      );
    } catch (_) {
      _chatState = _chatState.copyWith(
        errorMessage: 'Cannot connect to the backend. Check FastAPI server.',
        isLoadingHistory: false,
      );
    }

    notifyListeners();
  }

  Future<void> selectSession(ChatSessionSummary session) async {
    _sessionState = _sessionState.copyWith(currentSessionId: session.id);

    notifyListeners();

    await loadHistory();
  }

  Future<void> createSession(String title) async {
    if (title.trim().isEmpty) {
      return;
    }

    _sessionState = _sessionState.copyWith(
      isMutatingSession: true,
      clearDrawerError: true,
    );

    notifyListeners();

    try {
      final session = await _sessionController.createSession(title: title);

      _sessionState = _sessionState.copyWith(
        currentSessionId: session.id,
        sessions: _sessionController.upsertSession(
          sessions: _sessionState.sessions,
          session: session,
        ),
        isMutatingSession: false,
      );

      _chatState = _chatState.copyWith(messages: const []);

      notifyListeners();

      await loadHistory();
    } on ApiException catch (e) {
      _sessionState = _sessionState.copyWith(
        drawerErrorMessage: e.message,
        isMutatingSession: false,
      );

      notifyListeners();
    } catch (_) {
      _sessionState = _sessionState.copyWith(
        drawerErrorMessage: 'Cannot create session. Check FastAPI server.',
        isMutatingSession: false,
      );

      notifyListeners();
    }
  }

  Future<void> renameSession({
    required String sessionId,
    required String title,
  }) async {
    if (title.trim().isEmpty) {
      return;
    }

    _sessionState = _sessionState.copyWith(
      isMutatingSession: true,
      clearDrawerError: true,
    );

    notifyListeners();

    try {
      final session = await _sessionController.renameSession(
        sessionId: sessionId,
        title: title,
      );

      _sessionState = _sessionState.copyWith(
        sessions: _sessionController.upsertSession(
          sessions: _sessionState.sessions,
          session: session,
        ),
        isMutatingSession: false,
      );

      notifyListeners();
    } on ApiException catch (e) {
      _sessionState = _sessionState.copyWith(
        drawerErrorMessage: e.message,
        isMutatingSession: false,
      );

      notifyListeners();
    } catch (_) {
      _sessionState = _sessionState.copyWith(
        drawerErrorMessage: 'Cannot rename session. Check FastAPI server.',
        isMutatingSession: false,
      );

      notifyListeners();
    }
  }

  Future<void> updateSessionSummary({
    required String sessionId,
    required String summary,
  }) async {
    _sessionState = _sessionState.copyWith(
      isMutatingSession: true,
      clearDrawerError: true,
    );

    notifyListeners();

    try {
      final session = await _sessionController.updateSummary(
        sessionId: sessionId,
        summary: summary,
      );

      _sessionState = _sessionState.copyWith(
        sessions: _sessionController.upsertSession(
          sessions: _sessionState.sessions,
          session: session,
        ),
        isMutatingSession: false,
      );

      notifyListeners();
    } on ApiException catch (e) {
      _sessionState = _sessionState.copyWith(
        drawerErrorMessage: e.message,
        isMutatingSession: false,
      );

      notifyListeners();
    } catch (_) {
      _sessionState = _sessionState.copyWith(
        drawerErrorMessage: 'Cannot update session. Check FastAPI server.',
        isMutatingSession: false,
      );

      notifyListeners();
    }
  }

  Future<void> deleteSession(ChatSessionSummary session) async {
    _sessionState = _sessionState.copyWith(
      isMutatingSession: true,
      clearDrawerError: true,
    );

    notifyListeners();

    try {
      await _sessionController.deleteSession(session.id);

      final sessions = _sessionController.removeSession(
        sessions: _sessionState.sessions,
        sessionId: session.id,
      );

      final currentSessionId = _sessionController.resolveCurrentSession(
        sessions: sessions,
        currentSessionId: _sessionState.currentSessionId,
      );

      _sessionState = _sessionState.copyWith(
        sessions: sessions,
        currentSessionId: currentSessionId,
        isMutatingSession: false,
      );

      if (sessions.isEmpty) {
        _chatState = _chatState.copyWith(messages: const []);

        notifyListeners();
        return;
      }

      notifyListeners();

      await loadHistory();
    } on ApiException catch (e) {
      _sessionState = _sessionState.copyWith(
        drawerErrorMessage: e.message,
        isMutatingSession: false,
      );

      notifyListeners();
    } catch (_) {
      _sessionState = _sessionState.copyWith(
        drawerErrorMessage: 'Cannot delete session. Check FastAPI server.',
        isMutatingSession: false,
      );

      notifyListeners();
    }
  }

  Future<void> sendMessage(String text) async {
    final userMessage = _chatController.buildUserMessage(
      userId: userId,
      content: text,
    );

    _chatState = _chatState.copyWith(
      messages: _chatController.appendMessage(
        messages: _chatState.messages,
        message: userMessage,
      ),
      isSending: true,
      clearError: true,
    );

    notifyListeners();

    try {
      final response = await _chatController.sendMessage(
        sessionId: _sessionState.currentSessionId,
        userId: userId,
        content: text,
        agent: _agentState.selectedAgent,
      );

      final agentMessage = _chatController.buildAgentMessage(
        content: response.response,
      );

      _chatState = _chatState.copyWith(
        messages: _chatController.appendMessage(
          messages: _chatState.messages,
          message: agentMessage,
        ),
        isSending: false,
      );

      notifyListeners();
    } on ApiException catch (e) {
      _chatState = _chatState.copyWith(
        errorMessage: e.message,
        isSending: false,
      );

      notifyListeners();
    } catch (_) {
      _chatState = _chatState.copyWith(
        errorMessage: 'Cannot connect to the backend. Check FastAPI server.',
        isSending: false,
      );

      notifyListeners();
    }
  }
}
