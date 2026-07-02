import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme {
    final base = ThemeData(useMaterial3: true, brightness: Brightness.light);

    return base.copyWith(
      scaffoldBackgroundColor: AppColors.scaffold,

      colorScheme: ColorScheme.light(
        primary: AppColors.primary,
        surface: AppColors.surface,
        error: AppColors.error,
      ),

      textTheme: GoogleFonts.interTextTheme().copyWith(
        displayLarge: GoogleFonts.inter(
          fontSize: 48,
          fontWeight: FontWeight.bold,
          color: AppColors.onSurface,
        ),
        headlineLarge: GoogleFonts.inter(
          fontSize: 32,
          fontWeight: FontWeight.w600,
          color: AppColors.onSurface,
        ),
        headlineMedium: GoogleFonts.inter(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: AppColors.onSurface,
        ),
        bodyLarge: GoogleFonts.inter(fontSize: 18, color: AppColors.secondary),
        bodyMedium: GoogleFonts.inter(fontSize: 16, color: AppColors.secondary),
        labelLarge: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
        labelSmall: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),

      appBarTheme: const AppBarTheme(
        elevation: 0,
        centerTitle: false,
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.onSurface,
      ),

      cardTheme: CardThemeData(
        color: AppColors.surface,
        elevation: 4,
        shadowColor: AppColors.shadow,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),

      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Colors.white,
        foregroundColor: AppColors.primary,
        elevation: 8,
      ),
    );
  }
}
