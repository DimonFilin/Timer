import 'package:flutter/material.dart';
import 'package:flutter_app/getx_widget/timer_controller.dart';
import 'package:get/get.dart';

class GetXTimerPage extends StatelessWidget {
  final int waitTimeInSec;
  late final TimerController controller;

  GetXTimerPage({Key? key, required this.waitTimeInSec}) : super(key: key) {
    controller = TimerController(waitTimeInSec);
  }

  @override
  Widget build(BuildContext context) {
    //Получение размера из контекста)выиджета выше по дереву)
    final size = MediaQuery
        .of(context)
        .size;

    return
      Center(

        child: Obx(() =>Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(//1 кнопка рестарт
                height: size.height * 0.1,
                width: size.width * 0.2,
                margin: const EdgeInsets.all(10),
                child: FloatingActionButton(
                  onPressed: () {
                    controller.restart();
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
                      value: controller.precent,
                      strokeWidth: 8,//Ширина круга
                    )
                ),
                Positioned(
                  child: Text((controller.timeStr), style: Theme
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
                  onPressed: controller.isRun.value ? () => controller.pause() : () => controller.start(),
                  child: controller.isRun.value ? const Icon(Icons.pause) : const Icon(Icons.play_arrow),
                  foregroundColor: Theme
                      .of(context)
                      .canvasColor,
                  backgroundColor: Theme
                      .of(context)
                      .primaryColor,
                )
            ),
          ],

        ),)
      );
  }
}
