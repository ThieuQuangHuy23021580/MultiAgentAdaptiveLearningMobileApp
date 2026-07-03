import 'package:flutter/material.dart';
import 'package:multi_agent_adaptive_learning_app/cores/route/app_routes.dart';

void main() {
  runApp(const NeoApp());
}

class NeoApp extends StatelessWidget {
  const NeoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,

      routerConfig: AppRoutes.router,

      theme: ThemeData(useMaterial3: true),
    );
  }
}
