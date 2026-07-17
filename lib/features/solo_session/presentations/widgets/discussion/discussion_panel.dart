import 'package:flutter/material.dart';
import 'package:multi_agent_adaptive_learning_app/features/solo_session/data/models/chat_models.dart';
import 'package:multi_agent_adaptive_learning_app/features/solo_session/presentations/widgets/discussion/typing_bubble.dart';
import '../common/glass_panel.dart';
import 'message_bubble.dart';

class DiscussionPanel extends StatefulWidget {
  const DiscussionPanel({
    super.key,
    required this.messages,
    required this.isLoadingHistory,
    required this.isSending,
    required this.agentName,
    required this.agentAvatar,
    this.errorMessage,
    this.onRetry,
  });

  final String agentName;
  final String? agentAvatar;
  static const _userAvatar = 'https://i.pravatar.cc/150?img=12';
  static const _defaultAvatar = 'https://i.pravatar.cc/150?img=12';

  final List<ChatMessage> messages;
  final bool isLoadingHistory;
  final bool isSending;
  final String? errorMessage;
  final VoidCallback? onRetry;

  @override
  State<DiscussionPanel> createState() => _DiscussionPanelState();
}

class _DiscussionPanelState extends State<DiscussionPanel> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scheduleScrollToBottom();
  }

  @override
  void didUpdateWidget(covariant DiscussionPanel oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.messages.length != widget.messages.length ||
        oldWidget.isSending != widget.isSending ||
        oldWidget.isLoadingHistory != widget.isLoadingHistory) {
      _scheduleScrollToBottom();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scheduleScrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || !_scrollController.hasClients) return;

      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 260),
        curve: Curves.easeOutCubic,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return GlassPanel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "SOLO AI CHAT",
            style: TextStyle(
              fontSize: 13,
              letterSpacing: 1.2,
              color: Color.fromARGB(255, 134, 134, 134),
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 20),

          Expanded(child: _buildBody(context)),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    if (widget.isLoadingHistory) {
      return const Center(child: CircularProgressIndicator());
    }

    if (widget.messages.isEmpty && widget.errorMessage == null) {
      return const Center(
        child: Text(
          'Start a conversation with your AI mentor.',
          textAlign: TextAlign.center,
          style: TextStyle(color: Color(0xff667085), fontSize: 15),
        ),
      );
    }

    return ListView(
      controller: _scrollController,
      padding: EdgeInsets.zero,
      children: [
        if (widget.errorMessage != null)
          _ErrorBanner(message: widget.errorMessage!, onRetry: widget.onRetry),
        ...widget.messages.map(_buildMessageBubble),
        if (widget.isSending)
          TypingIndicator(
            agent: widget.agentName,
            avatar: widget.agentAvatar ?? DiscussionPanel._defaultAvatar,
          ),
      ],
    );
  }

  Widget _buildMessageBubble(ChatMessage message) {
    final isUser = message.isUser;

    return MessageBubble(
      agentName: isUser ? 'You' : widget.agentName,
      avatar: isUser
          ? DiscussionPanel._userAvatar
          : widget.agentAvatar ?? DiscussionPanel._defaultAvatar,
      time: _formatTime(message.createdAt),
      message: message.content,
      isPrimary: !isUser,
      isUser: isUser,
    );
  }

  String _formatTime(DateTime createdAt) {
    final local = createdAt.toLocal();
    final hour = local.hour.toString().padLeft(2, '0');
    final minute = local.minute.toString().padLeft(2, '0');

    return '$hour:$minute';
  }
}

class _ErrorBanner extends StatelessWidget {
  const _ErrorBanner({required this.message, this.onRetry});

  final String message;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xffFEF2F2),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xffFECACA)),
      ),
      child: Row(
        children: [
          const Icon(Icons.error_outline_rounded, color: Color(0xffDC2626)),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(color: Color(0xff991B1B)),
            ),
          ),
          if (onRetry != null)
            TextButton(onPressed: onRetry, child: const Text('Retry')),
        ],
      ),
    );
  }
}
