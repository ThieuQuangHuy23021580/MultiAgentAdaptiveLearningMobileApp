import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_agent_adaptive_learning_app/cores/theme/app_theme.dart';

import 'features/home/presentations/screens/home_screen.dart';

class NeoLearningApp extends StatelessWidget {
  const NeoLearningApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1440, 1024),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Neo Learning OS',

          theme: AppTheme.lightTheme,

          home: const HomeScreen(),
        );
      },
    );
  }
}
