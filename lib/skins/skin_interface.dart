import 'package:flutter/material.dart';

abstract class CalculatorSkin {
  String get id;
  String get name;
  String get description;
  IconData get icon;

  Brightness get brightness;

  Color get primaryColor;
  Color get backgroundColor;
  Color get surfaceColor;
  Color get cardColor;

  Color get displayBackground;
  Color get displayTextColor;
  Color get expressionTextColor;

  Color get numberButtonBg;
  Color get numberButtonFg;
  Color get operatorButtonBg;
  Color get operatorButtonFg;
  Color get functionButtonBg;
  Color get functionButtonFg;
  Color get equalsButtonBg;
  Color get equalsButtonFg;

  Color get navbarBg;
  Color get navbarSelectedFg;
  Color get navbarUnselectedFg;
  Color get appBarBg;
  Color get appBarFg;

  LinearGradient? get backgroundGradient;
  BoxDecoration? get displayDecoration;
  double get buttonRadius;
  EdgeInsets get buttonMargin;
  BoxBorder? get buttonBorder;

  Map<String, dynamic> toJson();
}