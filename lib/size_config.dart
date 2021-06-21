import 'package:flutter/cupertino.dart';

class Config{

  static double _screenWidth;
  static double _screenHeight;
  static double blockSizeHorizental;
  static double blockSizeVertical;
  static double textMultipier;
  static double heightMultiplier;
  static double imageSizeMultipier;
  void int(BoxConstraints constraints,Orientation orientation){
    if(orientation == Orientation.portrait){
      _screenWidth = constraints.maxWidth;
      _screenHeight = constraints.maxHeight;

    }else{
      _screenWidth = constraints.maxHeight;
      _screenHeight = constraints.maxWidth;
    }
      blockSizeHorizental=_screenWidth/100;
    blockSizeVertical=_screenHeight/100;
    textMultipier=blockSizeVertical;
    heightMultiplier=blockSizeVertical;
    imageSizeMultipier=blockSizeHorizental;
  }
}