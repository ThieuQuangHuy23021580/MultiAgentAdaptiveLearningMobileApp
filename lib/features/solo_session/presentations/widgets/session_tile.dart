import 'package:flutter/material.dart';
import 'package:multi_agent_adaptive_learning_app/features/solo_session/data/models/chat_models.dart';
import 'package:multi_agent_adaptive_learning_app/features/solo_session/presentations/widgets/session_meta_chip.dart';

enum SessionAction { rename, summary, delete }

class SessionTile extends StatelessWidget {
  const SessionTile({
    required this.session,
    required this.isSelected,
    required this.onTap,
    required this.onRename,
    required this.onUpdateSummary,
    required this.onDelete,
  });

  final ChatSessionSummary session;
  final bool isSelected;
  final VoidCallback onTap;
  final VoidCallback onRename;
  final VoidCallback onUpdateSummary;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Material(
        color: isSelected ? const Color(0xffE8F0FF) : Colors.white,
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.forum_outlined,
                      size: 18,
                      color: isSelected
                          ? const Color(0xff2563EB)
                          : const Color(0xff475569),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        session.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 13,
                        ),
                      ),
                    ),
                    if (isSelected)
                      const Icon(
                        Icons.check_circle_rounded,
                        size: 18,
                        color: Color(0xff2563EB),
                      ),
                    PopupMenuButton<SessionAction>(
                      tooltip: 'Session actions',
                      icon: const Icon(Icons.more_horiz_rounded, size: 20),
                      onSelected: (action) {
                        switch (action) {
                          case SessionAction.rename:
                            onRename();
                            break;
                          case SessionAction.summary:
                            onUpdateSummary();
                            break;
                          case SessionAction.delete:
                            onDelete();
                            break;
                        }
                      },
                      itemBuilder: (context) => const [
                        PopupMenuItem(
                          value: SessionAction.rename,
                          child: Row(
                            children: [
                              Icon(Icons.edit_outlined, size: 18),
                              SizedBox(width: 10),
                              Text('Rename'),
                            ],
                          ),
                        ),
                        PopupMenuItem(
                          value: SessionAction.summary,
                          child: Row(
                            children: [
                              Icon(Icons.notes_rounded, size: 18),
                              SizedBox(width: 10),
                              Text('Summary'),
                            ],
                          ),
                        ),
                        PopupMenuItem(
                          value: SessionAction.delete,
                          child: Row(
                            children: [
                              Icon(Icons.delete_outline_rounded, size: 18),
                              SizedBox(width: 10),
                              Text('Delete'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                if (session.summary != null && session.summary!.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Text(
                    session.summary!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Color(0xff475569),
                      fontSize: 12,
                      height: 1.35,
                    ),
                  ),
                ],
                const SizedBox(height: 8),
                Row(
                  children: [
                    SessionMetaChip(
                      label: session.sessionMode ?? 'solo',
                      icon: Icons.person_outline_rounded,
                    ),
                    const SizedBox(width: 8),
                    if (session.status != null)
                      SessionMetaChip(
                        label: session.status!,
                        icon: Icons.circle_outlined,
                      ),
                  ],
                ),
                if (session.lastActiveAt != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    'Last active ${_formatSessionTime(session.lastActiveAt!)}',
                    style: const TextStyle(
                      color: Color(0xff64748B),
                      fontSize: 12,
                    ),
                  ),
                ] else ...[
                  const SizedBox(height: 8),
                  Text(
                    session.id,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Color(0xff64748B),
                      fontSize: 12,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _formatSessionTime(DateTime createdAt) {
    final local = createdAt.toLocal();
    final day = local.day.toString().padLeft(2, '0');
    final month = local.month.toString().padLeft(2, '0');
    final hour = local.hour.toString().padLeft(2, '0');
    final minute = local.minute.toString().padLeft(2, '0');

    return '$day/$month $hour:$minute';
  }
}
