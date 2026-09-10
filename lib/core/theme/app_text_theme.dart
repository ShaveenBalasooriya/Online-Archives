import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract final class AppTextTheme {
  static TextTheme from(TextTheme base) {
    final scale = Typography.material2021().englishLike.merge(base);

    return scale.copyWith(
      displayLarge: _brand(scale.displayLarge),
      displayMedium: _brand(scale.displayMedium),
      displaySmall: _brand(scale.displaySmall),
      headlineLarge: _brand(scale.headlineLarge),
      headlineMedium: _brand(scale.headlineMedium),
      headlineSmall: _brand(scale.headlineSmall),
      titleLarge: _brand(scale.titleLarge),
      titleMedium: _plain(scale.titleMedium),
      titleSmall: _plain(scale.titleSmall),
      bodyLarge: _plain(scale.bodyLarge),
      bodyMedium: _plain(scale.bodyMedium),
      bodySmall: _plain(scale.bodySmall),
      labelLarge: _plain(scale.labelLarge),
      labelMedium: _plain(scale.labelMedium),
      labelSmall: _plain(scale.labelSmall),
    );
  }

  static TextStyle? _brand(TextStyle? style) =>
      style == null ? null : GoogleFonts.merriweather(textStyle: style);

  static TextStyle? _plain(TextStyle? style) =>
      style == null ? null : GoogleFonts.notoSans(textStyle: style);
}
