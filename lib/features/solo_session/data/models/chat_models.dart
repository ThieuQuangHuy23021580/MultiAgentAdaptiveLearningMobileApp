class AgentInfo {
  const AgentInfo({
    required this.id,
    required this.name,
    required this.isActive,
    this.description,
    this.avatarUrl,
  });

  final String id;
  final String name;
  final String? description;
  final String? avatarUrl;
  final bool isActive;

  factory AgentInfo.fromJson(Map<String, dynamic> json) {
    return AgentInfo(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      avatarUrl: json['avatar_url'] as String?,
      isActive: json['is_active'] as bool,
    );
  }
}

class ChatMessage {
  const ChatMessage({
    required this.id,
    required this.role,
    required this.content,
    required this.createdAt,
    this.senderUserId,
    this.senderAgentId,
  });

  final String id;
  final String role;
  final String content;
  final DateTime createdAt;
  final String? senderUserId;
  final String? senderAgentId;

  bool get isUser => role.toLowerCase() == 'user';

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      id: json['id'] as String,
      role: json['role'] as String,
      content: json['content'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      senderUserId: json['sender_user_id'] as String?,
      senderAgentId: json['sender_agent_id'] as String?,
    );
  }
}

class ChatSessionSummary {
  const ChatSessionSummary({
    required this.id,
    required this.title,
    this.userId,
    this.goalId,
    this.summary,
    this.sessionMode,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.lastActiveAt,
  });

  final String id;
  final String title;
  final String? userId;
  final String? goalId;
  final String? summary;
  final String? sessionMode;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? lastActiveAt;

  factory ChatSessionSummary.fromJson(Map<String, dynamic> json) {
    final id = json['id']?.toString() ?? json['session_id']?.toString() ?? '';
    final title = json['title']?.toString();
    final createdAt = _parseDate(json['created_at']);
    final updatedAt = _parseDate(json['updated_at']);
    final lastActiveValue =
        json['last_active_at'] ??
        json['updated_at'] ??
        json['started_at'] ??
        json['created_at'];

    return ChatSessionSummary(
      id: id,
      title: title == null || title.isEmpty ? id : title,
      userId: json['user_id']?.toString(),
      goalId: json['goal_id']?.toString(),
      summary: json['summary']?.toString(),
      sessionMode: json['session_mode']?.toString() ?? json['mode']?.toString(),
      status: json['status']?.toString(),
      createdAt: createdAt,
      updatedAt: updatedAt,
      lastActiveAt: _parseDate(lastActiveValue),
    );
  }

  ChatSessionSummary copyWith({
    String? id,
    String? title,
    String? userId,
    String? goalId,
    String? summary,
    String? sessionMode,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? lastActiveAt,
  }) {
    return ChatSessionSummary(
      id: id ?? this.id,
      title: title ?? this.title,
      userId: userId ?? this.userId,
      goalId: goalId ?? this.goalId,
      summary: summary ?? this.summary,
      sessionMode: sessionMode ?? this.sessionMode,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      lastActiveAt: lastActiveAt ?? this.lastActiveAt,
    );
  }

  static DateTime? _parseDate(dynamic value) {
    if (value == null) return null;
    return DateTime.tryParse(value.toString());
  }
}

class ChatResponse {
  const ChatResponse({
    required this.success,
    required this.message,
    required this.sessionId,
    required this.agent,
    required this.response,
    required this.metadata,
  });

  final bool success;
  final String message;
  final String sessionId;
  final String agent;
  final String response;
  final Map<String, dynamic> metadata;

  factory ChatResponse.fromJson(Map<String, dynamic> json) {
    return ChatResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
      sessionId: json['session_id'] as String,
      agent: json['agent'] as String,
      response: json['response'] as String,
      metadata: Map<String, dynamic>.from(json['metadata'] as Map),
    );
  }
}
