import 'dart:math';

import 'package:flutter/material.dart';

class ColorConstants {
  static Color mainScaffoldBackgroundColor = const Color(0xffffffff);
  static Color secondaryScaffoldBacground = const Color(0xffF9F5F0);

  static Color snakbarColorsuccessful = const Color(0xff008000);
  static Color snakbarColorError = const Color(0xffFF0000);
  static Color textFiledmColor = const Color(0xffE6E6E6);
  static Color mainTextColor = const Color(0xff020953);
  static Color subTextColor = const Color(0xffC91416);
  static Color buttonColor = const Color(0xffEC6453);
  static Color backProductButton = const Color(0xffE0E1E3);
  static Color greyColor = const Color(0xff808080);

  static Color generateRandomColor() {
    final random = Random();
    return Color.fromARGB(
      255,
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    );
  }
}
