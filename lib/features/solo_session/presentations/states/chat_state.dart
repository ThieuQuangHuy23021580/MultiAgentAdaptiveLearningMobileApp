import 'package:multi_agent_adaptive_learning_app/features/solo_session/data/models/chat_models.dart';

class ChatState {
  final List<ChatMessage> messages;

  final bool isLoadingHistory;

  final bool isSending;

  final String? errorMessage;

  const ChatState({
    this.messages = const [],
    this.isLoadingHistory = false,
    this.isSending = false,
    this.errorMessage,
  });

  ChatState copyWith({
    List<ChatMessage>? messages,
    bool? isLoadingHistory,
    bool? isSending,
    String? errorMessage,
    bool clearError = false,
  }) {
    return ChatState(
      messages: messages ?? this.messages,
      isLoadingHistory: isLoadingHistory ?? this.isLoadingHistory,
      isSending: isSending ?? this.isSending,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
    );
  }
}
