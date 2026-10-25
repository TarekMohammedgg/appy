import 'package:appy/core/widgets/auto_direction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('first strong character decides the direction', () {
    expect(detectTextDirection('أهلاً'), TextDirection.rtl);
    expect(detectTextDirection('hello'), TextDirection.ltr);
    expect(detectTextDirection('150 بنزين'), TextDirection.rtl);
    expect(detectTextDirection('Flutter عربي'), TextDirection.ltr);
    expect(detectTextDirection('  123 '), isNull);
    expect(detectTextDirection(''), isNull);
  });

  testWidgets('field flips while typing and keeps focus', (tester) async {
    final controller = TextEditingController();
    await tester.pumpWidget(MaterialApp(
      home: Directionality(
        textDirection: TextDirection.rtl,
        child: Material(
          child: AutoDirection(
            controller: controller,
            child: TextField(controller: controller, autofocus: true),
          ),
        ),
      ),
    ));
    TextDirection dir() =>
        Directionality.of(tester.element(find.byType(EditableText)));

    expect(dir(), TextDirection.rtl);
    await tester.enterText(find.byType(TextField), 'hello');
    await tester.pump();
    expect(dir(), TextDirection.ltr);
    expect(tester.widget<EditableText>(find.byType(EditableText)).focusNode.hasFocus,
        isTrue);
    await tester.enterText(find.byType(TextField), 'أهلاً');
    await tester.pump();
    expect(dir(), TextDirection.rtl);
  });
}
