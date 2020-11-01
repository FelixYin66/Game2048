import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'tilemodel.dart';

enum GameState{
  lost,
  win,
  normal
}

class DataManager{
  static int colCount = 4;
  static int rowCount = 4;
  static int totalCount = 16;
  static int score = 0;
  static int _winScore = 2048;
  static bool _isDebug = false;
  //数字不能等于rowCount或者colCount 当数据接近满数据时 随机生成数字可能死循环
  static int _maxNum = 50;

  static List<List<TileModel>> numberList;
  static void gameDataInitinalize(){
    numberList = [
      [
        TileModel(),
        TileModel(),
        TileModel(),
        TileModel()
      ],
      [
        TileModel(),
        TileModel(),
        TileModel(),
        TileModel()
      ],
      [
        TileModel(),
        TileModel(),
        TileModel(),
        TileModel()
      ],
      [
        TileModel(),
        TileModel(),
        TileModel(),
        TileModel()
      ]
    ];

    //随机插入两个数字
    _randomInsterNumber();
    _randomInsterNumber();

  }

  //左移动
  static GameState moveToLeft(){
    _printBeforeMove(msg: "向左移动之前");
    int count = numberList.length;
    for(int i = 0;i<count;i++){
      List<TileModel> list = numberList[i];
      list = _combine(list);
      numberList[i] = list;
    }

    GameState state = _moveAfter();
    _printBeforeMove(msg: "向左移动之后");
    return state;
  }

  //右移动
  static GameState moveToRight(){
    _printBeforeMove(msg: "向右移动之前");
    int count = numberList.length;
    for(int i = 0;i<count;i++){
      List<TileModel> list = numberList[i];
      list = list.reversed.toList();
      list = _combine(list);
      //重组数组（还原数据）
      numberList[i] = list.reversed.toList();
    }

    GameState state = _moveAfter();
    _printBeforeMove(msg: "向右移动之后");
    return state;
  }

  //上移动
  static GameState moveToTop(){
    _printBeforeMove(msg: "向上移动之前");
    int count = numberList.length;
    for(int i = 0;i<count;i++){
      List<TileModel> list = numberList[i];
      List<TileModel> newList = List<TileModel>(count);
      for(int ii = 0;ii<count;ii++){
        newList[ii] = numberList[ii][i];
      }
      list = _combine(newList);

      //重组数组
      for(int iii = 0;iii<list.length;iii++){
        numberList[iii][i] = list[iii];
      }
    }

    GameState state = _moveAfter();
    _printBeforeMove(msg: "向上移动之后");
    return state;
  }

  //下移动
  static GameState moveToBottom(){
    _printBeforeMove(msg: "向下移动之前");
    numberList = numberList.reversed.toList();
    int count = numberList.length;
    for(int i =0;i<count;i++){
      List<TileModel> list = numberList[i];
      List<TileModel> newList = List<TileModel>(count);
      for(int ii =0;ii<count;ii++){
        newList[ii] = numberList[ii][i];
      }
      newList = _combine(newList);

      //重组数组(还原数据)
      newList = newList.reversed.toList();
      for(int iii = 0;iii<count;iii++){
        numberList[iii][i] = newList[iii];
      }

    }

    GameState state = _moveAfter();
    _printBeforeMove(msg: "向下移动之后");
    return state;
  }

  //排序
  static List<TileModel> _sortList(List<TileModel> list){
    int count = list.length;
    List<TileModel> newList = List<TileModel>(count);
    int newIndex = 0;
    int zeroIndex = 0;
    for(int i = 0;i < count;i++){
      TileModel model = list[i];
      if(model.number > 0){
        newList[newIndex++] = model;
      }else{
        zeroIndex++;
        newList[count-zeroIndex] = model;
      }
    }
    return newList;
  }

  //合并
  static List<TileModel> _combine(List<TileModel> list){
    list = _sortList(list);
    int count = list.length;
    for(int i = 0;i<count;i++){
      TileModel model = list[i];
      int nextIndex = i+1;
      if(model.number > 0 && (nextIndex < count) && (model.number == list[nextIndex].number)){
        model.number = model.number + list[nextIndex].number;
        list[nextIndex].number = 0;
        score += model.number*2;//计算分数
      }
    }
    return _sortList(list);
  }


  /*
  * 移动后状态判断
  *
  * */

  static GameState _moveAfter(){
    _randomInsterNumber();
    GameState state = checkState();
    return state;
  }

  static GameState checkState(){
    bool result = win();
    if(result){
      return GameState.win;
    }

    result = lost();
    if(result){
      //输了
      return GameState.lost;
    }

    return GameState.normal;
  }

  static bool lost(){

    //是否有空
    bool result = _haveEmpty();
    if(result){
      return false;
    }

    //满员
    int totalCount = numberList.length;
    for(int i = 0;i<totalCount;i++){
      List list = numberList[i];
      int count = list.length;
      for(int ii = 0;ii<count;ii++){
        TileModel model = list[ii];
        TileModel model2;
        int nextCol = ii+1;
        if(nextCol <= (count-1)){
          model2 = list[nextCol];
          int num = model.number;
          int num2 = model2.number;
          if(num == num2){
            return false;
          }else{
            int nextRow = i+1;
            if(nextRow <= (totalCount-1)){
              List list2 = numberList[nextRow];
              model2 = list2[ii];
              if(model.number == model2.number){
                return false;
              }
            }
          }
        }
      }
    }
    //输了
    return true;
  }

  static bool win(){
    for(int i = 0;i<numberList.length;i++){
      List list = numberList[i];
      for(int ii = 0;ii<list.length;ii++){
        TileModel model = list[ii];
        int num = model.number;
        if(num > 0 && num==_winScore ){
          return true;
        }
      }
    }
    //没赢
    return false;
  }

  static bool _haveEmpty(){
    int totalCount = numberList.length;
    //是否有空
    for(int i = 0;i<totalCount;i++){
      List list = numberList[i];
      for(int ii = 0;ii<list.length;ii++){
        TileModel model = list[ii];
        if(model.number == 0){
          return true;
        }
      }
    }
    return false;
  }

  /*
  * 随机插入数字
  * */

  static int _randomRow(){
    Random random = Random();
    int newRow = 0;
    //随机找出一行中有空的数据
    bool recycle = true;
    int maxNum = 50;
    int count = 0;
    while(recycle){
      newRow = random.nextInt(_maxNum)%rowCount;
      count++;
      for(int i = 0;i<rowCount;i++){
        TileModel model = numberList[newRow][i];
        if(model.number == 0){
          recycle = false;
          break;
        }
      }
    }
    return newRow;
  }

  static int _randomCol(int row){
    Random random = Random();
    int newCol = 0;
    bool recycle = true;

    int count = 0;
    while(recycle){
      newCol = random.nextInt(_maxNum)%colCount;
      TileModel model = numberList[row][newCol];
      count++;
      if(model.number == 0){
        recycle = false;
        break;
      }
    }
    return newCol;
  }

  static _randomInsterNumber(){
    bool haveEmpty = _haveEmpty();
    if(!haveEmpty){
      return;
    }
    _printBeforeMove(msg:"随机插入之前");

    int randRow = _randomRow();
    int randCol = _randomCol(randRow);

    Random random = Random();
    List numList = [2,4];
    int numLength = numList.length;
    int numIndex = random.nextInt(numLength-1);
    int newNum = numList[numIndex];

    TileModel model = numberList[randRow][randCol];
    model.number = newNum;

    _printBeforeMove(msg: "随机插入之后");
  }


  /*
  * 测试打印
  *
  * */

  static testInsertNumber() {
    _randomInsterNumber();
  }

  static void _printBeforeMove({String msg=""}){
    if(!_isDebug){
      return;
    }
    print("${msg}");
    String str = "";
    for(int i = 0;i < numberList.length;i++){
      for(int ii=0;ii<numberList[i].length;ii++){
        TileModel model = numberList[i][ii];
        str += "${model.number} ";
      }
      print(str);
      str = "";
    }
  }

  static void _printList(List<TileModel> list){
    if(!_isDebug){
      return;
    }
    for(int i = 0;i < list.length;i++){
      TileModel model = list[i];
      print("${model.number}");
    }
    print("=========");
  }

}