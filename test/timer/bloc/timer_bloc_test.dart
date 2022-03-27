// ignore_for_file: prefer_const_constructors, avoid_redundant_argument_values

import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rush_hour_puzzle/timer/timer.dart';


class MockTicker extends Mock implements Ticker {}

void main() {
  final ticker = MockTicker();
  final streamController = StreamController<int>.broadcast();

  setUp(() {
    when(ticker.tick).thenAnswer((_) => streamController.stream);
  });

  group('TimerBloc', () {
    test('initial state is TimerState', () {
      expect(
        TimerBloc(ticker: ticker).state,
        TimerState(),
      );
    });

    group('TimerResumed', () {
      test('emits 3 sequential timer states', () async {
        final bloc = TimerBloc(ticker: ticker)..add(TimerResumed());
        await bloc.stream.first;

        streamController
          ..add(1)
          ..add(2)
          ..add(3);

        await expectLater(
          bloc.stream,
          emitsInOrder(<TimerState>[
            TimerState(isRunning: true, secondsElapsed: 1),
            TimerState(isRunning: true, secondsElapsed: 2),
            TimerState(isRunning: true, secondsElapsed: 3),
          ]),
        );
      });
    });

    group('TimerTicked', () {
      blocTest<TimerBloc, TimerState>(
        'emits 1 when seconds elapsed is 1',
        build: () => TimerBloc(ticker: ticker),
        act: (bloc) => bloc.add(TimerTicked(1)),
        expect: () => [TimerState(secondsElapsed: 1)],
      );
    });

    group('TimerPaused', () {
      test('does not emit after timer is paused', () async {
        final bloc = TimerBloc(ticker: ticker)..add(TimerResumed());

        expect(
          await bloc.stream.first,
          equals(TimerState(isRunning: true, secondsElapsed: 0)),
        );

        streamController.add(1);
        expect(
          await bloc.stream.first,
          equals(TimerState(isRunning: true, secondsElapsed: 1)),
        );

        bloc.add(TimerPaused());
        streamController.add(2);

        expect(
          await bloc.stream.first,
          equals(TimerState(isRunning: false, secondsElapsed: 1)),
        );
      });
    });

    group('TimerReset', () {
      blocTest<TimerBloc, TimerState>(
        'emits new timer state',
        build: () => TimerBloc(ticker: ticker),
        act: (bloc) => bloc.add(TimerReset()),
        expect: () => [TimerState()],
      );
    });
  });
}
