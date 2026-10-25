import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text.dart';
import '../../../../core/widgets/inset_group.dart';
import '../../../../core/widgets/large_title_bar.dart';
import '../../../../core/widgets/pressable.dart';
import '../../data/settings_repository.dart';
import '../view_model/settings_cubit.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final cubit = context.read<SettingsCubit>();
    return Scaffold(
      backgroundColor: c.grouped,
      body: BlocBuilder<SettingsCubit, AppSettings>(
        builder: (context, s) => CustomScrollView(
          slivers: [
            largeTitleBar(context, 'الإعدادات', showMenu: false),
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  InsetGroup(children: [_ProfileRow(name: s.name)]),
                  const GroupCaption('الحساب'),
                  InsetGroup(children: [
                    _SettingsRow(label: 'الاسم', value: s.name, onTap: () {}),
                    _SettingsRow(
                        label: 'الإيميل', value: s.email, ltrValue: true, onTap: () {}),
                    _SettingsRow(
                      label: 'رقم التلفون',
                      value: s.phone ?? 'إضافة رقم',
                      isAction: s.phone == null,
                      onTap: () {},
                    ),
                    _SettingsRow(label: 'الموقع', value: s.location, onTap: () {}),
                  ]),
                  const GroupCaption('التطبيق'),
                  InsetGroup(children: [
                    _SettingsRow(
                      label: 'لغة التطبيق',
                      value: s.language,
                      onTap: () => _pickLanguage(context, cubit),
                    ),
                  ]),
                  const GroupCaption('المزامنة'),
                  InsetGroup(children: [
                    _SettingsRow(
                      label: 'Notion sync',
                      trailing: CupertinoSwitch(
                        value: s.syncEnabled,
                        activeTrackColor: c.accent,
                        onChanged: cubit.setSync,
                      ),
                    ),
                  ]),
                  GroupCaption(
                    s.syncEnabled
                        ? 'آخر مزامنة ${s.lastSync}.'
                        : 'المزامنة مقفولة. الملاحظات بتفضل محفوظة على الموبايل وبتتبعت لما تفتحها تاني.',
                    isHeader: false,
                  ),
                  const GroupCaption('عن التطبيق'),
                  InsetGroup(children: [
                    _SettingsRow(label: 'الإصدار', value: s.version, ltrValue: true),
                  ]),
                  SizedBox(height: 32 + MediaQuery.viewPaddingOf(context).bottom),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void _pickLanguage(BuildContext context, SettingsCubit cubit) {
  showCupertinoModalPopup<void>(
    context: context,
    builder: (popup) => CupertinoActionSheet(
      title: const Text('لغة التطبيق'),
      actions: [
        for (final lang in const ['العربية', 'English'])
          CupertinoActionSheetAction(
            onPressed: () {
              cubit.setLanguage(lang);
              Navigator.pop(popup);
            },
            child: Text(lang),
          ),
      ],
      cancelButton: CupertinoActionSheetAction(
        isDefaultAction: true,
        onPressed: () => Navigator.pop(popup),
        child: const Text('إلغاء'),
      ),
    ),
  );
}

class _ProfileRow extends StatelessWidget {
  const _ProfileRow({required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Pressable(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 12, 12),
        child: Row(
          spacing: 12,
          children: [
            ExcludeSemantics(
              child: Container(
                width: 56,
                height: 56,
                alignment: Alignment.center,
                decoration: BoxDecoration(color: c.accentSoft, shape: BoxShape.circle),
                child: Text(name.characters.first,
                    style: AppText.title2.copyWith(color: c.accentStrong)),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 2,
                children: [
                  Text(name, style: AppText.title3.copyWith(color: c.ink)),
                  Text('الحساب الشخصي', style: AppText.subhead.copyWith(color: c.ink2)),
                ],
              ),
            ),
            Icon(CupertinoIcons.forward, size: 16, color: c.ink3),
          ],
        ),
      ),
    );
  }
}

class _SettingsRow extends StatelessWidget {
  const _SettingsRow({
    required this.label,
    this.value,
    this.trailing,
    this.onTap,
    this.isAction = false,
    this.ltrValue = false,
  });

  final String label;
  final String? value;
  final Widget? trailing;
  final VoidCallback? onTap;

  /// Gold value that invites an action ("إضافة رقم").
  final bool isAction;

  /// Emails and version numbers read left-to-right.
  final bool ltrValue;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final row = ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 44),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(16, 6, 12, 6),
        child: Row(
          spacing: 8,
          children: [
            Text(label, style: AppText.bodyCompact.copyWith(color: c.ink)),
            Expanded(
              child: value == null
                  ? const SizedBox.shrink()
                  : Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: Text(
                        value!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textDirection: ltrValue ? TextDirection.ltr : null,
                        style: AppText.bodyCompact
                            .copyWith(color: isAction ? c.accentStrong : c.ink2),
                      ),
                    ),
            ),
            ?trailing,
            if (onTap != null)
              Icon(CupertinoIcons.forward, size: 16, color: c.ink3),
          ],
        ),
      ),
    );
    return onTap == null ? row : Pressable(onTap: onTap, child: row);
  }
}
