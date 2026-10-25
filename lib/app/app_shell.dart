import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../core/layout.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_text.dart';
import '../core/widgets/frosted.dart';

/// Hosts the three tabs and the floating pill nav over them.
class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.shell});

  final StatefulNavigationShell shell;

  @override
  Widget build(BuildContext context) {
    // The pill hides while typing (DESIGN.md: tab bar hides with the keyboard).
    final keyboardOpen = MediaQuery.viewInsetsOf(context).bottom > 0;
    return Scaffold(
      // Each tab's own Scaffold handles the keyboard.
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          shell,
          if (!keyboardOpen)
            Positioned(
              left: 0,
              right: 0,
              bottom: pillBottom(context),
              child: Center(
                child: _PillNav(
                  index: shell.currentIndex,
                  onTap: (i) =>
                      shell.goBranch(i, initialLocation: i == shell.currentIndex),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _PillNav extends StatelessWidget {
  const _PillNav({required this.index, required this.onTap});

  final int index;
  final ValueChanged<int> onTap;

  static const _items = [
    (CupertinoIcons.chat_bubble, 'الشات'),
    (CupertinoIcons.doc_text, 'الملاحظات'),
    (CupertinoIcons.checkmark_circle, 'المهام'),
  ];

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final radius = BorderRadius.circular(kPillHeight / 2);
    return Container(
      foregroundDecoration: BoxDecoration(
        borderRadius: radius,
        border: Border.all(color: c.separator, width: 0.5),
      ),
      child: Frosted(
        color: c.pill,
        borderRadius: radius,
        child: Padding(
          padding: const EdgeInsets.all(6),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 4,
            children: [
              for (var i = 0; i < _items.length; i++)
                _PillItem(
                  icon: _items[i].$1,
                  label: _items[i].$2,
                  selected: i == index,
                  onTap: () => onTap(i),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PillItem extends StatelessWidget {
  const _PillItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final color = selected ? c.ink : c.ink2;
    return Semantics(
      button: true,
      selected: selected,
      label: label,
      excludeSemantics: true,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOutCubic,
          width: 76,
          height: 48,
          decoration: BoxDecoration(
            color: selected ? c.fill3 : Colors.transparent,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 2,
            children: [
              Icon(icon, size: 20, color: color),
              Text(label,
                  style: AppText.caption2
                      .copyWith(fontWeight: FontWeight.w600, color: color)),
            ],
          ),
        ),
      ),
    );
  }
}
