import 'package:flutter/material.dart';
import 'package:flutter_app/block_widget/bloc/timer_block.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BloCTimerPage extends StatelessWidget {
  final int _waitTimeInSec;

  const BloCTimerPage({Key? key, required int waitTimeInSec})
      : _waitTimeInSec = waitTimeInSec,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
    create: (_) => TimerBlock(waitTimeInSec: _waitTimeInSec),
    child: const _BlocTimerPage(),
    );
  }
}

class _BlocTimerPage extends StatelessWidget {
  const _BlocTimerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocListener<TimerBlock, TimerState>(
      listener: (context, state) {
        if (state is TimerRunComplete) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Finish")));
        }
      },
      child: BlocBuilder<TimerBlock, TimerState>(
        buildWhen: (prev, state) => prev.runtimeType != state.runtimeType,
        builder: (context, state) {
          return Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                if (state is! TimerInitial) ...[
                  Container(
                    height: size.height * 0.1,
                    width: size.width * 0.2,
                    margin: const EdgeInsets.all(10),
                    child: FloatingActionButton(
                      onPressed: () => context.read<TimerBlock>().add(TimerReset()),
                      child: const Icon(Icons.restart_alt),
                      foregroundColor: Theme.of(context).canvasColor,
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: size.height * 0.1,
                      width: size.width * 0.2,
                      margin: const EdgeInsets.all(10),
                      child: CircularProgressIndicator(
                        backgroundColor: Theme.of(context).appBarTheme.foregroundColor,
                        color: Theme.of(context).primaryColor,
                        value: context.select((TimerBlock bloc) => bloc.state.precent),
                        //value: state.precent,
                        strokeWidth: 8,
                      ),
                    ),
                    Positioned(
                      child: Text(
                        context.select((TimerBlock bloc) => bloc.state.timeStr),
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                Container(
                  height: size.height * 0.1,
                  width: size.width * 0.2,
                  margin: const EdgeInsets.all(10),
                  child: FloatingActionButton(
                    onPressed: () {
                      state.isRun
                          ? context.read<TimerBlock>().add(const TimerPaused())
                          : context.read<TimerBlock>().add(const TimerStarted());
                    },
                    child: state.isRun
                        ? const Icon(Icons.pause)
                        : const Icon(Icons.play_arrow),
                    foregroundColor: Theme.of(context).canvasColor,
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
//Пример передаци параметра извне
// class TimerText extends StatelessWidget {
//   const TimerText({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Text(
//       context.select((TimerBloc bloc) => bloc.state.timeStr),
//       style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
//       textAlign: TextAlign.center,
//     );
//   }
// }