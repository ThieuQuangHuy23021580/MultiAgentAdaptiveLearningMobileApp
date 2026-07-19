import 'package:flutter/material.dart';
import 'package:multi_agent_adaptive_learning_app/features/solo_session/data/models/chat_models.dart';
import 'package:multi_agent_adaptive_learning_app/features/solo_session/presentations/widgets/appbar/session_app_bar.dart';
import 'package:multi_agent_adaptive_learning_app/features/solo_session/presentations/widgets/artifacts/artifact_panel.dart';
import 'package:multi_agent_adaptive_learning_app/features/solo_session/presentations/widgets/discussion/discussion_panel.dart';
import 'package:multi_agent_adaptive_learning_app/features/solo_session/presentations/widgets/input/floating_input_bar.dart';
import 'package:multi_agent_adaptive_learning_app/features/solo_session/presentations/widgets/appbar/session_tab_bar.dart';
import 'package:multi_agent_adaptive_learning_app/features/solo_session/presentations/widgets/knowledge/knowledge_panel.dart';
import 'package:flutter/material.dart';
import 'package:multi_agent_adaptive_learning_app/features/solo_session/presentations/widgets/session_drawer.dart';
import 'package:multi_agent_adaptive_learning_app/features/solo_session/presentations/widgets/session_tab_bar.dart';
import 'package:provider/provider.dart';
import 'package:multi_agent_adaptive_learning_app/features/solo_session/presentations/widgets/dialogs/session_dialogs.dart';
import 'package:multi_agent_adaptive_learning_app/features/solo_session/presentations/providers/solo_session_provider.dart';

class SoloSessionScreen extends StatefulWidget {
  const SoloSessionScreen({super.key, this.initialAgent = 'mentor'});

  final String initialAgent;

  @override
  State<SoloSessionScreen> createState() => _SoloSessionScreenState();
}

class _SoloSessionScreenState extends State<SoloSessionScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  late SoloSessionProvider _provider;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _provider.bootstrap();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _provider = context.read<SoloSessionProvider>();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SoloSessionProvider>();

    final currentAgent = provider.currentAgent;

    final agents = provider.agents;

    final sessions = provider.sessions;

    final messages = provider.messages;

    final isLoadingHistory = provider.isLoadingHistory;

    final isLoadingAgents = provider.isLoadingAgents;

    final isLoadingSessions = provider.isLoadingSessions;

    final isSending = provider.isSending;

    final isMutatingSession = provider.isMutatingSession;

    final errorMessage = provider.errorMessage;

    final drawerErrorMessage = provider.drawerErrorMessage;

    final currentSessionId = provider.currentSessionId;

    final selectedAgent = provider.selectedAgent;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        key: _scaffoldKey,
        extendBodyBehindAppBar: true,
        backgroundColor: const Color(0xffF4F6FA),

        appBar: SessionAppBar(
          onMenuPressed: () {
            _scaffoldKey.currentState?.openDrawer();
            provider.loadSessions();
          },
        ),

        drawer: SessionDrawer(
          sessions: sessions,
          currentSessionId: currentSessionId,
          isLoading: isLoadingSessions,
          isMutating: isMutatingSession,
          errorMessage: drawerErrorMessage,
          onRefresh: provider.loadSessions,
          onSelectSession: (session) async {
            Navigator.pop(context);
            await provider.selectSession(session);
          },
          onCreateSession: () async {
            final title = await showSessionInputDialog(
              context: context,
              title: 'New session',
              label: 'Title',
              initialValue: 'Solo mentor session',
              confirmLabel: 'Create',
            );

            if (title == null || title.trim().isEmpty) {
              return;
            }

            if (!context.mounted) return;

            Navigator.pop(context);

            await provider.createSession(title);
          },

          onRenameSession: (session) async {
            final title = await showSessionInputDialog(
              context: context,
              title: 'Rename session',
              label: 'Title',
              initialValue: session.title,
              confirmLabel: 'Save',
            );

            if (title == null ||
                title.trim().isEmpty ||
                title.trim() == session.title) {
              return;
            }

            await provider.renameSession(sessionId: session.id, title: title);
          },

          onUpdateSummary: (session) async {
            final summary = await showSessionInputDialog(
              context: context,
              title: 'Session summary',
              label: 'Summary',
              initialValue: session.summary ?? '',
              confirmLabel: 'Save',
              maxLines: 4,
            );

            if (summary == null) {
              return;
            }

            await provider.updateSessionSummary(
              sessionId: session.id,
              summary: summary,
            );
          },

          onDeleteSession: (session) async {
            final confirmed = await showDeleteSessionDialog(
              context: context,
              sessionTitle: session.title,
            );

            if (!confirmed) {
              return;
            }

            if (!context.mounted) return;

            Navigator.pop(context);

            await provider.deleteSession(session);
          },
        ),

        body: SafeArea(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 10),
                child: Column(
                  children: [
                    const SessionTabBar(),

                    const SizedBox(height: 12),

                    // _AgentSelectorBar(
                    //   agents: agents,
                    //   selectedAgent: selectedAgent,
                    //   isLoading: isLoadingAgents,
                    //   onSelectAgent: provider.selectAgent,
                    //   onRefresh: provider.loadAgents,
                    // ),
                    const SizedBox(height: 16),

                    Expanded(
                      child: TabBarView(
                        children: [
                          DiscussionPanel(
                            messages: messages,
                            isLoadingHistory: isLoadingHistory,
                            isSending: isSending,
                            errorMessage: errorMessage,
                            onRetry: provider.loadHistory,
                            agentName: currentAgent.name,
                            agentAvatar: currentAgent.avatarUrl,
                          ),
                          const KnowledgePanel(),
                          const ArtifactPanel(),
                        ],
                      ),
                    ),

                    const SizedBox(height: 170),
                  ],
                ),
              ),

              Align(
                alignment: Alignment.bottomCenter,
                child: SafeArea(
                  minimum: const EdgeInsets.only(
                    left: 18,
                    right: 18,
                    bottom: 90,
                  ),
                  child: FloatingInputBar(
                    enabled: !isSending && !isLoadingHistory,
                    onSend: provider.sendMessage,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class _AgentSelectorBar extends StatelessWidget {
//   const _AgentSelectorBar({
//     required this.agents,
//     required this.selectedAgent,
//     required this.isLoading,
//     required this.onSelectAgent,
//     required this.onRefresh,
//   });

//   final List<AgentInfo> agents;
//   final String selectedAgent;
//   final bool isLoading;
//   final ValueChanged<String> onSelectAgent;
//   final VoidCallback onRefresh;

//   @override
//   Widget build(BuildContext context) {
//     final selected = agents.where((agent) => agent.name == selectedAgent);
//     final description = selected.isEmpty
//         ? 'Tap to change active AI'
//         : selected.first.description ?? 'Tap to change active AI';

//     return Material(
//       color: Colors.white.withOpacity(.86),
//       borderRadius: BorderRadius.circular(16),
//       child: InkWell(
//         borderRadius: BorderRadius.circular(16),
//         onTap: () => _showAgentPicker(context),
//         child: Container(
//           padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(16),
//             border: Border.all(color: const Color(0xffD8E2F0)),
//           ),
//           child: Row(
//             children: [
//               Container(
//                 width: 38,
//                 height: 38,
//                 decoration: BoxDecoration(
//                   color: const Color(0xffE8F0FF),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: const Icon(
//                   Icons.psychology_alt_outlined,
//                   color: Color(0xff2563EB),
//                 ),
//               ),
//               const SizedBox(width: 12),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       selectedAgent,
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis,
//                       style: const TextStyle(
//                         fontSize: 15,
//                         fontWeight: FontWeight.w800,
//                         color: Color(0xff0F172A),
//                       ),
//                     ),
//                     const SizedBox(height: 2),
//                     Text(
//                       description,
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis,
//                       style: const TextStyle(
//                         fontSize: 12,
//                         color: Color(0xff64748B),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(width: 8),
//               if (isLoading)
//                 const SizedBox(
//                   width: 18,
//                   height: 18,
//                   child: CircularProgressIndicator(strokeWidth: 2),
//                 )
//               else
//                 const Icon(
//                   Icons.keyboard_arrow_down_rounded,
//                   color: Color(0xff475569),
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Future<void> _showAgentPicker(BuildContext context) {
//     return showModalBottomSheet<void>(
//       context: context,
//       showDragHandle: true,
//       backgroundColor: const Color(0xffF8FAFC),
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
//       ),
//       builder: (context) {
//         return SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.fromLTRB(18, 8, 18, 18),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   children: [
//                     const Expanded(
//                       child: Text(
//                         'Choose agent',
//                         style: TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.w800,
//                         ),
//                       ),
//                     ),
//                     IconButton(
//                       tooltip: 'Refresh agents',
//                       onPressed: onRefresh,
//                       icon: const Icon(Icons.refresh_rounded),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 8),
//                 ...agents.map((agent) {
//                   final isSelected = agent.name == selectedAgent;

//                   return Padding(
//                     padding: const EdgeInsets.only(bottom: 10),
//                     child: Material(
//                       color: isSelected
//                           ? const Color(0xffE8F0FF)
//                           : Colors.white,
//                       borderRadius: BorderRadius.circular(14),
//                       child: InkWell(
//                         borderRadius: BorderRadius.circular(14),
//                         onTap: () {
//                           onSelectAgent(agent.name);
//                           Navigator.pop(context);
//                         },
//                         child: Padding(
//                           padding: const EdgeInsets.all(14),
//                           child: Row(
//                             children: [
//                               Icon(
//                                 _agentIcon(agent.name),
//                                 color: isSelected
//                                     ? const Color(0xff2563EB)
//                                     : const Color(0xff475569),
//                               ),
//                               const SizedBox(width: 12),
//                               Expanded(
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       agent.name,
//                                       style: const TextStyle(
//                                         fontSize: 15,
//                                         fontWeight: FontWeight.w800,
//                                       ),
//                                     ),
//                                     if (agent.description != null) ...[
//                                       const SizedBox(height: 4),
//                                       Text(
//                                         agent.description!,
//                                         maxLines: 2,
//                                         overflow: TextOverflow.ellipsis,
//                                         style: const TextStyle(
//                                           color: Color(0xff64748B),
//                                           fontSize: 12,
//                                           height: 1.35,
//                                         ),
//                                       ),
//                                     ],
//                                   ],
//                                 ),
//                               ),
//                               if (isSelected)
//                                 const Icon(
//                                   Icons.check_circle_rounded,
//                                   color: Color(0xff2563EB),
//                                 ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   );
//                 }),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   IconData _agentIcon(String agentName) {
//     switch (agentName) {
//       case 'planner':
//         return Icons.event_note_outlined;
//       case 'research':
//         return Icons.manage_search_rounded;
//       case 'mentor':
//       default:
//         return Icons.school_outlined;
//     }
//   }
// }
