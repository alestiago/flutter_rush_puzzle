import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zcomponents/src/widgets/widgets.dart';

void main() {
  group('DebugGame', () {
    testWidgets('marks tree as debug mode', (tester) async {
      await tester.pumpWidget(const DebugGame(child: MaterialApp()));
      final context = tester.firstElement(find.byType(MaterialApp));
      expect(DebugGame.isDebugMode(context, listen: false), isTrue);
    });

    testWidgets('tree is not in debug mode when debug:false', (tester) async {
      await tester.pumpWidget(
        const DebugGame(
          debug: false,
          child: MaterialApp(),
        ),
      );
      final context = tester.firstElement(find.byType(MaterialApp));
      expect(DebugGame.isDebugMode(context, listen: false), isFalse);
    });

    testWidgets(
        'tree is not in debug mode when '
        'no DebugGame widget', (tester) async {
      await tester.pumpWidget(const MaterialApp());
      final context = tester.firstElement(find.byType(MaterialApp));
      expect(DebugGame.isDebugMode(context, listen: false), isFalse);
    });
  });
}
