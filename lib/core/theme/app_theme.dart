import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_text.dart';

const _family = 'Inter';
const _fallback = ['IBM Plex Sans Arabic'];

TextStyle _withFont(TextStyle s, Color color) =>
    s.copyWith(fontFamily: _family, fontFamilyFallback: _fallback, color: color);

/// Material theme with Material defaults switched off (no ripples, no glow)
/// so Cupertino-style widgets and our tokens drive the look.
ThemeData buildTheme(AppColors c, Brightness brightness) {
  final base = ThemeData(
    brightness: brightness,
    useMaterial3: true,
    fontFamily: _family,
    fontFamilyFallback: _fallback,
    scaffoldBackgroundColor: c.canvas,
    colorScheme: ColorScheme.fromSeed(seedColor: c.accent, brightness: brightness)
        .copyWith(primary: c.accentStrong, surface: c.canvas, onSurface: c.ink),
    splashFactory: NoSplash.splashFactory,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    hoverColor: Colors.transparent,
    dividerColor: c.separator,
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: c.accent,
      selectionColor: c.accentSoft,
      selectionHandleColor: c.accent,
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: c.surface,
      modalBackgroundColor: c.surface,
      modalBarrierColor: Colors.black.withValues(alpha: 0.3),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(14)),
      ),
      showDragHandle: true,
      dragHandleColor: c.grey3,
      dragHandleSize: const Size(36, 5),
    ),
    cupertinoOverrideTheme: CupertinoThemeData(
      brightness: brightness,
      primaryColor: c.accentStrong,
      textTheme: CupertinoTextThemeData(
        primaryColor: c.accentStrong,
        textStyle: _withFont(AppText.bodyCompact, c.ink),
        navLargeTitleTextStyle: _withFont(AppText.largeTitle, c.ink),
        navTitleTextStyle: _withFont(AppText.headline, c.ink),
        navActionTextStyle: _withFont(AppText.bodyCompact, c.accentStrong),
      ),
    ),
    extensions: [c],
  );
  return base.copyWith(
    textTheme: base.textTheme.apply(bodyColor: c.ink, displayColor: c.ink),
  );
}

/// iOS bounce instead of the Android overscroll glow.
class BouncyScrollBehavior extends MaterialScrollBehavior {
  const BouncyScrollBehavior();

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) =>
      const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics());

  @override
  Widget buildOverscrollIndicator(
          BuildContext context, Widget child, ScrollableDetails details) =>
      child;
}
