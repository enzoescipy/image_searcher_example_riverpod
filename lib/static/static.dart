import 'package:flutter/material.dart';

abstract class Palette {
  // https://www.behance.net/gallery/16592635/N-I-S-H-I-K-I-G-O-Furniture-Design-Award-2014/
  // https://color.adobe.com/ko/explore
  static const primary = Color(0xff127369);
  static const elevatedPrimary = Color(0xff10403B);

  static const secondary = Color(0xff8AA6A3);
  static final secondary50 = Color.lerp(white, secondary, 0.50);
  static final secondary25 = Color.lerp(white, secondary, 0.25);

  static const elevatedSecondary = Color(0xff4C5958);
  static const background = Color.fromARGB(255, 226, 226, 226);
  static const white = Colors.white;
  static const black = Colors.black87;
}

abstract class Dimention {
  static const pageHorizontalPadding = 3.0;
  static const pageVerticalPadding = 15.0;
}
