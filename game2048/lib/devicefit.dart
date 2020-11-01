import 'dart:ui';

/*
* 管理手机适配类
*
* 默认以iPhone6作为参考标准
*
* */
class DeviceFix{

  static double phsicalWidth;
  static double phsicalHeight;
  static double screenWidth;
  static double screenHeight;
  static double rpt;
  static double px;


  static initinalize({double standardSize = 750}){
    phsicalWidth = window.physicalSize.width;
    phsicalHeight = window.physicalSize.height;

    double ratio = window.devicePixelRatio;
    screenWidth = phsicalWidth/ratio;
    screenHeight = phsicalHeight/ratio;

    //以standardSize大小平均分配屏幕大小
    rpt = screenWidth/standardSize; //以点作为单位
    px = rpt*2; //以像素作为单位
  }

  //size是像素(以pt作为单位)
  static double setRpt(double size){
    return rpt*size;
  }

  //size是像素（以像素作为单位）
  static double setPx(double size){
    return px*size;
  }

}

/*
* 对double进行拓展，重写get方法，翻遍使用DeviceFix
* */
extension DoubleFit on double{
  double get rpt{
    return DeviceFix.setRpt(this);
  }

  double get px{
    return DeviceFix.setPx(this);
  }

}


/*
* 对int进行拓展，重写get方法，翻遍使用DeviceFix
*
* */
extension IntFit on int{
  double get rpt{
    return DeviceFix.setRpt(this.toDouble());
  }

  double get px{
    return DeviceFix.setPx(this.toDouble());
  }
}
