import 'package:flutter/material.dart';
import 'package:multi_agent_adaptive_learning_app/features/solo_session/data/models/chat_models.dart';
import 'package:multi_agent_adaptive_learning_app/features/solo_session/data/services/chat_api_service.dart';
import 'package:multi_agent_adaptive_learning_app/features/solo_session/presentations/widgets/appbar/session_app_bar.dart';
import 'package:multi_agent_adaptive_learning_app/features/solo_session/presentations/widgets/artifacts/artifact_panel.dart';
import 'package:multi_agent_adaptive_learning_app/features/solo_session/presentations/widgets/discussion/discussion_panel.dart';
import 'package:multi_agent_adaptive_learning_app/features/solo_session/presentations/widgets/input/floating_input_bar.dart';
import 'package:multi_agent_adaptive_learning_app/features/solo_session/presentations/widgets/appbar/session_tab_bar.dart';
import 'package:multi_agent_adaptive_learning_app/features/solo_session/presentations/widgets/knowledge/knowledge_panel.dart';

class SoloSessionScreen extends StatefulWidget {
  const SoloSessionScreen({super.key, this.initialAgent = "mentor"});

  final String initialAgent;

  @override
  State<SoloSessionScreen> createState() => _SoloSessionScreenState();
}

class _SoloSessionScreenState extends State<SoloSessionScreen> {
  static const _fallbackSessionId = 'session-test-1';
  static const _userId = '1';
  static const _fallbackAgentNames = ['mentor', 'planner', 'research'];

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ChatApiService _api = ChatApiService();
  final List<ChatMessage> _messages = [];
  final List<ChatSessionSummary> _sessions = [];
  final List<AgentInfo> _agents = [];

  String _currentSessionId = _fallbackSessionId;
  late String _selectedAgent;
  bool _isLoadingHistory = true;
  bool _isLoadingSessions = false;
  bool _isLoadingAgents = false;
  bool _isSending = false;
  bool _isMutatingSession = false;
  String? _errorMessage;
  String? _drawerErrorMessage;

  @override
  void initState() {
    super.initState();

    _selectedAgent = widget.initialAgent;

    _bootstrapSession();
  }

  @override
  void dispose() {
    _api.dispose();
    super.dispose();
  }

  Future<void> _bootstrapSession() async {
    _loadAgents();
    await _loadSessions(selectInitialSession: true);
    await _loadHistory();
  }

  Future<void> _loadAgents() async {
    setState(() {
      _isLoadingAgents = true;
    });

    try {
      final agents = await _api.getAgents();

      if (!mounted) return;

      setState(() {
        _agents
          ..clear()
          ..addAll(agents.where((agent) => agent.isActive));

        if (_agents.isNotEmpty &&
            !_agents.any((agent) => agent.name == _selectedAgent)) {
          _selectedAgent = _agents.first.name;
        }
      });
    } catch (error) {
      debugPrint('Load agents failed: $error');
    } finally {
      if (!mounted) return;

      setState(() {
        _isLoadingAgents = false;
      });
    }
  }

  List<AgentInfo> get _availableAgents {
    final merged = <AgentInfo>[..._agents];

    for (final fallbackName in _fallbackAgentNames) {
      final exists = merged.any((agent) => agent.name == fallbackName);
      if (exists) continue;

      merged.add(
        AgentInfo(
          id: fallbackName,
          name: fallbackName,
          description: _fallbackAgentDescription(fallbackName),
          isActive: true,
        ),
      );
    }

    return merged;
  }

  AgentInfo get _currentAgent =>
      _availableAgents.firstWhere((agent) => agent.name == _selectedAgent);

  String _fallbackAgentDescription(String name) {
    if (name == 'planner') return 'Plan study steps and break down goals.';
    if (name == 'research') {
      return 'Research, synthesize, and explain knowledge.';
    }
    if (name == 'mentor') return 'Guide learning and answer questions.';

    switch (name) {
      case 'planner':
        return 'Lập kế hoạch học tập và chia nhỏ mục tiêu.';
      case 'research':
        return 'Tìm, tổng hợp và giải thích kiến thức.';
      case 'mentor':
      default:
        return 'Hướng dẫn học tập và giải đáp thắc mắc.';
    }
  }

  void _selectAgent(String agentName) {
    setState(() {
      _selectedAgent = agentName;
    });
  }

  Future<void> _loadHistory() async {
    setState(() {
      _isLoadingHistory = true;
      _errorMessage = null;
    });

    try {
      final history = await _api.getHistory(_currentSessionId);

      if (!mounted) return;

      setState(() {
        _messages
          ..clear()
          ..addAll(history);
      });
    } on ApiException catch (error) {
      if (!mounted) return;

      setState(() {
        _errorMessage = error.message;
      });
    } catch (error) {
      debugPrint('Load history failed: $error');

      if (!mounted) return;

      setState(() {
        _errorMessage = 'Cannot connect to the backend. Check FastAPI server.';
      });
    } finally {
      if (!mounted) return;

      setState(() {
        _isLoadingHistory = false;
      });
    }
  }

  void _openHistoryDrawer() {
    _scaffoldKey.currentState?.openDrawer();
    _loadSessions();
  }

  Future<void> _loadSessions({bool selectInitialSession = false}) async {
    setState(() {
      _isLoadingSessions = true;
      _drawerErrorMessage = null;
    });

    try {
      final sessions = await _api.getSessions(userId: _userId);

      if (!mounted) return;

      setState(() {
        _sessions
          ..clear()
          ..addAll(sessions);

        if (selectInitialSession && sessions.isNotEmpty) {
          final hasCurrent = sessions.any(
            (session) => session.id == _currentSessionId,
          );

          if (!hasCurrent) {
            _currentSessionId = sessions.first.id;
          }
        }
      });
    } on ApiException catch (error) {
      if (!mounted) return;

      setState(() {
        _drawerErrorMessage = error.message;
        _sessions
          ..clear()
          ..addAll(_fallbackSessions);
      });
    } catch (error) {
      debugPrint('Load sessions failed: $error');

      if (!mounted) return;

      setState(() {
        _drawerErrorMessage =
            'Cannot connect to the backend. Check FastAPI server.';
        _sessions
          ..clear()
          ..addAll(_fallbackSessions);
      });
    } finally {
      if (!mounted) return;

      setState(() {
        _isLoadingSessions = false;
      });
    }
  }

  List<ChatSessionSummary> get _fallbackSessions {
    return const [
      ChatSessionSummary(
        id: _fallbackSessionId,
        title: 'Solo mentor session',
        sessionMode: 'solo',
        status: 'active',
      ),
    ];
  }

  Future<void> _selectSession(ChatSessionSummary session) async {
    _scaffoldKey.currentState?.closeDrawer();

    setState(() {
      _currentSessionId = session.id;
    });

    await _loadHistory();
  }

  Future<void> _createSession() async {
    final title = await _promptSessionText(
      title: 'New session',
      label: 'Title',
      initialValue: 'Solo mentor session',
      confirmLabel: 'Create',
    );

    if (title == null || title.trim().isEmpty) return;

    setState(() {
      _isMutatingSession = true;
      _drawerErrorMessage = null;
    });

    try {
      final session = await _api.createSession(
        userId: _userId,
        title: title.trim(),
      );

      if (!mounted) return;

      _scaffoldKey.currentState?.closeDrawer();

      setState(() {
        _currentSessionId = session.id;
        _sessions
          ..removeWhere((item) => item.id == session.id)
          ..insert(0, session);
        _messages.clear();
      });

      await _loadHistory();
    } on ApiException catch (error) {
      _showSessionError(error.message);
    } catch (error) {
      debugPrint('Create session failed: $error');
      _showSessionError('Cannot create session. Check FastAPI server.');
    } finally {
      if (!mounted) return;

      setState(() {
        _isMutatingSession = false;
      });
    }
  }

  Future<void> _renameSession(ChatSessionSummary session) async {
    final title = await _promptSessionText(
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

    await _mutateSession(
      () => _api.renameSession(sessionId: session.id, title: title.trim()),
    );
  }

  Future<void> _updateSessionSummary(ChatSessionSummary session) async {
    final summary = await _promptSessionText(
      title: 'Session summary',
      label: 'Summary',
      initialValue: session.summary ?? '',
      confirmLabel: 'Save',
      maxLines: 4,
    );

    if (summary == null) return;

    await _mutateSession(
      () => _api.updateSessionSummary(
        sessionId: session.id,
        summary: summary.trim(),
      ),
    );
  }

  Future<void> _deleteSession(ChatSessionSummary session) async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete session'),
          content: Text('Delete "${session.title}" and its session record?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel'),
            ),
            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xffDC2626),
              ),
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );

    if (shouldDelete != true) return;

    setState(() {
      _isMutatingSession = true;
      _drawerErrorMessage = null;
    });

    try {
      await _api.deleteSession(session.id);

      if (!mounted) return;

      setState(() {
        _sessions.removeWhere((item) => item.id == session.id);

        if (_currentSessionId == session.id) {
          _currentSessionId = _sessions.isNotEmpty
              ? _sessions.first.id
              : _fallbackSessionId;
          _messages.clear();
        }
      });

      if (_sessions.isNotEmpty) {
        await _loadHistory();
      }
    } on ApiException catch (error) {
      _showSessionError(error.message);
    } catch (error) {
      debugPrint('Delete session failed: $error');
      _showSessionError('Cannot delete session. Check FastAPI server.');
    } finally {
      if (!mounted) return;

      setState(() {
        _isMutatingSession = false;
      });
    }
  }

  Future<void> _mutateSession(
    Future<ChatSessionSummary> Function() mutation,
  ) async {
    setState(() {
      _isMutatingSession = true;
      _drawerErrorMessage = null;
    });

    try {
      final updated = await mutation();

      if (!mounted) return;

      setState(() {
        final index = _sessions.indexWhere((item) => item.id == updated.id);

        if (index == -1) {
          _sessions.insert(0, updated);
        } else {
          _sessions[index] = updated;
        }
      });
    } on ApiException catch (error) {
      _showSessionError(error.message);
    } catch (error) {
      debugPrint('Update session failed: $error');
      _showSessionError('Cannot update session. Check FastAPI server.');
    } finally {
      if (!mounted) return;

      setState(() {
        _isMutatingSession = false;
      });
    }
  }

  Future<String?> _promptSessionText({
    required String title,
    required String label,
    required String initialValue,
    required String confirmLabel,
    int maxLines = 1,
  }) {
    final controller = TextEditingController(text: initialValue);

    return showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: TextField(
            controller: controller,
            autofocus: true,
            maxLines: maxLines,
            decoration: InputDecoration(labelText: label),
            textInputAction: maxLines == 1
                ? TextInputAction.done
                : TextInputAction.newline,
            onSubmitted: maxLines == 1
                ? (value) => Navigator.pop(context, value)
                : null,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(context, controller.text),
              child: Text(confirmLabel),
            ),
          ],
        );
      },
    ).whenComplete(controller.dispose);
  }

  void _showSessionError(String message) {
    if (!mounted) return;

    setState(() {
      _drawerErrorMessage = message;
    });

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> onSend(String text) async {
    final userMessage = ChatMessage(
      id: 'local-${DateTime.now().microsecondsSinceEpoch}',
      role: 'user',
      content: text,
      createdAt: DateTime.now(),
      senderUserId: _userId,
    );

    setState(() {
      _messages.add(userMessage);
      _isSending = true;
      _errorMessage = null;
    });

    try {
      final response = await _api.sendMessage(
        sessionId: _currentSessionId,
        userId: _userId,
        content: text,
        agent: _selectedAgent,
      );

      if (!mounted) return;

      setState(() {
        _messages.add(
          ChatMessage(
            id: 'agent-${DateTime.now().microsecondsSinceEpoch}',
            role: 'agent',
            content: response.response,
            createdAt: DateTime.now(),
          ),
        );
      });
    } on ApiException catch (error) {
      if (!mounted) return;

      setState(() {
        _errorMessage = error.message;
      });
    } catch (error) {
      debugPrint('Send message failed: $error');

      if (!mounted) return;

      setState(() {
        _errorMessage = 'Cannot connect to the backend. Check FastAPI server.';
      });
    } finally {
      if (!mounted) return;

      setState(() {
        _isSending = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        key: _scaffoldKey,
        extendBodyBehindAppBar: true,
        backgroundColor: const Color(0xffF4F6FA),

        appBar: SessionAppBar(onMenuPressed: _openHistoryDrawer),

        drawer: _ChatSessionDrawer(
          sessions: _sessions,
          currentSessionId: _currentSessionId,
          isLoading: _isLoadingSessions,
          isMutating: _isMutatingSession,
          errorMessage: _drawerErrorMessage,
          onRefresh: _loadSessions,
          onCreateSession: _createSession,
          onSelectSession: _selectSession,
          onRenameSession: _renameSession,
          onUpdateSummary: _updateSessionSummary,
          onDeleteSession: _deleteSession,
        ),

        body: SafeArea(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 10),
                child: Column(
                  children: [
                    const _SessionTabBar(),

                    const SizedBox(height: 12),

                    _AgentSelectorBar(
                      agents: _availableAgents,
                      selectedAgent: _selectedAgent,
                      isLoading: _isLoadingAgents,
                      onSelectAgent: _selectAgent,
                      onRefresh: _loadAgents,
                    ),

                    const SizedBox(height: 16),

                    Expanded(
                      child: TabBarView(
                        children: [
                          DiscussionPanel(
                            messages: _messages,
                            isLoadingHistory: _isLoadingHistory,
                            isSending: _isSending,
                            errorMessage: _errorMessage,
                            onRetry: _loadHistory,
                            agentName: _currentAgent.name,
                            agentAvatar: _currentAgent.avatarUrl,
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
                    onSend: onSend,
                    enabled: !_isSending && !_isLoadingHistory,
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

class _ChatSessionDrawer extends StatelessWidget {
  const _ChatSessionDrawer({
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
          _HistoryErrorCard(
            title: 'Cannot load sessions',
            message: errorMessage!,
            onRefresh: onRefresh,
          ),
        ...sessions.map((session) {
          return _SessionTile(
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

class _AgentSelectorBar extends StatelessWidget {
  const _AgentSelectorBar({
    required this.agents,
    required this.selectedAgent,
    required this.isLoading,
    required this.onSelectAgent,
    required this.onRefresh,
  });

  final List<AgentInfo> agents;
  final String selectedAgent;
  final bool isLoading;
  final ValueChanged<String> onSelectAgent;
  final VoidCallback onRefresh;

  @override
  Widget build(BuildContext context) {
    final selected = agents.where((agent) => agent.name == selectedAgent);
    final description = selected.isEmpty
        ? 'Tap to change active AI'
        : selected.first.description ?? 'Tap to change active AI';

    return Material(
      color: Colors.white.withOpacity(.86),
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => _showAgentPicker(context),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xffD8E2F0)),
          ),
          child: Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: const Color(0xffE8F0FF),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.psychology_alt_outlined,
                  color: Color(0xff2563EB),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      selectedAgent,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: Color(0xff0F172A),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      description,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xff64748B),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              if (isLoading)
                const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              else
                const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: Color(0xff475569),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showAgentPicker(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      backgroundColor: const Color(0xffF8FAFC),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(18, 8, 18, 18),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'Choose agent',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    IconButton(
                      tooltip: 'Refresh agents',
                      onPressed: onRefresh,
                      icon: const Icon(Icons.refresh_rounded),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ...agents.map((agent) {
                  final isSelected = agent.name == selectedAgent;

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Material(
                      color: isSelected
                          ? const Color(0xffE8F0FF)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(14),
                        onTap: () {
                          onSelectAgent(agent.name);
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(14),
                          child: Row(
                            children: [
                              Icon(
                                _agentIcon(agent.name),
                                color: isSelected
                                    ? const Color(0xff2563EB)
                                    : const Color(0xff475569),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      agent.name,
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                    if (agent.description != null) ...[
                                      const SizedBox(height: 4),
                                      Text(
                                        agent.description!,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          color: Color(0xff64748B),
                                          fontSize: 12,
                                          height: 1.35,
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                              if (isSelected)
                                const Icon(
                                  Icons.check_circle_rounded,
                                  color: Color(0xff2563EB),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        );
      },
    );
  }

  IconData _agentIcon(String agentName) {
    switch (agentName) {
      case 'planner':
        return Icons.event_note_outlined;
      case 'research':
        return Icons.manage_search_rounded;
      case 'mentor':
      default:
        return Icons.school_outlined;
    }
  }
}

class _SessionTile extends StatelessWidget {
  const _SessionTile({
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
                    PopupMenuButton<_SessionAction>(
                      tooltip: 'Session actions',
                      icon: const Icon(Icons.more_horiz_rounded, size: 20),
                      onSelected: (action) {
                        switch (action) {
                          case _SessionAction.rename:
                            onRename();
                            break;
                          case _SessionAction.summary:
                            onUpdateSummary();
                            break;
                          case _SessionAction.delete:
                            onDelete();
                            break;
                        }
                      },
                      itemBuilder: (context) => const [
                        PopupMenuItem(
                          value: _SessionAction.rename,
                          child: Row(
                            children: [
                              Icon(Icons.edit_outlined, size: 18),
                              SizedBox(width: 10),
                              Text('Rename'),
                            ],
                          ),
                        ),
                        PopupMenuItem(
                          value: _SessionAction.summary,
                          child: Row(
                            children: [
                              Icon(Icons.notes_rounded, size: 18),
                              SizedBox(width: 10),
                              Text('Summary'),
                            ],
                          ),
                        ),
                        PopupMenuItem(
                          value: _SessionAction.delete,
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
                    _SessionMetaChip(
                      label: session.sessionMode ?? 'solo',
                      icon: Icons.person_outline_rounded,
                    ),
                    const SizedBox(width: 8),
                    if (session.status != null)
                      _SessionMetaChip(
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

enum _SessionAction { rename, summary, delete }

class _SessionMetaChip extends StatelessWidget {
  const _SessionMetaChip({required this.label, required this.icon});

  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: const Color(0xffF1F5F9),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: const Color(0xff64748B)),
          const SizedBox(width: 4),
          Text(
            label,
            style: const TextStyle(
              color: Color(0xff64748B),
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _HistoryErrorCard extends StatelessWidget {
  const _HistoryErrorCard({
    required this.title,
    required this.message,
    required this.onRefresh,
  });

  final String title;
  final String message;
  final VoidCallback onRefresh;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xffFEF2F2),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xffFECACA)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Color(0xff991B1B),
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          Text(message, style: const TextStyle(color: Color(0xff991B1B))),
          const SizedBox(height: 8),
          TextButton(onPressed: onRefresh, child: const Text('Retry')),
        ],
      ),
    );
  }
}

class _SessionTabBar extends StatelessWidget {
  const _SessionTabBar();

  @override
  Widget build(BuildContext context) {
    return TabBar(
      indicatorColor: const Color(0xff2563EB),
      indicatorWeight: 3,
      indicatorSize: TabBarIndicatorSize.label,
      dividerColor: Colors.grey.withOpacity(.2),

      labelColor: const Color(0xff2563EB),
      unselectedLabelColor: Colors.grey,

      labelStyle: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700),

      unselectedLabelStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),

      tabs: const [
        Tab(child: SessionTab(title: "Chat", hasNotification: false)),
        Tab(child: SessionTab(title: "Sources", hasNotification: false)),
        Tab(child: SessionTab(title: "Artifacts", hasNotification: true)),
      ],
    );
  }
}
