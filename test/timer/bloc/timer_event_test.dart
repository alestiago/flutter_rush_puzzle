// ignore_for_file: prefer_const_constructors
import 'package:flutter_test/flutter_test.dart';
import 'package:rush_hour_puzzle/timer/timer.dart';

void main() {
  const elaspsedSeconds = 1;

  group('TimerEvent', () {
    group('TimerStarted', () {
      test('supports value comparisons', () {
        expect(TimerResumed(), equals(TimerResumed()));
      });
    });

    group('TimerTicked', () {
      test('supports value comparisons', () {
        expect(
          TimerTicked(elaspsedSeconds),
          equals(TimerTicked(elaspsedSeconds)),
        );
      });
    });

    group('TimerStopped', () {
      test('supports value comparisons', () {
        expect(
          TimerPaused(),
          equals(TimerPaused()),
        );
      });
    });

    group('TimerReset', () {
      test('supports value comparisons', () {
        expect(TimerReset(), equals(TimerReset()));
      });
    });
  });
}
