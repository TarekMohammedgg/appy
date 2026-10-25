import 'package:flutter/material.dart';

/// Color tokens from `brand/DESIGN.md` (`colors` / `colors-dark`).
@immutable
class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    required this.canvas,
    required this.grouped,
    required this.surface,
    required this.raised,
    required this.parchment,
    required this.ink,
    required this.ink2,
    required this.ink3,
    required this.separator,
    required this.fill3,
    required this.accent,
    required this.accentStrong,
    required this.accentSoft,
    required this.onAccent,
    required this.success,
    required this.danger,
    required this.warning,
    required this.grey,
    required this.grey3,
    required this.grey4,
    required this.bar,
    required this.pill,
  });

  /// White/black page for reading & writing screens (Chat, editor).
  final Color canvas;

  /// Grey page for list screens (Notes, Tasks, Settings).
  final Color grouped;

  /// Rows and cards sitting on [grouped].
  final Color surface;

  /// Bubbles, inputs, audio cards.
  final Color raised;
  final Color parchment;

  final Color ink;
  final Color ink2;
  final Color ink3;
  final Color separator;
  final Color fill3;

  /// Fills only (checked circles, FAB, send, today).
  final Color accent;

  /// Accent used as text or thin icons.
  final Color accentStrong;
  final Color accentSoft;
  final Color onAccent;

  final Color success;
  final Color danger;
  final Color warning;

  final Color grey;
  final Color grey3;
  final Color grey4;

  /// Frosted bar tint (canvas @ 80%).
  final Color bar;

  /// Floating tab pill tint.
  final Color pill;

  static const light = AppColors(
    canvas: Color(0xFFFFFFFF),
    grouped: Color(0xFFF2F2F7),
    surface: Color(0xFFFFFFFF),
    raised: Color(0xFFF2F2F7),
    parchment: Color(0xFFF5F5F7),
    ink: Color(0xFF1D1D1F),
    ink2: Color(0x993C3C43),
    ink3: Color(0x4C3C3C43),
    separator: Color(0x493C3C43),
    fill3: Color(0x1E767680),
    accent: Color(0xFFFFCC00),
    accentStrong: Color(0xFF946F00),
    accentSoft: Color(0xFFFFF4CC),
    onAccent: Color(0xFF1D1D1F),
    success: Color(0xFF34C759),
    danger: Color(0xFFFF3B30),
    warning: Color(0xFFFF9500),
    grey: Color(0xFF8E8E93),
    grey3: Color(0xFFC7C7CC),
    grey4: Color(0xFFD1D1D6),
    bar: Color(0xCCFFFFFF),
    pill: Color(0xD9FFFFFF),
  );

  static const dark = AppColors(
    canvas: Color(0xFF000000),
    grouped: Color(0xFF000000),
    surface: Color(0xFF1C1C1E),
    raised: Color(0xFF2C2C2E),
    parchment: Color(0xFF1C1C1E),
    ink: Color(0xFFFFFFFF),
    ink2: Color(0x99EBEBF5),
    ink3: Color(0x4CEBEBF5),
    separator: Color(0x99545458),
    fill3: Color(0x3D767680),
    accent: Color(0xFFFFD60A),
    accentStrong: Color(0xFFFFD60A),
    accentSoft: Color(0xFF3D3200),
    onAccent: Color(0xFF1D1D1F),
    success: Color(0xFF30D158),
    danger: Color(0xFFFF453A),
    warning: Color(0xFFFF9F0A),
    grey: Color(0xFF8E8E93),
    grey3: Color(0xFF48484A),
    grey4: Color(0xFF3A3A3C),
    bar: Color(0xCC000000),
    pill: Color(0xD92C2C2E),
  );

  @override
  AppColors copyWith() => this;

  @override
  AppColors lerp(AppColors? other, double t) {
    if (other == null) return this;
    Color l(Color a, Color b) => Color.lerp(a, b, t)!;
    return AppColors(
      canvas: l(canvas, other.canvas),
      grouped: l(grouped, other.grouped),
      surface: l(surface, other.surface),
      raised: l(raised, other.raised),
      parchment: l(parchment, other.parchment),
      ink: l(ink, other.ink),
      ink2: l(ink2, other.ink2),
      ink3: l(ink3, other.ink3),
      separator: l(separator, other.separator),
      fill3: l(fill3, other.fill3),
      accent: l(accent, other.accent),
      accentStrong: l(accentStrong, other.accentStrong),
      accentSoft: l(accentSoft, other.accentSoft),
      onAccent: l(onAccent, other.onAccent),
      success: l(success, other.success),
      danger: l(danger, other.danger),
      warning: l(warning, other.warning),
      grey: l(grey, other.grey),
      grey3: l(grey3, other.grey3),
      grey4: l(grey4, other.grey4),
      bar: l(bar, other.bar),
      pill: l(pill, other.pill),
    );
  }
}

extension AppColorsX on BuildContext {
  AppColors get colors => Theme.of(this).extension<AppColors>()!;
}
