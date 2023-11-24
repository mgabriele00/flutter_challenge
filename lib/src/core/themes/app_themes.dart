import 'package:flutter/material.dart';
import 'package:flutter_challenge/src/core/constants/app_sizes.dart';

/// A class responsible for defining application themes.
class AppThemes {
  /// Generates a ThemeData based on the provided [brightness].
  ///
  /// [brightness] is an optional parameter of type [Brightness] used to determine the overall brightness of the theme.
  /// If not provided, the default brightness is set to [Brightness.light].
  ///
  /// Returns a [ThemeData] instance configured with specific color schemes, input decoration themes, etc.
  static ThemeData theme([Brightness brightness = Brightness.light]) =>
      ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xffdb9519),
          brightness: brightness,
        ),
        useMaterial3: true,
        inputDecorationTheme: InputDecorationTheme(
          contentPadding:
          const EdgeInsets.symmetric(horizontal: AppSizes.p12),
          border: OutlineInputBorder(
            gapPadding: 0,
            borderRadius: BorderRadius.circular(AppSizes.p12),
          ),
        ),
      );
}
