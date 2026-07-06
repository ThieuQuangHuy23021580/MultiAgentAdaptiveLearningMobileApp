enum MessageRole { ai, user }

class ConversationMessage {
  final String text;
  final MessageRole role;
  final String time;

  const ConversationMessage({
    required this.text,
    required this.role,
    required this.time,
  });

  factory ConversationMessage.ai(String text) {
    return ConversationMessage(text: text, role: MessageRole.ai, time: "Now");
  }

  factory ConversationMessage.user(String text) {
    return ConversationMessage(text: text, role: MessageRole.user, time: "Now");
  }
}
