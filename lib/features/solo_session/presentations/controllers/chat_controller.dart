import 'package:flutter/foundation.dart';

import 'package:multi_agent_adaptive_learning_app/features/solo_session/data/models/chat_models.dart';
import 'package:multi_agent_adaptive_learning_app/features/solo_session/data/services/chat_api_service.dart';

class ChatController {
  ChatController({required ChatApiService api}) : _api = api;

  final ChatApiService _api;

  Future<List<ChatMessage>> loadHistory({required String sessionId}) {
    return _api.getHistory(sessionId);
  }

  Future<ChatResponse> sendMessage({
    required String sessionId,
    required String userId,
    required String content,
    required String agent,
  }) {
    return _api.sendMessage(
      sessionId: sessionId,
      userId: userId,
      content: content,
      agent: agent,
    );
  }

  ChatMessage buildUserMessage({
    required String userId,
    required String content,
  }) {
    return ChatMessage(
      id: 'local-${DateTime.now().microsecondsSinceEpoch}',
      role: 'user',
      content: content,
      createdAt: DateTime.now(),
      senderUserId: userId,
    );
  }

  ChatMessage buildAgentMessage({required String content}) {
    return ChatMessage(
      id: 'agent-${DateTime.now().microsecondsSinceEpoch}',
      role: 'agent',
      content: content,
      createdAt: DateTime.now(),
    );
  }

  List<ChatMessage> appendMessage({
    required List<ChatMessage> messages,
    required ChatMessage message,
  }) {
    return List<ChatMessage>.unmodifiable([...messages, message]);
  }

  List<ChatMessage> replaceHistory({required List<ChatMessage> history}) {
    return List<ChatMessage>.unmodifiable(history);
  }

  void logError(String action, Object error, StackTrace stackTrace) {
    debugPrint('ChatController.$action(): $error\n$stackTrace');
  }
}
