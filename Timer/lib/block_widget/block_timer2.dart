import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/timer_block.dart';
//import 'package:flutter_app/block_widget/block_timer_page.dart';

class BLoCTimerPage extends StatelessWidget {
  final int _waitTimeInSec;

  const BLoCTimerPage({Key? key, required int waitTimeInSec})
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

    return BlocListener<TimerBlock, TimerState>(listener: (context, state) {
      if (state is TimerRunComplete) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Finish')));
      }
    }, child: BlocBuilder<TimerBlock, TimerState>(
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
                    ),
                  )
                ],
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: size.height * 0.1,
                      width: size.width * 0.2,
                      margin: const EdgeInsets.all(10),
                      child: CircularProgressIndicator(
                        value: context.select((TimerBlock bloc) => bloc.state.precent),
                        // value: state.percent,
                        backgroundColor: Colors.red[800],
                        strokeWidth: 8,
                      ),
                    ),
                    const Positioned(child: TimerText())
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
                  ),
                ),
              ],
            ),
          );
        }));
  }
}

class TimerText extends StatelessWidget {
  const TimerText({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
      context.select((TimerBlock bloc) => bloc.state.timeStr),
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      textAlign: TextAlign.center,
    );
  }
}
