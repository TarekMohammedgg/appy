/// Arabic date labels with Western digits (DESIGN.md: one digit style app-wide).
const arMonths = [
  'يناير', 'فبراير', 'مارس', 'أبريل', 'مايو', 'يونيو',
  'يوليو', 'أغسطس', 'سبتمبر', 'أكتوبر', 'نوفمبر', 'ديسمبر',
];

/// Indexed by `DateTime.weekday - 1` (Monday first, like Dart).
const arWeekdays = [
  'الاثنين', 'الثلاثاء', 'الأربعاء', 'الخميس', 'الجمعة', 'السبت', 'الأحد',
];

/// Calendar header, week starts Saturday.
const arWeekdaysShortFromSaturday = [
  'سبت', 'أحد', 'اتنين', 'تلات', 'أربع', 'خميس', 'جمعة',
];

DateTime dateOnly(DateTime d) => DateTime(d.year, d.month, d.day);

bool isSameDay(DateTime a, DateTime b) =>
    a.year == b.year && a.month == b.month && a.day == b.day;

/// Column of [d] in a Saturday-first week (Saturday = 0).
int saturdayIndex(DateTime d) => (d.weekday + 1) % 7;

/// "الاثنين، 26 أكتوبر"
String dayLabel(DateTime d) =>
    '${arWeekdays[d.weekday - 1]}، ${d.day} ${arMonths[d.month - 1]}';

enum DueStatus { overdue, today, upcoming }

DueStatus dueStatus(DateTime due, DateTime now) {
  final diff = dateOnly(due).difference(dateOnly(now)).inDays;
  if (diff < 0) return DueStatus.overdue;
  if (diff == 0) return DueStatus.today;
  return DueStatus.upcoming;
}

/// "النهارده" / "امبارح" / "بكرة" / weekday this week / "3 نوفمبر".
String dueLabel(DateTime due, DateTime now) {
  final diff = dateOnly(due).difference(dateOnly(now)).inDays;
  if (diff == 0) return 'النهارده';
  if (diff == -1) return 'امبارح';
  if (diff == 1) return 'بكرة';
  if (diff > 1 && diff < 7) return arWeekdays[due.weekday - 1];
  return '${due.day} ${arMonths[due.month - 1]}';
}
