part of 'timer_block.dart';


abstract class TimeState extends Equatable {
  final double precent;
  final String timeStr;
  final bool isRun;

  const TimeState (this.timeStr, this.precent, this.isRun);

  @override get props => [timeStr, precent];
}


class TimeInitial extends TimeState {
  const TimeInitial(String timeStr, double percent) : super(timeStr, percent, false);

  @override
  String toString() => 'TimeInitial { timeStr: $timeStr }';
}

class TimeRunState extends TimeState {
  const TimeRunState(String timeStr, double percent) : super(timeStr, percent, true);

  @override
  String toString() => 'TimeRunState { timeStr: $timeStr }';
}

class TimePauseState extends TimeState {
  const TimePauseState(String timeStr, double percent) : super(timeStr, percent, false);

  @override
  String toString() => 'TimePauseState { timeStr: $timeStr }';
}

class TimeResetState extends TimeState {
  const TimeResetState(String timeStr, double percent, bool isRun) : super(timeStr, percent, isRun);

  @override
  String toString() => 'TimeResetState { timeStr: $timeStr }';
}

class TimerRunComplete extends TimeState {
  const TimerRunComplete()
      : super('00:00',0, false);
}

