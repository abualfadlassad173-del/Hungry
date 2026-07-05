import 'package:flutter/material.dart';
import 'package:hungry/core/theme/app_colors.dart';

class AppTheme {
  const AppTheme._();

  static ThemeData get light {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: Appcolors.background,
      brightness: Brightness.light,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme.copyWith(
        primary: Appcolors.background,
        secondary: Appcolors.backgroundDark,
        surface: Appcolors.surface,
        error: Appcolors.error,
      ),
      scaffoldBackgroundColor: Appcolors.surface,
      splashColor: Appcolors.background.withValues(alpha: 0.08),
      highlightColor: Appcolors.background.withValues(alpha: 0.04),
      appBarTheme: const AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Appcolors.surface,
        foregroundColor: Appcolors.textDark,
        centerTitle: false,
      ),
      cardTheme: CardThemeData(
        color: Appcolors.white,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: Appcolors.transparent,
      ),
    );
  }
}
