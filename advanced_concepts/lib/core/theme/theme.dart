import 'package:advanced_concepts/core/theme/app_color.dart';
import 'package:flutter/material.dart';

export 'package:advanced_concepts/core/theme/app_breakpoint.dart';
export 'package:advanced_concepts/core/theme/app_color.dart';

ThemeData getLightTheme() {
  return _buildTheme(_getColorScheme());
}

ThemeData _buildTheme(ColorScheme colorScheme) {
  const textTheme = TextTheme(
    /// Landing section titles.
    titleLarge: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w600,
      color: AppColor.teal,
    ),

    /// List titles (book rows, user rows).
    titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),

    /// Lab subsection titles.
    titleSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),

    /// Rules and body copy.
    bodyMedium: TextStyle(fontSize: 14),

    /// Captions, hints, [CodeSnippet] size.
    bodySmall: TextStyle(fontSize: 12, height: 1.35),

    /// Cells, chips, nav calls.
    labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),

    /// SegmentedButton labels.
    labelMedium: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),

    /// Tiny labels (leftover, overflow chips).
    labelSmall: TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
  );

  const appBarSize = 20.0;

  return ThemeData(
    colorScheme: colorScheme,
    textTheme: textTheme,
    actionIconTheme: ActionIconThemeData(
      backButtonIconBuilder: (context) {
        final cupertino = switch (Theme.of(context).platform) {
          TargetPlatform.iOS || TargetPlatform.macOS => true,
          _ => false,
        };
        // iOS chevron reads larger than search/refresh at the same size.
        return Icon(
          cupertino ? Icons.arrow_back_ios_new_rounded : Icons.arrow_back,
          size: cupertino ? 16 : appBarSize,
        );
      },
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: colorScheme.primaryContainer,
      foregroundColor: colorScheme.onPrimaryContainer,
      elevation: 0,
      titleTextStyle: TextStyle(
        fontSize: appBarSize,
        fontWeight: FontWeight.w600,
        color: colorScheme.onPrimaryContainer,
      ),
      iconTheme: IconThemeData(
        color: colorScheme.onPrimaryContainer,
        size: appBarSize,
      ),
      actionsIconTheme: IconThemeData(
        color: colorScheme.onPrimaryContainer,
        size: appBarSize,
      ),
    ),
    listTileTheme: ListTileThemeData(
      titleTextStyle: textTheme.titleMedium?.copyWith(
        color: colorScheme.onSurface,
      ),
      subtitleTextStyle: textTheme.bodyMedium?.copyWith(
        color: colorScheme.onSurfaceVariant,
      ),
    ),
    segmentedButtonTheme: SegmentedButtonThemeData(
      style: ButtonStyle(
        textStyle: WidgetStatePropertyAll(textTheme.labelMedium),
        visualDensity: VisualDensity.compact,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      // Solid gray, not a tinted overlay — hints must not look like typed text.
      hintStyle: TextStyle(
        color: Color.alphaBlend(
          colorScheme.onSurface.withValues(alpha: 0.42),
          colorScheme.surface,
        ),
      ),
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: AppColor.tertiary,
      contentTextStyle: textTheme.labelLarge?.copyWith(color: AppColor.teal),
      behavior: SnackBarBehavior.floating,
    ),
  );
}

ColorScheme _getColorScheme() {
  return ColorScheme.fromSeed(
    seedColor: AppColor.primary,
    dynamicSchemeVariant: DynamicSchemeVariant.fidelity,
    primary: AppColor.primary,
    primaryContainer: AppColor.primaryContainer,
    secondary: AppColor.secondary,
    secondaryContainer: AppColor.secondaryContainer,
    tertiary: AppColor.tertiary,
  ).copyWith(
    tertiary: AppColor.tertiary,
    onTertiary: AppColor.teal,
    tertiaryContainer: AppColor.teal,
    onTertiaryContainer: AppColor.tertiary,
    error: AppColor.error,
    onError: AppColor.onError,
    errorContainer: AppColor.errorContainer,
    onErrorContainer: AppColor.onErrorContainer,
  );
}

extension AdvancedConceptsTextTheme on TextTheme {
  /// Dart snippets. Size comes from [bodySmall]; family is code-only.
  TextStyle get code => bodySmall!.copyWith(fontFamily: 'monospace');
}
