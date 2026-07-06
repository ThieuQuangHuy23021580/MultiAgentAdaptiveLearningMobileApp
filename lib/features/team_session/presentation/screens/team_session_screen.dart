import 'package:flutter/material.dart';
import 'package:multi_agent_adaptive_learning_app/features/team_session/presentation/widgets/appbar/session_tab_bar.dart';

import '../widgets/appbar/neo_top_bar.dart';
import '../widgets/artifacts/artifact_panel.dart';
import '../widgets/discussion/discussion_panel.dart';
import '../widgets/input/floating_input_bar.dart';
import '../widgets/knowledge/knowledge_panel.dart';

class TeamSessionScreen extends StatefulWidget {
  const TeamSessionScreen({super.key});

  @override
  State<TeamSessionScreen> createState() => _TeamSessionScreenState();
}

class _TeamSessionScreenState extends State<TeamSessionScreen> {
  final List<String> history = [];

  void onSend(String text) {
    setState(() {
      history.add(text);
    });

    debugPrint(text);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: const Color(0xffF4F6FA),

        appBar: SessionAppBar(),
        body: SafeArea(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 10),
                child: Column(
                  children: [
                    const _SessionTabBar(),

                    const SizedBox(height: 20),

                    const Expanded(
                      child: TabBarView(
                        children: [
                          DiscussionPanel(),
                          KnowledgePanel(),
                          ArtifactPanel(),
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
                  child: FloatingInputBar(onSend: onSend),
                ),
              ),
            ],
          ),
        ),
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
