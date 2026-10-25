import 'package:flutter/cupertino.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text.dart';
import '../../../../core/utils/arabic_dates.dart';
import '../../../../core/widgets/check_circle.dart';
import '../../../../core/widgets/label_chip.dart';
import '../../data/models/task.dart';

/// Divider inset that lines up with row text (4 + 44 circle box + 4).
const kTaskDividerIndent = 52.0;

Color dueColor(AppColors c, Task t, DateTime now) {
  if (t.done || t.due == null) return c.ink2;
  return switch (dueStatus(t.due!, now)) {
    DueStatus.overdue => c.danger,
    DueStatus.today => c.warning,
    DueStatus.upcoming => c.ink2,
  };
}

class TaskRow extends StatelessWidget {
  const TaskRow({super.key, required this.task, required this.onToggle});

  final Task task;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final now = DateTime.now();
    final hasMeta = task.due != null || task.label != null;
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 44),
      child: Padding(
        padding: const EdgeInsetsDirectional.only(start: 4, end: 16),
        child: Row(
          spacing: 4,
          children: [
            CheckCircle(
              checked: task.done,
              semanticLabel: task.title,
              onTap: onToggle,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 2,
                  children: [
                    Text(task.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppText.bodyCompact
                            .copyWith(color: task.done ? c.ink2 : c.ink)),
                    if (hasMeta && !task.done)
                      Text.rich(
                        TextSpan(children: [
                          if (task.due != null)
                            TextSpan(
                              text: dueLabel(task.due!, now),
                              style: TextStyle(color: dueColor(c, task, now)),
                            ),
                          if (task.due != null && task.label != null)
                            const TextSpan(text: ' · '),
                          if (task.label != null) TextSpan(text: labelText(task.label!)),
                        ]),
                        style: AppText.footnote.copyWith(color: c.ink2),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HabitRow extends StatelessWidget {
  const HabitRow({super.key, required this.habit, required this.onToggle});

  final Habit habit;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 56),
      child: Padding(
        padding: const EdgeInsetsDirectional.only(start: 4, end: 16),
        child: Row(
          spacing: 4,
          children: [
            CheckCircle(
              checked: habit.doneToday,
              tone: CheckTone.success,
              semanticLabel: habit.title,
              onTap: onToggle,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                spacing: 6,
                children: [
                  Text(habit.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppText.bodyCompact.copyWith(color: c.ink)),
                  ExcludeSemantics(
                    child: Row(
                      spacing: 4,
                      children: [
                        for (final done in habit.week)
                          Container(
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                              color: done ? c.success : c.grey4,
                              shape: BoxShape.circle,
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Semantics(
              label: 'سلسلة ${habit.streak} يوم',
              excludeSemantics: true,
              child: Row(
                spacing: 3,
                children: [
                  Icon(CupertinoIcons.flame_fill,
                      size: 15, color: habit.doneToday ? c.warning : c.ink2),
                  Text('${habit.streak}',
                      style: AppText.footnoteStrong
                          .copyWith(color: habit.doneToday ? c.warning : c.ink2)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
