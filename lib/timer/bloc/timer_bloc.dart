// ignore_for_file: public_member_api_docs

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rush_hour_puzzle/timer/timer.dart';

part 'timer_event.dart';
part 'timer_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  TimerBloc({required Ticker ticker})
      : _ticker = ticker,
        super(const TimerState()) {
    on<TimerResumed>(_onTimerResumed);
    on<TimerTicked>(_onTimerTicked);
    on<TimerPaused>(_onTimerPaused);
    on<TimerReset>(_onTimerReset);
  }

  final Ticker _ticker;

  StreamSubscription<int>? _tickerSubscription;

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }

  void _onTimerResumed(TimerResumed event, Emitter<TimerState> emit) {
    _tickerSubscription ??= _ticker
        .tick()
        .listen((secondsElapsed) => add(TimerTicked(secondsElapsed)));
    _tickerSubscription!.resume();
    emit(state.copyWith(isRunning: true));
  }

  void _onTimerTicked(TimerTicked event, Emitter<TimerState> emit) {
    emit(state.copyWith(secondsElapsed: event.secondsElapsed));
  }

  void _onTimerPaused(TimerPaused event, Emitter<TimerState> emit) {
    _tickerSubscription?.pause();
    emit(state.copyWith(isRunning: false));
  }

  void _onTimerReset(TimerReset event, Emitter<TimerState> emit) {
    _tickerSubscription?.cancel();
    _tickerSubscription = null;
    emit(state.copyWith(secondsElapsed: 0));
  }
}
