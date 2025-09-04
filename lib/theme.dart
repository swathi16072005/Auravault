import 'package:flutter/material.dart';

const Color kPrimaryBlue = Color(0xFF5B8DEF);
const Color kSuccessGreen = Color(0xFF75E0A3);
const Color kErrorRed = Color(0xFFFF6B6B);

ThemeData buildLightTheme(TextTheme textTheme) {
  final colorScheme = ColorScheme.fromSeed(seedColor: kPrimaryBlue, brightness: Brightness.light);
  return ThemeData(
    useMaterial3: true,
    colorScheme: colorScheme,
    textTheme: textTheme,
    scaffoldBackgroundColor: colorScheme.surface,
    appBarTheme: AppBarTheme(backgroundColor: colorScheme.surface, foregroundColor: colorScheme.onSurface),
    cardTheme: const CardThemeData(clipBehavior: Clip.antiAlias, shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))), elevation: 0),
    snackBarTheme: SnackBarThemeData(backgroundColor: colorScheme.surfaceContainer, contentTextStyle: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurface)),
  );
}

ThemeData buildDarkTheme(TextTheme textTheme) {
  final colorScheme = ColorScheme.fromSeed(seedColor: kPrimaryBlue, brightness: Brightness.dark);
  return ThemeData(
    useMaterial3: true,
    colorScheme: colorScheme,
    textTheme: textTheme,
    scaffoldBackgroundColor: colorScheme.surface,
    appBarTheme: AppBarTheme(backgroundColor: colorScheme.surface, foregroundColor: colorScheme.onSurface),
    cardTheme: const CardThemeData(clipBehavior: Clip.antiAlias, shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))), elevation: 0),
    snackBarTheme: SnackBarThemeData(backgroundColor: colorScheme.surfaceContainer, contentTextStyle: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurface)),
  );
}


