import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';


part 'timer_event.dart';
part 'timer_state.dart';


class TimerBlock extends Bloc<TimerEvent, TimeState> {
  Timer? _timer;
  final int _waitTimeInSec;
  int _currentWaitTimeInSec;

  TimerBlock({required int waitTimeInSec}) :
        _waitTimeInSec = waitTimeInSec,
        _currentWaitTimeInSec = waitTimeInSec,
        super(TimeInitial(_calculationTime(waitTimeInSec), 1));

  @override
  Future<void> close (){
    _timer?.cancel();
    return super.close();
  }

  @override
  Stream<TimeState> mapEventToState(
      TimerEvent event,
      ) async * {
    if(event is TimerStarted)
      {
        yield* _mapTimerStartedToState(event);
      } else if(event is TimerPaused)
     {
       yield* _mapTimerPausedToState(event);
     } else if(event is TimerReset)
     {
       yield* _mapTimerResetToState(event);
     } else if(event is TimerTicked)
     {
       yield* _mapTimerTickedToState(event);
     } else if(event is TimerStop)
     {
       yield* _mapTimerStopToState(event);
     }
  }

  Stream<TimeState> _mapTimerStartedToState (TimerStarted start) async*{
    if(_currentWaitTimeInSec>0)
      {
        _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
          _currentWaitTimeInSec--;
          add(TimerTicked(timeStr: _calculationTime(_currentWaitTimeInSec), percent: _currentWaitTimeInSec/_waitTimeInSec));
          if(_currentWaitTimeInSec<=0){
            _timer?.cancel();
            add(TimerStop());
          }
        });
      }
  }

  Stream<TimeState> _mapTimerPausedToState (TimerPaused pause) async* {
  if(state is TimeRunState){
    _timer?.cancel();
    yield TimePauseState(_calculationTime(_currentWaitTimeInSec),
        _currentWaitTimeInSec/_waitTimeInSec);
  }
  }

  Stream<TimeState> _mapTimerResetToState (TimerReset reset) async* {
    _currentWaitTimeInSec = _waitTimeInSec;
      yield TimeResetState(_calculationTime(_currentWaitTimeInSec),
          _currentWaitTimeInSec/_waitTimeInSec, state.isRun);

  }

  Stream<TimeState> _mapTimerStopToState (TimerStop stop) async* {
    if(state is TimeRunState){
      yield  const TimerRunComplete();
    }
  }

  Stream<TimeState> _mapTimerTickedToState (TimerTicked tick) async* {
    yield TimeRunState(tick.timeStr, tick.percent);

  }


  //Обновление времени на экране
  static String _calculationTime(int _waitTime)
  {
    var minStr = (_waitTime~/60).toString().padLeft(2,'0');
    var secStr = (_waitTime%60).toString().padLeft(2,'0');
    return '$minStr:$secStr';
    }
  }

