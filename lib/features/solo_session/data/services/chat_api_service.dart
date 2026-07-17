import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:multi_agent_adaptive_learning_app/features/solo_session/data/models/chat_models.dart';

class ApiException implements Exception {
  const ApiException(this.message, {this.statusCode});

  final String message;
  final int? statusCode;

  @override
  String toString() => 'ApiException($statusCode): $message';
}

class ChatApiService {
  ChatApiService({
    this.baseUrl = const String.fromEnvironment(
      'API_BASE_URL',
      defaultValue: 'http://10.0.2.2:8000',
    ),
    http.Client? client,
  }) : _client = client ?? http.Client();

  final String baseUrl;
  final http.Client _client;

  Uri _uri(String path) => Uri.parse('$baseUrl$path');

  Map<String, String> get _jsonHeaders => const {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  Future<Map<String, dynamic>> health() async {
    final response = await _client.get(
      _uri('/health'),
      headers: const {'Accept': 'application/json'},
    );

    return _decodeObject(response);
  }

  Future<List<AgentInfo>> getAgents() async {
    final response = await _client.get(
      _uri('/chat/agents'),
      headers: const {'Accept': 'application/json'},
    );

    return _decodeList(response)
        .map((item) => AgentInfo.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Future<List<ChatSessionSummary>> getSessions({required String userId}) async {
    final response = await _client.get(
      _uri('/sessions/user/${Uri.encodeComponent(userId)}'),
      headers: const {'Accept': 'application/json'},
    );

    return _decodeList(response)
        .map((item) => ChatSessionSummary.fromJson(item as Map<String, dynamic>))
        .where((session) => session.id.isNotEmpty)
        .toList();
  }

  Future<ChatSessionSummary> createSession({
    required String userId,
    required String title,
    String? goalId,
  }) async {
    final response = await _client.post(
      _uri('/sessions'),
      headers: _jsonHeaders,
      body: jsonEncode({
        'user_id': userId,
        'title': title,
        'goal_id': goalId,
      }),
    );

    return ChatSessionSummary.fromJson(_decodeObject(response));
  }

  Future<ChatSessionSummary> getSession(String sessionId) async {
    final response = await _client.get(
      _uri('/sessions/${Uri.encodeComponent(sessionId)}'),
      headers: const {'Accept': 'application/json'},
    );

    return ChatSessionSummary.fromJson(_decodeObject(response));
  }

  Future<ChatSessionSummary> renameSession({
    required String sessionId,
    required String title,
  }) async {
    final response = await _client.put(
      _uri('/sessions/${Uri.encodeComponent(sessionId)}/rename'),
      headers: _jsonHeaders,
      body: jsonEncode({'title': title}),
    );

    return ChatSessionSummary.fromJson(_decodeObject(response));
  }

  Future<ChatSessionSummary> updateSessionSummary({
    required String sessionId,
    required String summary,
  }) async {
    final response = await _client.patch(
      _uri('/sessions/${Uri.encodeComponent(sessionId)}/summary'),
      headers: _jsonHeaders,
      body: jsonEncode({'summary': summary}),
    );

    return ChatSessionSummary.fromJson(_decodeObject(response));
  }

  Future<bool> deleteSession(String sessionId) async {
    final response = await _client.delete(
      _uri('/sessions/${Uri.encodeComponent(sessionId)}'),
      headers: const {'Accept': 'application/json'},
    );

    final data = _decodeObject(response);
    return data['success'] == true;
  }

  Future<ChatResponse> sendMessage({
    required String sessionId,
    required String userId,
    required String content,
    String agent = 'mentor',
  }) async {
    final response = await _client.post(
      _uri('/chat/send'),
      headers: _jsonHeaders,
      body: jsonEncode({
        'session_id': sessionId,
        'user_id': userId,
        'content': content,
        'agent': agent,
      }),
    );

    return ChatResponse.fromJson(_decodeObject(response));
  }

  Future<List<ChatMessage>> getHistory(String sessionId) async {
    final response = await _client.get(
      _uri('/chat/history/$sessionId'),
      headers: const {'Accept': 'application/json'},
    );

    return _decodeList(response)
        .map((item) => ChatMessage.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  void dispose() {
    _client.close();
  }

  Map<String, dynamic> _decodeObject(http.Response response) {
    final data = _decodeBody(response);

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw ApiException(
        _extractErrorMessage(data, response.body),
        statusCode: response.statusCode,
      );
    }

    return data as Map<String, dynamic>;
  }

  List<dynamic> _decodeList(http.Response response) {
    final data = _decodeBody(response);

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw ApiException(
        _extractErrorMessage(data, response.body),
        statusCode: response.statusCode,
      );
    }

    return data as List<dynamic>;
  }

  dynamic _decodeBody(http.Response response) {
    try {
      return jsonDecode(response.body);
    } on FormatException {
      throw ApiException(
        'Backend returned an invalid response.',
        statusCode: response.statusCode,
      );
    }
  }

  String _extractErrorMessage(dynamic data, String fallback) {
    if (data is Map<String, dynamic>) {
      return data['detail']?.toString() ?? fallback;
    }

    return fallback;
  }
}
