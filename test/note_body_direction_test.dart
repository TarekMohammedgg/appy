import 'package:appy/features/notes/presentation/widgets/note_body_editor.dart';
import 'package:fleather/fleather.dart';
import 'package:fleather/util.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

List<TextDirection> lineDirections(FleatherController c) => [
      for (final node in c.document.root.children) getDirectionOfNode(node as LineNode),
    ];

void main() {
  test('typing sets each line\'s direction from its first letter', () {
    final c = noteBodyController('');
    expect(lineDirections(c), [TextDirection.rtl]); // empty note starts RTL

    // Like keyboard input: each insert carries the new caret position, which
    // is what makes fleather run its auto formats.
    void type(int at, String s) =>
        c.replaceText(at, 0, s, selection: TextSelection.collapsed(offset: at + s.length));
    type(0, 'السلام');
    type(6, '\n');
    type(7, 'hi');
    expect(c.document.toPlainText(), 'السلام\nhi\n');
    expect(lineDirections(c), [TextDirection.rtl, TextDirection.ltr]);
  });

  test('saved text opens with per-line directions', () {
    final c = noteBodyController('hi\nأهلاً\n\nok');
    expect(lineDirections(c), [
      TextDirection.ltr,
      TextDirection.rtl,
      TextDirection.rtl, // empty line: app default
      TextDirection.ltr,
    ]);
  });
}
