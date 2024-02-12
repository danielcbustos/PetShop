import 'dart:ui';

import 'package:flutter/material.dart';

class Adapt {
  static MediaQueryData mediaQuery = MediaQueryData.fromWindow(window);
  static var _ratio = init(1080);

  static init(int number) {
    int uiheigth = number > 0 ? number : 1080;
    _ratio = mediaQuery.size.height / uiheigth;
  }

  static px(number) {
    if (!(_ratio is double || _ratio is int) || _ratio == 0.0) {
      Adapt.init(1080);
    }
    return number * _ratio;
  }

  static double wp(percentaje, BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    double result = (percentaje * width) / 100;
    return result;
  }

  static double hp(percentaje, BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    double result = (percentaje * height) / 100;
    return result;
  }
}
