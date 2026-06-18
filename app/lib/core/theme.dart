import 'package:flutter/material.dart';

const _seedColor = Color(0xFF1B6CA8);

ThemeData _base(ColorScheme colorScheme) => ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        elevation: 0,
      ),
      cardTheme: CardThemeData(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size(double.infinity, 52),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        filled: true,
      ),
    );

final appTheme = _base(
  ColorScheme.fromSeed(seedColor: _seedColor, brightness: Brightness.light),
);

final appDarkTheme = _base(
  ColorScheme.fromSeed(seedColor: _seedColor, brightness: Brightness.dark),
);
