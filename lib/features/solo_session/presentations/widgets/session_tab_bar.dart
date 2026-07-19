import 'package:flutter/material.dart';
import 'package:multi_agent_adaptive_learning_app/features/solo_session/presentations/widgets/appbar/session_tab_bar.dart';

class SessionTabBar extends StatelessWidget {
  const SessionTabBar();

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
