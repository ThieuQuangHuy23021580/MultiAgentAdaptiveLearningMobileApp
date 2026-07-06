import 'package:flutter/material.dart';

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
    return Scaffold(
      extendBodyBehindAppBar: true,

      backgroundColor: const Color(0xffF4F6FA),

      appBar: NeoTopBar(
        sessionTitle: "Neural Networks Fundamentals",

        onMenuPressed: () {},

        onClosePressed: () {
          Navigator.pop(context);
        },
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 18, 24, 10),
          child: Column(
            children: [
              SizedBox(height: 400, child: const DiscussionPanel()),

              const SizedBox(height: 18),

              Expanded(
                child: Column(
                  children: [
                    // KnowledgePanel(),
                    // SizedBox(height: 8),
                    ArtifactPanel(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      bottomSheet: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 90),
          child: FloatingInputBar(onSend: onSend),
        ),
      ),
    );
  }
}
