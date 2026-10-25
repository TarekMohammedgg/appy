import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text.dart';
import '../../../../core/utils/arabic_dates.dart';
import '../../../../core/widgets/inset_group.dart';
import '../../../../core/widgets/label_chip.dart';
import '../../data/models/task.dart';
import '../view_model/tasks_cubit.dart';
import '../view_model/tasks_state.dart';
import 'task_rows.dart';

// ── List ──────────────────────────────────────────────────────────────────

class TasksListView extends StatelessWidget {
  const TasksListView({super.key, required this.state, required this.cubit});

  final TasksState state;
  final TasksCubit cubit;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final dated = state.tasks.where((t) => t.due != null);
    final groups = {
      'النهارده': dated.where((t) => dueStatus(t.due!, now) != DueStatus.upcoming),
      'الجاية': dated.where((t) => dueStatus(t.due!, now) == DueStatus.upcoming),
      'من غير ميعاد': state.tasks.where((t) => t.due == null),
    };
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader('العادات'),
        InsetGroup(dividerIndent: kTaskDividerIndent, children: [
          for (final h in state.habits)
            HabitRow(habit: h, onToggle: () => cubit.toggleHabit(h.id)),
        ]),
        for (final MapEntry(key: title, value: tasks) in groups.entries)
          if (tasks.isNotEmpty) ...[
            SectionHeader(title),
            InsetGroup(dividerIndent: kTaskDividerIndent, children: [
              for (final t in tasks)
                TaskRow(task: t, onToggle: () => cubit.toggleTask(t.id)),
            ]),
          ],
      ],
    );
  }
}

// ── Calendar ──────────────────────────────────────────────────────────────

class TasksCalendarView extends StatelessWidget {
  const TasksCalendarView({super.key, required this.state, required this.cubit});

  final TasksState state;
  final TasksCubit cubit;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final today = dateOnly(DateTime.now());
    final month = state.month;
    final offset = saturdayIndex(month);
    final daysInMonth = DateTime(month.year, month.month + 1, 0).day;
    final weeks = ((offset + daysInMonth) / 7).ceil();

    bool hasTask(DateTime d) =>
        state.tasks.any((t) => t.due != null && isSameDay(t.due!, d));
    bool habitDone(DateTime d) {
      final ago = today.difference(d).inDays;
      return ago >= 0 && ago < 7 && state.habits.any((h) => h.week[6 - ago]);
    }

    final selected = state.selectedDay;
    final dayTasks =
        state.tasks.where((t) => t.due != null && isSameDay(t.due!, selected));
    final showHabits = isSameDay(selected, today);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
          padding: const EdgeInsetsDirectional.fromSTEB(8, 4, 8, 8),
          decoration: BoxDecoration(
            color: c.surface,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text('${arMonths[month.month - 1]} ${month.year}',
                        style: AppText.headline.copyWith(color: c.ink)),
                  ),
                  IconButton(
                    tooltip: 'الشهر اللي فات',
                    onPressed: () => cubit.shiftMonth(-1),
                    icon: Icon(CupertinoIcons.back, color: c.accentStrong, size: 22),
                  ),
                  IconButton(
                    tooltip: 'الشهر الجاي',
                    onPressed: () => cubit.shiftMonth(1),
                    icon: Icon(CupertinoIcons.forward, color: c.accentStrong, size: 22),
                  ),
                ],
              ),
              ExcludeSemantics(
                child: Row(
                  children: [
                    for (final d in arWeekdaysShortFromSaturday)
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Text(d,
                              textAlign: TextAlign.center,
                              style: AppText.footnoteStrong.copyWith(color: c.ink2)),
                        ),
                      ),
                  ],
                ),
              ),
              for (var w = 0; w < weeks; w++)
                Row(
                  children: [
                    for (var col = 0; col < 7; col++)
                      Expanded(
                        child: Builder(builder: (context) {
                          final n = w * 7 + col - offset + 1;
                          if (n < 1 || n > daysInMonth) return const SizedBox(height: 44);
                          final day = DateTime(month.year, month.month, n);
                          return _DayCell(
                            day: day,
                            isToday: isSameDay(day, today),
                            isSelected: isSameDay(day, selected),
                            isPast: day.isBefore(today),
                            dot: hasTask(day)
                                ? c.grey
                                : habitDone(day)
                                    ? c.success
                                    : null,
                            onTap: () => cubit.selectDay(day),
                          );
                        }),
                      ),
                  ],
                ),
            ],
          ),
        ),
        SectionHeader(dayLabel(selected)),
        if (!showHabits && dayTasks.isEmpty)
          Padding(
            padding: const EdgeInsetsDirectional.symmetric(horizontal: 16),
            child: Text('مفيش حاجة في اليوم ده',
                style: AppText.body.copyWith(color: c.ink2)),
          )
        else
          InsetGroup(dividerIndent: kTaskDividerIndent, children: [
            if (showHabits)
              for (final h in state.habits)
                HabitRow(habit: h, onToggle: () => cubit.toggleHabit(h.id)),
            for (final t in dayTasks)
              TaskRow(task: t, onToggle: () => cubit.toggleTask(t.id)),
          ]),
      ],
    );
  }
}

class _DayCell extends StatelessWidget {
  const _DayCell({
    required this.day,
    required this.isToday,
    required this.isSelected,
    required this.isPast,
    required this.dot,
    required this.onTap,
  });

  final DateTime day;
  final bool isToday;
  final bool isSelected;
  final bool isPast;
  final Color? dot;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final (Color? fill, Color text) = isToday
        ? (c.accent, c.onAccent)
        : isSelected
            ? (c.ink, c.canvas)
            : (null, isPast ? c.ink2 : c.ink);
    return Semantics(
      button: true,
      selected: isSelected,
      label: dayLabel(day),
      excludeSemantics: true,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: SizedBox(
          height: 44,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 2,
            children: [
              Container(
                width: 32,
                height: 32,
                alignment: Alignment.center,
                decoration: BoxDecoration(color: fill, shape: BoxShape.circle),
                child: Text('${day.day}',
                    style: AppText.bodyCompact.copyWith(
                        color: text,
                        fontWeight: isToday || isSelected ? FontWeight.w600 : null)),
              ),
              Container(
                width: 4,
                height: 4,
                decoration: BoxDecoration(color: dot, shape: BoxShape.circle),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Board (tasks only) ────────────────────────────────────────────────────

class TasksBoardView extends StatelessWidget {
  const TasksBoardView({super.key, required this.state, required this.cubit});

  final TasksState state;
  final TasksCubit cubit;

  static const _titles = {
    TaskStage.todo: 'لسه',
    TaskStage.doing: 'شغال',
    TaskStage.done: 'خلصت',
  };

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 12,
        children: [
          for (final stage in TaskStage.values)
            _BoardColumn(
              title: _titles[stage]!,
              tasks: state.tasks.where((t) => t.stage == stage).toList(),
              onDrop: (id) => cubit.moveTask(id, stage),
            ),
        ],
      ),
    );
  }
}

class _BoardColumn extends StatelessWidget {
  const _BoardColumn({required this.title, required this.tasks, required this.onDrop});

  final String title;
  final List<Task> tasks;
  final ValueChanged<String> onDrop;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return DragTarget<String>(
      onAcceptWithDetails: (d) => onDrop(d.data),
      builder: (context, candidates, _) => AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        width: 280,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: candidates.isNotEmpty ? c.fill3 : Colors.transparent,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 8,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(4, 0, 4, 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                spacing: 6,
                children: [
                  Text(title, style: AppText.headline.copyWith(color: c.ink)),
                  Text('${tasks.length}', style: AppText.footnote.copyWith(color: c.ink2)),
                ],
              ),
            ),
            for (final t in tasks)
              LongPressDraggable<String>(
                data: t.id,
                onDragStarted: HapticFeedback.mediumImpact,
                feedback: Material(
                  color: Colors.transparent,
                  child: Transform.scale(
                    scale: 1.03,
                    child: SizedBox(width: 272, child: _BoardCard(t, lifted: true)),
                  ),
                ),
                childWhenDragging: Opacity(opacity: 0.3, child: _BoardCard(t)),
                child: _BoardCard(t),
              ),
          ],
        ),
      ),
    );
  }
}

class _BoardCard extends StatelessWidget {
  const _BoardCard(this.task, {this.lifted = false});

  final Task task;
  final bool lifted;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final now = DateTime.now();
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: c.surface,
        borderRadius: BorderRadius.circular(10),
        // The only shadow in the app: a card being dragged.
        boxShadow: lifted
            ? const [BoxShadow(color: Color(0x1F000000), blurRadius: 24, offset: Offset(0, 8))]
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8,
        children: [
          Text(task.title,
              style: AppText.subhead.copyWith(color: task.done ? c.ink2 : c.ink)),
          if (!task.done && (task.due != null || task.label != null))
            Row(
              spacing: 8,
              children: [
                if (task.due != null)
                  Text(dueLabel(task.due!, now),
                      style: AppText.footnote.copyWith(color: dueColor(c, task, now))),
                if (task.label != null) LabelChip(task.label!),
              ],
            ),
        ],
      ),
    );
  }
}
