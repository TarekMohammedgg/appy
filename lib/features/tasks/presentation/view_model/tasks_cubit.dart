import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/arabic_dates.dart';
import '../../data/models/task.dart';
import '../../data/tasks_repository.dart';
import 'tasks_state.dart';

class TasksCubit extends Cubit<TasksState> {
  TasksCubit(TasksRepository repository)
      : super(TasksState(
          tasks: repository.tasks(),
          habits: repository.habits(),
          month: DateTime(DateTime.now().year, DateTime.now().month),
          selectedDay: dateOnly(DateTime.now()),
        ));

  void setView(TasksView view) => emit(state.copyWith(view: view));

  void toggleTask(String id) => _updateTask(
      id, (t) => t.withStage(t.done ? TaskStage.todo : TaskStage.done));

  void moveTask(String id, TaskStage stage) =>
      _updateTask(id, (t) => t.withStage(stage));

  void toggleHabit(String id) => emit(state.copyWith(habits: [
        for (final h in state.habits) h.id == id ? h.toggledToday() : h,
      ]));

  void selectDay(DateTime day) => emit(state.copyWith(selectedDay: dateOnly(day)));

  void shiftMonth(int delta) => emit(state.copyWith(
      month: DateTime(state.month.year, state.month.month + delta)));

  void add(String title, {required bool habit}) {
    final id = DateTime.now().microsecondsSinceEpoch.toString();
    if (habit) {
      emit(state.copyWith(habits: [
        ...state.habits,
        Habit(id: id, title: title, streak: 0, week: List.filled(7, false)),
      ]));
    } else {
      emit(state.copyWith(tasks: [
        ...state.tasks,
        Task(id: id, title: title, due: dateOnly(DateTime.now())),
      ]));
    }
  }

  void _updateTask(String id, Task Function(Task) change) => emit(state.copyWith(
        tasks: [for (final t in state.tasks) t.id == id ? change(t) : t],
      ));
}
