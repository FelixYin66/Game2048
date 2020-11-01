import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:event_bus/event_bus.dart';
import 'package:game2048/apperance.dart';
import 'game2048number.dart';
import 'devicefit.dart';
import 'tilemodel.dart';
import 'datamanager.dart';
import 'pangesture.dart';


final eventBus = EventBus();

class Game2048App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    //初始化屏幕适配器
    DeviceFix.initinalize();

    //初始化数据
    DataManager.gameDataInitinalize();

    //测试算法
    // testArithmetic();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppearanceTheme.theme,
        home: HomePage()
    );
  }
}


class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("2048"),
      ),
      body: HomePageContent(),
    );
  }
}

class HomePageContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PanGesture(
      child: Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: children(context)
            ),
          ),
        ),
      panDirectionCallback: (GestureDirection direction){
        moveTile(context, direction);
      },
    );
  }

  List<Widget> children(BuildContext context){
    return [
      GameBoardScoreWidget(),
      SizedBox(height: 30.rpt,),
      GameBoardNumberWidget()
    ];
  }

  moveTile(BuildContext context,GestureDirection direction){
    GameState state = GameState.normal;
    if(direction == GestureDirection.left){
      state = DataManager.moveToLeft();
    }else if(direction == GestureDirection.right){
      state = DataManager.moveToRight();
    }else if(direction == GestureDirection.top){
      state = DataManager.moveToTop();
    }else if(direction == GestureDirection.bottom){
      state = DataManager.moveToBottom();
    }
    eventBus.fire("");
    alertDialog(state, context);
  }

  void alertDialog(GameState state,BuildContext context){

    if(state == GameState.normal){
      return;
    }

    if(state == GameState.lost){
      showDialog(
          context: context,
          builder: (BuildContext ctx){
            return AlertDialog(
              title: Text("你输了"),
              content: Text("你输了"),
            );
          }
      );
      return;
    }


    if(state == GameState.win){
      showDialog(
          context: context,
          builder: (BuildContext ctx){
            return AlertDialog(
              title: Text("你赢了"),
              content: Text("你赢了"),
            );
          }
      );
      return;
    }

  }


}


class GameBoardScoreWidget extends StatefulWidget {
  @override
  _GameBoardScoreWidgetState createState() => _GameBoardScoreWidgetState();
}

class _GameBoardScoreWidgetState extends State<GameBoardScoreWidget> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    eventBus.on().listen((value){
      setState(() {

      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250.rpt,
      height: 80.rpt,
      child: Text(
        "SCORE:${DataManager.score}",
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.rpt),
          color: Colors.black
      ),
      alignment: Alignment.center,
    );
  }
}

class GameBoardNumberWidget extends StatefulWidget {
  @override
  _GameBoardNumberWidgetState createState() => _GameBoardNumberWidgetState();
}

class _GameBoardNumberWidgetState extends State<GameBoardNumberWidget> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    eventBus.on().listen((value){
      setState(() {
        //更新
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500.rpt,
      height: 500.rpt,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.rpt),
        color: Colors.black
      ),
      child: GridView.count(
          crossAxisCount:4,
        children: children(),
        crossAxisSpacing: 10.rpt,
        mainAxisSpacing: 10.rpt,
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.all(10.rpt),
      )
    );
  }

  SliverGridDelegateWithFixedCrossAxisCount gridDelegate(){
    return SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 4,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10
    );
  }

  List<Game2048NumberTitle> children(){
    int rowCount = DataManager.rowCount;
    int total = DataManager.totalCount;
    return List.generate(total, (int index){
      int row = (index/rowCount).toInt();
      int column = index%rowCount;
      TileModel model = DataManager.numberList[row][column];
      return Game2048NumberTitle(model);
    });
  }
}

void testArithmetic(){


  DataManager.testInsertNumber();


  // DataManager.moveToBottom();//移动
  // DataManager.moveToRight();
  // DataManager.moveToLeft();
  // DataManager.moveToBottom();
  // DataManager.moveToTop();
  //
  // List<List<TileModel>> moveList = DataManager.numberList;
  // print("移动之后");
  // String str= "";
  // for(int i = 0;i < moveList.length;i++){
  //   for(int ii=0;ii<moveList[i].length;ii++){
  //     TileModel model = moveList[i][ii];
  //     str+= "${model.number} ";
  //   }
  //   print(str);
  //   str = "";
  // }
}