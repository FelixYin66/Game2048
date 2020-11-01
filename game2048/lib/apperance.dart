import 'dart:ui';
import 'package:flutter/material.dart';
import 'devicefit.dart';

class AppearanceTheme{

  //主题色
  static ThemeData theme = ThemeData(
      textTheme: TextTheme(
          body1: TextStyle(
              fontSize: 28.rpt,
              fontWeight: FontWeight.bold,
              color: Colors.white
          )
      )
  );

  //数字对应的颜色
  static Color getColor(int number){
    switch(number){
      case 2:
        return Color.fromRGBO(238,228,100,1);
      case 4:
        return Color.fromRGBO(237,204,100,1);
      case 8:
        return Color.fromRGBO(242,177,121,1);
      case 16:
        return Color.fromRGBO(245,149,99,1);
      case 32:
        return Color.fromRGBO(246,124,95,1);
      case 64:
        return Color.fromRGBO(246,94,59,1);
      case 128:
        return Color.fromRGBO(237,207,114,1);
      case 256:
        return Color.fromRGBO(235,107,114,1);
      case 512:
        return Color.fromRGBO(215,90,113,1);
      case 1024:
        return Color.fromRGBO(200,90,101,1);
      case 2048:
        return Color.fromRGBO(233,119,114,1);
      case 0:
        return Color.fromRGBO(238,228,200,0.2);
    }
  }

}