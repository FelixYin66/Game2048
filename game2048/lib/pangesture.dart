import 'package:flutter/material.dart';
import 'dart:math';


enum GestureDirection{
  left,
  right,
  top,
  bottom,
  none
}

typedef GesturePanDirectionCallback = void Function(GestureDirection direction);

class PanGesture extends StatefulWidget {
  final Widget child;
  final GesturePanDirectionCallback panDirectionCallback;

  PanGesture({this.child,this.panDirectionCallback});

  @override
  _PanGestureState createState() => _PanGestureState();
}

class _PanGestureState extends State<PanGesture> {
  int leftCount = 0;
  int rightCount = 0;
  int topCount = 0;
  int bottomCount = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: (DragStartDetails details){
        leftCount = 0;
        rightCount = 0;
        topCount = 0;
        bottomCount = 0;
      },
      onPanUpdate: (DragUpdateDetails details){
        recognizeGestureDirection(details.delta);
      },
      onPanEnd: (DragEndDetails details){
        GestureDirection direction = panDirection();
        this.widget.panDirectionCallback(direction);
      },
      child: this.widget.child,
    );
  }

  //手势方向识别
  recognizeGestureDirection(Offset offset){
    double x = offset.dx;
    double y = offset.dy;

    if(x == 0 && y == 0){
      return;
    }

    double newX = x.abs();
    double newY = y.abs();

    //水平方向
    if(newX > newY){
      if(x > 0){
        //向右
        rightCount++;
      }else{
        //向左
        leftCount++;
      }

      return;
    }

    if(y == 0){
      return;
    }

    //垂直方向
    if(y > 0){
      //向下
      bottomCount++;
    }else{
      //向上
      topCount++;
    }
  }

  GestureDirection panDirection(){
    int maxNum = max(leftCount, rightCount);
    maxNum = max(maxNum, topCount);
    maxNum = max(maxNum, bottomCount);

    if(maxNum == leftCount){
      return GestureDirection.left;
    }else if(maxNum == rightCount){
      return GestureDirection.right;
    }else if(maxNum == topCount){
      return GestureDirection.top;
    }else if(maxNum == bottomCount){
      return GestureDirection.bottom;
    }else{
      return GestureDirection.none;
    }
  }

}
