import 'package:flutter/material.dart';

class SizeConfig {
  static late final MediaQueryData _mediaQueryData;
  static double screenWidth = _mediaQueryData.size.width;
  static double screenHeight = _mediaQueryData.size.height;
  static double blockSizeHorizontal = screenHeight / 100;
  static double blockSizeVertical = screenWidth / 100;

  void init(BuildContext context) {
    MediaQueryData _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;
  }
}
