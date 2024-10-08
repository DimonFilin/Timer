import 'dart:async';
import 'package:flutter/material.dart';

class StateTimerPage extends StatefulWidget {
  final int waitTimeInSec;

  const StateTimerPage({super.key,required this.waitTimeInSec});//конструктор

  @override
  State<StateTimerPage> createState() => _StateTimerPageState();
}

class _StateTimerPageState extends State<StateTimerPage> {
//Основные переменные
  Timer? _timer;
  late int _waitTime;
  var _precent = 1.0;
  bool isStart = false;
  var timeStr = '00:00';

//Создание виджета
  @override
  void initState() {
    // TODO: implement initState
    _waitTime = widget.waitTimeInSec;
    _calculationTime();
  }

  //Удаление виджета
  @override
  void dispose() {
    // TODO: implement dispose
    _timer?.cancel();
  }

  //Старт таймера
  void _start(BuildContext context) {
    if (_waitTime > 0) {
      setState(() {
        isStart = true;
      });
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        _waitTime--;
        _calculationTime();
        if (_waitTime <= 0) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Finish")));
          _pause();
        }
      });
    }
  }

  //Рестарт таймера
  void _restart() {
    _waitTime = widget.waitTimeInSec;
    _calculationTime();
  }

  //Приостановка таймера
  void _pause() {
    _timer?.cancel();
    setState(() {
      isStart = false;
    });
  }

  //Обновление времени на экране
  void _calculationTime()
  {
    var minStr = (_waitTime~/60).toString().padLeft(2,'0');
    var secStr = (_waitTime%60).toString().padLeft(2,'0');
    setState(() {
      _precent = _waitTime/ widget.waitTimeInSec;
      timeStr = '$minStr:$secStr';
    });
  }

  @override
  Widget build(BuildContext context) {
    //Получение размера из контекста)выиджета выше по дереву)
    final size = MediaQuery
        .of(context)
        .size;

    return
      Center(

      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(//1 кнопка рестарт
              height: size.height * 0.1,
              width: size.width * 0.2,
              margin: const EdgeInsets.all(10),
              child: FloatingActionButton(
                onPressed: () {
                  _restart();
                },
                child: const Icon(Icons.restart_alt),
                foregroundColor: Theme
                    .of(context)
                    .canvasColor,
                backgroundColor: Theme
                    .of(context)
                    .primaryColor,
              )
          ),
          Stack(//Виджет для расстановки других виждетов друг на друге
            alignment: Alignment.center,
            children: [
              Container(
                  height: size.height * 0.1,
                  width: size.width * 0.2,
                  margin: const EdgeInsets.all(10),
                  child: CircularProgressIndicator(//Круговой идентефикатор
                    backgroundColor: Theme
                        .of(context)
                        .canvasColor,
                    color: Theme
                        .of(context)
                        .primaryColor,
                    value: _precent,
                    strokeWidth: 8,//Ширина круга
                  )
              ),
              Positioned(
                child: Text((timeStr), style: Theme
                  .of(context)
                  .textTheme
                  .bodyLarge, textAlign: TextAlign.center,),
//(_waitTime>60?(""+):())
              )
            ],

          ),
          Container(//Кнопка запуска/остановки
              height: size.height * 0.1,
              width: size.width * 0.2,
              margin: const EdgeInsets.all(10),
              child: FloatingActionButton(
                onPressed: isStart ? () => _pause() : () => _start(context),
                child: isStart ? const Icon(Icons.pause) : const Icon(
                    Icons.play_arrow),
                foregroundColor: Theme
                    .of(context)
                    .canvasColor,
                backgroundColor: Theme
                    .of(context)
                    .primaryColor,
              )
          ),
        ],

      ),
    );
  }
}