import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/layout.dart';
import '../../../../core/theme/app_colors.dart';

import '../../../../core/widgets/buttons.dart';
import '../../../../core/widgets/input_dialog.dart';
import '../../../../core/widgets/large_title_bar.dart';
import '../../../../core/widgets/segmented.dart';
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
      // Input happens in centered dialogs; resizing here would relayout the
      // whole list behind the dialog on every keyboard frame.
      resizeToAvoidBottomInset: false,
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
                    child: AppSegmented<TasksView>(
                      value: state.view,
                      onChanged: cubit.setView,
                      segments: const [
                        (TasksView.list, 'قائمة'),
                        (TasksView.calendar, 'تقويم'),
                        (TasksView.board, 'بورد'),
                      ],
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
            onPressed: () => showDialog<void>(
              context: context,
              builder: (_) => _AddItemDialog(cubit: cubit),
            ),
          ),
        ],
      ),
    );
  }
}

/// Task/habit toggle on top of the shared [InputDialog].
class _AddItemDialog extends StatefulWidget {
  const _AddItemDialog({required this.cubit});

  final TasksCubit cubit;

  @override
  State<_AddItemDialog> createState() => _AddItemDialogState();
}

class _AddItemDialogState extends State<_AddItemDialog> {
  bool _habit = false;

  @override
  Widget build(BuildContext context) {
    return InputDialog(
      icon: CupertinoIcons.plus,
      title: 'إضافة جديدة',
      hint: _habit ? 'عادة جديدة…' : 'مهمة جديدة…',
      header: AppSegmented<bool>(
        value: _habit,
        onChanged: (v) => setState(() => _habit = v),
        segments: const [(false, 'مهمة'), (true, 'عادة')],
      ),
      onSubmit: (text) => widget.cubit.add(text, habit: _habit),
    );
  }
}
