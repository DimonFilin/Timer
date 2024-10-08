part of 'timer_block.dart';


abstract class TimerState extends Equatable {
  final double precent;
  final String timeStr;
  final bool isRun;

  const TimerState (this.timeStr, this.precent, this.isRun);

  @override get props => [timeStr, precent];
}


class TimerInitial extends TimerState {
  const TimerInitial(String timeStr, double percent) : super(timeStr, percent, false);

  @override
  String toString() => 'TimerInitial { timeStr: $timeStr }';
}

class TimerRunState extends TimerState {
  const TimerRunState(String timeStr, double percent) : super(timeStr, percent, true);

  @override
  String toString() => 'TimerRunState { timeStr: $timeStr }';
}

class TimerPauseState extends TimerState {
  const TimerPauseState(String timeStr, double percent) : super(timeStr, percent, false);

  @override
  String toString() => 'TimerPauseState { timeStr: $timeStr }';
}

class TimerResetState extends TimerState {
  const TimerResetState(String timeStr, double percent, bool isRun) : super(timeStr, percent, isRun);

  @override
  String toString() => 'TimerResetState { timeStr: $timeStr }';
}

class TimerRunComplete extends TimerState {
  const TimerRunComplete()
      : super('00:00',0, false);
}

