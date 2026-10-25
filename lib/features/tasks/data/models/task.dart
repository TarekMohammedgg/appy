enum TaskStage { todo, doing, done }

class Task {
  const Task({
    required this.id,
    required this.title,
    this.due,
    this.label,
    this.stage = TaskStage.todo,
  });

  final String id;
  final String title;
  final DateTime? due;
  final String? label;
  final TaskStage stage;

  bool get done => stage == TaskStage.done;

  Task withStage(TaskStage s) =>
      Task(id: id, title: title, due: due, label: label, stage: s);
}

/// Daily check-in. Habits never have stages, so they stay off the board.
class Habit {
  const Habit({
    required this.id,
    required this.title,
    required this.streak,
    required this.week,
  });

  final String id;
  final String title;
  final int streak;

  /// Last 7 days, oldest first; the last entry is today.
  final List<bool> week;

  bool get doneToday => week.last;

  Habit toggledToday() => Habit(
        id: id,
        title: title,
        streak: doneToday ? (streak - 1).clamp(0, 1 << 30) : streak + 1,
        week: [...week.take(6), !doneToday],
      );
}
