import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zclouds/src/zcumulus.dart';
import 'package:zclouds/zclouds.dart';

void main() {
  group('ZCloud', () {
    testWidgets(
      'builds ZCumulus',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          ZCloud(
            type: ZCloudType.cumulus,
            style: ZCloudStyle.fromSwatch(Colors.grey),
          ),
        );

        expect(find.byType(ZCumulus), findsOneWidget);
      },
    );
  });
}
