import 'package:flutter/material.dart';

import 'agent_status_card.dart';

class AgentStatusPanel extends StatelessWidget {
  const AgentStatusPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        AgentStatusCard(
          icon: Icons.manage_search,
          title: "Researcher",
          subtitle: "Searching IEEE Xplore...",
          progress: .82,
          active: true,
        ),

        AgentStatusCard(
          icon: Icons.school,
          title: "Mentor",
          subtitle: "Analyzing learning objective...",
          progress: .45,
        ),

        AgentStatusCard(
          icon: Icons.summarize,
          title: "Summarizer",
          subtitle: "Waiting for documents...",
          progress: .15,
        ),
      ],
    );
  }
}
