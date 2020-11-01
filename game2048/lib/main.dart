import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'game2048app.dart';
import 'pangesture.dart';

// Game2048App()

main()=>runApp(Game2048App());


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return HomePage();
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("标题"),
        ),
        body: HomePageContent(),
      ),
    );
  }
}

class HomePageContent extends StatelessWidget {

  final int leftCount = 0;
  final int rightCount = 0;
  final int topCount = 0;
  final int bottomCount = 0;

  @override
  Widget build(BuildContext context) {

    return Center(
      child: PanGesture(
        child: Container(
          width: 300,
          height: 300,
          color: Colors.red,
        ),
        panDirectionCallback: (GestureDirection direction){
          printDirection(direction);
        },
      ),
    );

    // return PanGesture(
    // );
  }

  printDirection(GestureDirection direction){
    if(direction == GestureDirection.left){
      print("向左");
    }else if(direction == GestureDirection.right){
      print("向右");
    }else if(direction == GestureDirection.top){
      print("向上");
    }else if(direction == GestureDirection.bottom){
      print("向下");
    }else{
      print("未识别手势方向");
    }
  }

}








