import 'package:flutter/material.dart';
import 'package:multi_agent_adaptive_learning_app/cores/route/app_routes.dart';
import 'package:multi_agent_adaptive_learning_app/features/solo_session/data/services/chat_api_service.dart';
import 'package:multi_agent_adaptive_learning_app/features/solo_session/presentations/controllers/agent_controller.dart';
import 'package:multi_agent_adaptive_learning_app/features/solo_session/presentations/controllers/chat_controller.dart';
import 'package:multi_agent_adaptive_learning_app/features/solo_session/presentations/controllers/session_controller.dart';
import 'package:multi_agent_adaptive_learning_app/features/solo_session/presentations/providers/solo_session_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const NeoApp());
}

class NeoApp extends StatelessWidget {
  const NeoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => ChatApiService()),
        Provider(
          create: (context) =>
              AgentController(api: context.read<ChatApiService>()),
        ),
        Provider(
          create: (context) =>
              SessionController(api: context.read<ChatApiService>()),
        ),
        Provider(
          create: (context) =>
              ChatController(api: context.read<ChatApiService>()),
        ),
        ChangeNotifierProvider(
          create: (context) => SoloSessionProvider(
            agentController: context.read<AgentController>(),
            sessionController: context.read<SessionController>(),
            chatController: context.read<ChatController>(),
          ),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,

        routerConfig: AppRoutes.router,

        theme: ThemeData(useMaterial3: true),
      ),
    );
  }
}
