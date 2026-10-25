import 'package:appy/app/app.dart';
import 'package:flutter/material.dart';
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

    // AI dialog: a suggestion shows the answer and keeps the dialog open.
    await tester.tap(find.byTooltip('اسأل عن الملاحظة'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('لخّص الملاحظة'));
    await tester.pumpAndSettle();
    expect(find.textContaining('فيها 3 مهام'), findsOneWidget);
    await tester.tapAt(const Offset(5, 5)); // barrier closes it
    await tester.pumpAndSettle();

    await tester.tap(find.text('الملاحظات').first);
    await tester.pumpAndSettle();

    // New note dialog: first line becomes the editor title.
    await tester.tap(find.bySemanticsLabel('ملاحظة جديدة'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'فكرة سريعة\nتفاصيل');
    await tester.pump();
    await tester.tap(find.bySemanticsLabel('إرسال'));
    await tester.pumpAndSettle();
    expect(find.text('فكرة سريعة'), findsOneWidget);
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

    // Add dialog: a task lands in the board's first column.
    await tester.tap(find.bySemanticsLabel('إضافة مهمة أو عادة'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'مهمة تجربة');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle();
    expect(find.text('مهمة تجربة'), findsOneWidget);

    // Settings from the shared menu icon; the theme switch reaches the app.
    await tester.tap(find.byTooltip('الإعدادات'));
    await tester.pumpAndSettle();
    expect(find.text('Notion sync'), findsOneWidget);
    await tester.tap(find.text('داكن'));
    await tester.pumpAndSettle();
    expect(Theme.of(tester.element(find.text('Notion sync'))).brightness,
        Brightness.dark);
  });
}
