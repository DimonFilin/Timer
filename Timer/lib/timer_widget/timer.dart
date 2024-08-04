import 'dart:async';
import 'package:flutter/material.dart';

class StateTimerPage extends StatefulWidget {
  final int waitTimeInSec;

  const StateTimerPage({super.key,required this.waitTimeInSec});//конструктор

  @override
  State<StateTimerPage> createState() => _StateTimerPageState();
}

class _StateTimerPageState extends State<StateTimerPage> {
  Timer? _timer;
  late int _waitTime;
  var _precent = 1.0;
  bool isStart = false;
  var timeStr = '05:00';


  @override
  void initState() {
    // TODO: implement initState
    _waitTime = widget.waitTimeInSec;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _timer?.cancel();
  }

  void _start(){
    if(_waitTime>0)
      {
        setState(() {
          isStart = true();
        });
      }
  }

  void _restart() {

  }
  void _pause(){

  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Center(

      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: size.height * 0.1,
            width: size.width * 0.2,
            margin: const EdgeInsets.all(10),
            child: FloatingActionButton(
              onPressed: _restart,
              child: const Icon(Icons.restart_alt),
              foregroundColor:  Theme.of(context).canvasColor,
              backgroundColor:  Theme.of(context).primaryColor,
            )
          ),
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
                height: size.height * 0.1,
                width: size.width * 0.2,
                margin: const EdgeInsets.all(10),
                child: CircularProgressIndicator(
                  backgroundColor: Theme.of(context).canvasColor,
                  color: Theme.of(context).primaryColor,
                  value: _precent,
                  strokeWidth: 8 ,
                )
            ),
            Positioned(child: Text((timeStr), style:  Theme.of(context).textTheme.bodyLarge,textAlign: TextAlign.center,),
//(_waitTime>60?(""+):())
            )
          ],
        
          ),
          Container(
              height: size.height * 0.1,
              width: size.width * 0.2,
              margin: const EdgeInsets.all(10),
              child: FloatingActionButton(
                onPressed: isStart?_start:_pause,
                child: isStart?  const Icon(Icons.pause): const Icon(Icons.play_arrow),
                foregroundColor:  Theme.of(context).canvasColor,
                backgroundColor:  Theme.of(context).primaryColor,
              )
          ),
        ],

      ),
    );
  }
}
