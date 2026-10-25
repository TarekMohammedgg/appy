import '../../data/models/task.dart';

enum TasksView { list, calendar, board }

class TasksState {
  const TasksState({
    required this.tasks,
    required this.habits,
    required this.month,
    required this.selectedDay,
    this.view = TasksView.list,
  });

  final List<Task> tasks;
  final List<Habit> habits;
  final TasksView view;

  /// First day of the month shown in the calendar.
  final DateTime month;
  final DateTime selectedDay;

  TasksState copyWith({
    List<Task>? tasks,
    List<Habit>? habits,
    TasksView? view,
    DateTime? month,
    DateTime? selectedDay,
  }) =>
      TasksState(
        tasks: tasks ?? this.tasks,
        habits: habits ?? this.habits,
        view: view ?? this.view,
        month: month ?? this.month,
        selectedDay: selectedDay ?? this.selectedDay,
      );
}
