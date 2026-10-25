import 'package:flutter/painting.dart';

/// iOS type scale from `brand/DESIGN.md`. Colors come from the theme.
///
/// Letter spacing stays 0: the app is Arabic-first and negative tracking
/// breaks Arabic letter joining.
abstract final class AppText {
  static const largeTitle =
      TextStyle(fontSize: 34, fontWeight: FontWeight.w700, height: 1.21);
  static const title1 =
      TextStyle(fontSize: 28, fontWeight: FontWeight.w700, height: 1.21);
  static const title2 =
      TextStyle(fontSize: 22, fontWeight: FontWeight.w700, height: 1.27);
  static const title3 =
      TextStyle(fontSize: 20, fontWeight: FontWeight.w600, height: 1.25);
  static const headline =
      TextStyle(fontSize: 17, fontWeight: FontWeight.w600, height: 1.29);
  static const body =
      TextStyle(fontSize: 17, fontWeight: FontWeight.w400, height: 1.47);
  static const bodyCompact =
      TextStyle(fontSize: 17, fontWeight: FontWeight.w400, height: 1.29);
  static const subhead =
      TextStyle(fontSize: 15, fontWeight: FontWeight.w400, height: 1.33);
  static const footnote =
      TextStyle(fontSize: 13, fontWeight: FontWeight.w400, height: 1.38);
  static const footnoteStrong =
      TextStyle(fontSize: 13, fontWeight: FontWeight.w600, height: 1.38);
  static const caption1 =
      TextStyle(fontSize: 12, fontWeight: FontWeight.w400, height: 1.33);
  static const caption2 =
      TextStyle(fontSize: 11, fontWeight: FontWeight.w400, height: 1.18);
  static const mono = TextStyle(
      fontFamily: 'JetBrains Mono',
      fontSize: 15,
      fontWeight: FontWeight.w400,
      height: 1.4);
}
