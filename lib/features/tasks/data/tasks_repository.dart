import '../../../core/utils/arabic_dates.dart';
import 'models/task.dart';

/// Fake for the UI phase, dated relative to today so it never goes stale.
class TasksRepository {
  List<Task> tasks() {
    final today = dateOnly(DateTime.now());
    DateTime d(int days) => today.add(Duration(days: days));
    return [
      Task(id: 't1', title: 'أخلّص spike الـeditor', due: d(0), label: 'appy'),
      Task(id: 't2', title: 'أدفع فاتورة النت', due: d(-1), label: 'بيت'),
      Task(id: 't3', title: 'أكتب DESIGN.md', due: d(0), label: 'appy', stage: TaskStage.done),
      Task(id: 't4', title: 'أكتب الـschema بتاع الـnotes', due: d(1), label: 'appy', stage: TaskStage.doing),
      Task(id: 't5', title: 'أجهز Supabase project', due: d(3), label: 'appy'),
      Task(id: 't6', title: 'أجرّب STT على تسجيلات مصري', due: d(5), label: 'appy'),
      const Task(id: 't7', title: 'أرتّب الـlabels', label: 'appy', stage: TaskStage.doing),
    ];
  }

  List<Habit> habits() => const [
        Habit(id: 'h1', title: 'رياضة 20 دقيقة', streak: 12,
            week: [true, true, true, true, false, true, true]),
        Habit(id: 'h2', title: 'قراءة 10 صفحات', streak: 4,
            week: [false, false, true, true, true, true, false]),
        Habit(id: 'h3', title: 'أذكار الصبح', streak: 30,
            week: [true, true, true, true, true, true, true]),
      ];
}
