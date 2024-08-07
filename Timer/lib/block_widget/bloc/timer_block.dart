import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

part 'timer_event.dart';
part 'timer_state.dart';

class TimerBlock extends Bloc<TimerEvent, TimerState> {
  Timer? _timer;
  final int _waitTimeInSec;
  int _currentWaitTimeInSec;

  TimerBlock({required int waitTimeInSec})
      : _waitTimeInSec = waitTimeInSec,
        _currentWaitTimeInSec = waitTimeInSec,
        super(TimerInitial(_calculationTime(waitTimeInSec), 1)) {
    on<TimerStarted>(_onTimerStarted);
    on<TimerPaused>(_onTimerPaused);
    on<TimerReset>(_onTimerReset);
    on<TimerTicked>(_onTimerTicked);
    on<TimerStop>(_onTimerStop);
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }

  void _onTimerStarted(TimerStarted event, Emitter<TimerState> emit) {
    if (_currentWaitTimeInSec > 0) {
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        _currentWaitTimeInSec--;
        add(TimerTicked(
            timeStr: _calculationTime(_currentWaitTimeInSec),
            percent: _currentWaitTimeInSec / _waitTimeInSec));
        if (_currentWaitTimeInSec <= 0) {
          _timer?.cancel();
          add(const TimerStop());
        }
      });
    }
  }

  void _onTimerPaused(TimerPaused event, Emitter<TimerState> emit) {
    if (state is TimerRunState) {
      _timer?.cancel();
      emit(TimerPauseState(
          _calculationTime(_currentWaitTimeInSec),
          _currentWaitTimeInSec / _waitTimeInSec));
    }
  }

  void _onTimerReset(TimerReset event, Emitter<TimerState> emit) {
    _currentWaitTimeInSec = _waitTimeInSec;
    emit(TimerResetState(
        _calculationTime(_currentWaitTimeInSec),
        _currentWaitTimeInSec / _waitTimeInSec,
        state.isRun));
  }

  void _onTimerStop(TimerStop event, Emitter<TimerState> emit) {
    if (state is TimerRunState) {
      emit(const TimerRunComplete());
    }
  }

  void _onTimerTicked(TimerTicked event, Emitter<TimerState> emit) {
    emit(TimerRunState(event.timeStr, event.percent));
  }

  static String _calculationTime(int _waitTime) {
    var minStr = (_waitTime ~/ 60).toString().padLeft(2, '0');
    var secStr = (_waitTime % 60).toString().padLeft(2, '0');
    return '$minStr:$secStr';
  }
}