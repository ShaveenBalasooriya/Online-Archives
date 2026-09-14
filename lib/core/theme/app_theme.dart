import 'package:flutter/material.dart';
import 'package:online_archive/core/theme/app_color_schemes.dart';
import 'package:online_archive/core/theme/app_text_theme.dart';

abstract final class AppTheme {
  static ThemeData get light => _fromScheme(AppColorSchemes.light);

  static ThemeData get lightHighContrast =>
      _fromScheme(AppColorSchemes.lightHighContrast);

  static ThemeData get dark => _fromScheme(AppColorSchemes.dark);

  static ThemeData get darkHighContrast =>
      _fromScheme(AppColorSchemes.darkHighContrast);

  static ThemeData _fromScheme(ColorScheme colorScheme) {
    final base = ThemeData(colorScheme: colorScheme, useMaterial3: true);
    return base.copyWith(textTheme: AppTextTheme.from(base.textTheme));
  }
}
