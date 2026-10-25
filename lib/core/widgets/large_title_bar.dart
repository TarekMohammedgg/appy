import 'package:flutter/cupertino.dart';

import '../theme/app_colors.dart';
import 'buttons.dart';

/// Collapsing iOS large title for list screens, with the shared menu icon.
///
/// Pass [leading] to replace the menu icon (Settings uses the default back).
CupertinoSliverNavigationBar largeTitleBar(
  BuildContext context,
  String title, {
  bool showMenu = true,
}) {
  final c = context.colors;
  return CupertinoSliverNavigationBar(
    largeTitle: Text(title),
    leading: showMenu ? const SettingsButton() : null,
    automaticallyImplyLeading: !showMenu,
    padding: const EdgeInsetsDirectional.only(start: 4, end: 8),
    // Opaque on purpose: a translucent color makes the bar blur its backdrop
    // on every scroll frame.
    backgroundColor: c.grouped,
    border: null,
    transitionBetweenRoutes: false,
  );
}
