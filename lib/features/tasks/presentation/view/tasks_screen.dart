import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/layout.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text.dart';
import '../../../../core/widgets/buttons.dart';
import '../../../../core/widgets/large_title_bar.dart';
import '../view_model/tasks_cubit.dart';
import '../view_model/tasks_state.dart';
import '../widgets/tasks_views.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final cubit = context.read<TasksCubit>();
    return Scaffold(
      backgroundColor: c.grouped,
      body: Stack(
        children: [
          BlocBuilder<TasksCubit, TasksState>(
            builder: (context, state) => CustomScrollView(
              slivers: [
                largeTitleBar(context, 'المهام'),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsetsDirectional.symmetric(horizontal: 16),
                    child: CupertinoSlidingSegmentedControl<TasksView>(
                      groupValue: state.view,
                      thumbColor: c.surface,
                      backgroundColor: c.fill3,
                      onValueChanged: (v) => cubit.setView(v!),
                      children: {
                        for (final (v, label) in const [
                          (TasksView.list, 'قائمة'),
                          (TasksView.calendar, 'تقويم'),
                          (TasksView.board, 'بورد'),
                        ])
                          v: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6),
                            child: Text(label,
                                style: AppText.footnoteStrong.copyWith(color: c.ink)),
                          ),
                      },
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: switch (state.view) {
                    TasksView.list => TasksListView(state: state, cubit: cubit),
                    TasksView.calendar => TasksCalendarView(state: state, cubit: cubit),
                    TasksView.board => TasksBoardView(state: state, cubit: cubit),
                  },
                ),
                SliverToBoxAdapter(
                  child: SizedBox(height: navClearance(context) + kFabSize + 16),
                ),
              ],
            ),
          ),
          AppFab(
            icon: CupertinoIcons.plus,
            label: 'إضافة مهمة أو عادة',
            onPressed: () => _showAddSheet(context, cubit),
          ),
        ],
      ),
    );
  }
}

void _showAddSheet(BuildContext context, TasksCubit cubit) {
  showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    builder: (_) => _AddItemSheet(cubit: cubit),
  );
}

class _AddItemSheet extends StatefulWidget {
  const _AddItemSheet({required this.cubit});

  final TasksCubit cubit;

  @override
  State<_AddItemSheet> createState() => _AddItemSheetState();
}

class _AddItemSheetState extends State<_AddItemSheet> {
  final _controller = TextEditingController();
  bool _habit = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    widget.cubit.add(_controller.text.trim(), habit: _habit);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final canAdd = _controller.text.trim().isNotEmpty;
    return Padding(
      padding: EdgeInsets.fromLTRB(
          16, 0, 16, 16 + MediaQuery.viewInsetsOf(context).bottom),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 16,
          children: [
            CupertinoSlidingSegmentedControl<bool>(
              groupValue: _habit,
              thumbColor: c.surface,
              backgroundColor: c.fill3,
              onValueChanged: (v) => setState(() => _habit = v!),
              children: {
                false: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Text('مهمة', style: AppText.footnoteStrong.copyWith(color: c.ink)),
                ),
                true: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Text('عادة', style: AppText.footnoteStrong.copyWith(color: c.ink)),
                ),
              },
            ),
            TextField(
              controller: _controller,
              autofocus: true,
              onSubmitted: (_) => canAdd ? _submit() : null,
              style: AppText.body.copyWith(color: c.ink),
              decoration: InputDecoration(
                hintText: _habit ? 'عادة جديدة' : 'مهمة جديدة',
                hintStyle: AppText.body.copyWith(color: c.ink3),
                filled: true,
                fillColor: c.raised,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            PrimaryButton(label: 'إضافة', onPressed: canAdd ? _submit : null),
          ],
        ),
      ),
    );
  }
}
