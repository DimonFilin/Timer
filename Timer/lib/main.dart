import 'package:flutter/material.dart';
import 'package:flutter_app/themes.dart';
import 'package:flutter_app/timer_widget/timer.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'block_widget/block_timer2.dart';
import 'block_widget/block_timer_page.dart';
import 'generated/l10n.dart';
import 'getx_widget/getx_timer_page.dart';


void main() =>  runApp(MyApp());

const int waittime = 5;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
     return
     AdaptiveTheme(
         light: kLightTheme,
         dark: kDarkTheme,
         initial: AdaptiveThemeMode.dark,
         builder: (dark,light) =>
       MaterialApp(
         theme: light,
         darkTheme: dark,
         localizationsDelegates: [
         S.delegate,
         GlobalMaterialLocalizations.delegate,
         GlobalWidgetsLocalizations.delegate,
         GlobalCupertinoLocalizations.delegate,
         ],
         supportedLocales: S.delegate.supportedLocales,
         title: 'Flutter Demo',
         home: MyHomePage()
    )
     );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selectIndex = 0;
  late Widget _bodyWidget;
  // static List<Widget> listTimerWidgets = <Widget>[
  //  const StateTimerPage(waitTimeInSec: waittime),
  //  const BloCTimerPage(waitTimeInSec: waittime),
  //   GetXTimerPage(waitTimeInSec: waittime)
  // ];

  @override
  void initState() {
    super.initState();
    onItemTopped(selectIndex);
  }

  Widget _buildCurrentWidget(int type){
    Widget? buildWidget;
    switch(type){
      case 0:
        return const StateTimerPage(waitTimeInSec: waittime);
        break;
      case 1:
        return const BloCTimerPage(waitTimeInSec: waittime);
        break;
      case 2:
        return GetXTimerPage(waitTimeInSec: waittime);
        break;
        deafault:
        throw ArgumentError();
        break;
    }
    return const StateTimerPage(waitTimeInSec: waittime);
  }

  void onItemTopped(int index){
   setState(() {
     selectIndex = index;
     _bodyWidget = _buildCurrentWidget(index);

   });
    }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
          AdaptiveTheme.of(context).toggleThemeMode();
          },
        ),

      appBar: AppBar(
          title: Text(S.of(context).appBarTitle)
      ),
      body: _bodyWidget,
      bottomNavigationBar:  BottomNavigationBar(
        currentIndex: selectIndex,
        backgroundColor: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
        selectedItemColor: Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
        unselectedItemColor: Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
        onTap: onItemTopped,
        items: const [
          BottomNavigationBarItem(icon: (Icon(Icons.access_alarm)), label: 'NoStates'),
          BottomNavigationBarItem(icon: (Icon(Icons.access_time)), label: 'BloC'),
          BottomNavigationBarItem(icon: (Icon(Icons.add_alarm)), label: 'GetX'),
        ],
      ),
      
    );
    //       Text(
    //         S.of(context).MainTitle,
    //         style: Theme.of(context).textTheme.bodyLarge,
    //         textAlign: TextAlign.center, // Выравнивание текста по центру по горизонтали
    //       ),
    //       Text(
    //         S.of(context).MainTitle,
    //         style: Theme.of(context).textTheme.bodyMedium,
    //         textAlign: TextAlign.center, // Выравнивание текста по центру по горизонтали
    //       ),
    //     ],)
    // )
    // );
  }
}
//
// class MainPageBody extends StatefulWidget {
//   const MainPageBody({super.key});
//
//   @override
//   State<MainPageBody> createState() => _MainPageBodyState();
// }
//
// class _MainPageBodyState extends State<MainPageBody> {
//   int timeLeft = 5;
//   //Главный метод
//   void _StartCountDown(){
//     Timer.periodic(Duration(seconds: 1), (Timer timer) {
//         setState(() {
//           if(timeLeft>0) {
//             timeLeft--;
//           }
//           else {
//             timer.cancel();
//           }
//         });
//     }
//     );
//   }
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child:Column(//Колонка в которой будет все приложение
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,//Выравнивание с местом меж объектами
//           children: [
//           Text(timeLeft.toString(), style: Theme.of(context).textTheme.bodyLarge),//Текст в котором будет время
//           IconButton(onPressed: _StartCountDown,//Кнопка для запуска таймера
//             icon: Icon(Icons.not_started_outlined),
//             iconSize: 70.0, // Устанавливает размер иконки
//             padding: EdgeInsets.all(16.0), // Устанавливает отступы вокруг иконки
//             style: ButtonStyle(foregroundColor:  WidgetStateProperty.all<Color>(Theme.of(context).textTheme.bodyLarge!.color!)))
//             ])
//       ),
//     )
//       ;
//   }
// }

//         theme: ThemeData(
//         colorScheme: ColorScheme.light(primary: Colors.deepOrange),),//theme  - тема для всего приложения
//       home: Scaffold(//база для множества объектов
//         appBar: AppBar(
//             title: Text('Верхний бар'),
//             centerTitle: true,
//             backgroundColor: Colors.deepOrange,),
//         body:
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [Text("Текст1"),Text("Текст2"),
//
//                 TextButton(onPressed: () {} ,child: Text("jkjkjkjkjkjH"))],),
//               Column(children: [Text("Текст1"),Text("Текст2"),
//                 TextButton(onPressed: () {} ,child: Text("H"))],)
//             ],
//           ),
//           //: Image( image:AssetImage('assets/HD.jpg'))
//           // ElevatedButton.icon(onPressed: () {},icon: Icon(Icons.timer), label: Text("Кнопка с иконкой"))
//             //ElevatedButton
//           // child: TextButton(
//           //   onPressed: () {},
//           //   style: TextButton.styleFrom(
//           //     //backgroundColor: Colors.deepOrange,
//           //
//           //     textStyle: TextStyle(fontSize: 16),
//           //   ),
//           //   child: Text("Нажми"),
//           // )
//           // Icon(Icons.adb_sharp, color: Colors.deepOrange, size: 244,),
//
//         floatingActionButton:
//       FloatingActionButton(
//         onPressed: () {
//           print("Clicked");
//         },
//           child: Text("Click"),
//         backgroundColor: Colors.deepOrange ,
//       )
//       ),
//     );
//   }
//
// }
