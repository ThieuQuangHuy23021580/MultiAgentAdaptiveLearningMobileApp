import 'package:flutter/material.dart';

import 'package:multi_agent_adaptive_learning_app/features/solo_session/data/models/chat_models.dart';
import 'package:multi_agent_adaptive_learning_app/features/solo_session/presentations/widgets/history_error_card.dart';
import 'package:multi_agent_adaptive_learning_app/features/solo_session/presentations/widgets/session_tile.dart';

class SessionDrawer extends StatelessWidget {
  const SessionDrawer({
    super.key,
    required this.sessions,
    required this.currentSessionId,
    required this.isLoading,
    required this.isMutating,
    required this.onRefresh,
    required this.onCreateSession,
    required this.onSelectSession,
    required this.onRenameSession,
    required this.onUpdateSummary,
    required this.onDeleteSession,
    this.errorMessage,
  });

  final List<ChatSessionSummary> sessions;
  final String currentSessionId;
  final bool isLoading;
  final bool isMutating;
  final String? errorMessage;

  final VoidCallback onRefresh;
  final VoidCallback onCreateSession;

  final ValueChanged<ChatSessionSummary> onSelectSession;
  final ValueChanged<ChatSessionSummary> onRenameSession;
  final ValueChanged<ChatSessionSummary> onUpdateSummary;
  final ValueChanged<ChatSessionSummary> onDeleteSession;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xffF8FAFC),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 18, 12, 16),
              child: Row(
                children: [
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Sessions',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Solo AI chat history',
                          style: TextStyle(
                            color: Color(0xff64748B),
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    tooltip: 'Refresh',
                    onPressed: isLoading ? null : onRefresh,
                    icon: const Icon(Icons.refresh_rounded),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 14, 14, 0),
              child: SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: isMutating ? null : onCreateSession,
                  icon: isMutating
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.add_rounded),
                  label: const Text('New session'),
                ),
              ),
            ),
            Expanded(child: _buildHistoryList(context)),
          ],
        ),
      ),
    );
  }

  Widget _buildHistoryList(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (sessions.isEmpty && errorMessage == null) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Text(
            'No sessions yet.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Color(0xff64748B)),
          ),
        ),
      );
    }

    return ListView(
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 24),
      children: [
        if (errorMessage != null)
          HistoryErrorCard(
            title: 'Cannot load sessions',
            message: errorMessage!,
            onRefresh: onRefresh,
          ),
        ...sessions.map((session) {
          return SessionTile(
            session: session,
            isSelected: session.id == currentSessionId,
            onTap: () => onSelectSession(session),
            onRename: () => onRenameSession(session),
            onUpdateSummary: () => onUpdateSummary(session),
            onDelete: () => onDeleteSession(session),
          );
        }),
      ],
    );
  }
}
