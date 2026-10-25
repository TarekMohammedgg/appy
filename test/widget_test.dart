import 'package:appy/app/app.dart';
import 'package:flutter_test/flutter_test.dart';

/// Smoke test: every screen and Tasks view builds without layout errors.
void main() {
  testWidgets('all screens render', (tester) async {
    await tester.pumpWidget(const AppyApp());
    await tester.pumpAndSettle();

    // Chat: empty state, then a scripted capture reply.
    expect(find.text('أهلاً يا طارق، عايز تعرف إيه؟'), findsOneWidget);
    await tester.tap(find.text('دفعت 150 بنزين'));
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();
    expect(find.text('اتسجل في المصاريف'), findsOneWidget);

    // Notes list → editor → back.
    await tester.tap(find.text('الملاحظات').last);
    await tester.pumpAndSettle();
    expect(find.text('اجتماع مشروع appy'), findsOneWidget);
    await tester.tap(find.text('اجتماع مشروع appy'));
    await tester.pumpAndSettle();
    expect(find.text('النص المكتوب'), findsOneWidget);
    await tester.tap(find.text('الملاحظات').first);
    await tester.pumpAndSettle();

    // Tasks: list, calendar, board.
    await tester.tap(find.text('المهام').last);
    await tester.pumpAndSettle();
    expect(find.text('العادات'), findsOneWidget);
    await tester.tap(find.text('تقويم'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('بورد'));
    await tester.pumpAndSettle();
    expect(find.text('شغال'), findsOneWidget);

    // Settings from the shared menu icon.
    await tester.tap(find.byTooltip('الإعدادات'));
    await tester.pumpAndSettle();
    expect(find.text('Notion sync'), findsOneWidget);
  });
}
