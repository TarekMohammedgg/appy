import 'package:flutter/widgets.dart';

import '../theme/app_colors.dart';
import '../theme/app_text.dart';

/// iOS inset grouped list: white rounded block, 0.5px dividers inset from start.
class InsetGroup extends StatelessWidget {
  const InsetGroup({super.key, required this.children, this.dividerIndent = 16});

  final List<Widget> children;
  final double dividerIndent;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Container(
      margin: const EdgeInsetsDirectional.symmetric(horizontal: 16),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: c.surface,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          for (var i = 0; i < children.length; i++) ...[
            children[i],
            if (i < children.length - 1)
              Padding(
                padding: EdgeInsetsDirectional.only(start: dividerIndent),
                child: Container(height: 0.5, color: c.separator),
              ),
          ],
        ],
      ),
    );
  }
}

/// List section title ("Pinned", "Today"…), title-3.
class SectionHeader extends StatelessWidget {
  const SectionHeader(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(16, 20, 16, 8),
      child: Semantics(
        header: true,
        child: Text(text, style: AppText.title3.copyWith(color: context.colors.ink)),
      ),
    );
  }
}

/// Small grey header/footer above or under a settings group.
class GroupCaption extends StatelessWidget {
  const GroupCaption(this.text, {super.key, this.isHeader = true});

  final String text;
  final bool isHeader;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: isHeader
          ? const EdgeInsetsDirectional.fromSTEB(32, 20, 32, 6)
          : const EdgeInsetsDirectional.fromSTEB(32, 6, 32, 0),
      child: Semantics(
        header: isHeader,
        child: Text(text, style: AppText.footnote.copyWith(color: context.colors.ink2)),
      ),
    );
  }
}
