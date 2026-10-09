import 'package:flutter/material.dart';
import '../skin_interface.dart';

class ClassicSkin implements CalculatorSkin {
  const ClassicSkin();

  @override String get id => 'classic';
  @override String get name => '经典商务';
  @override String get description => '黑白灰简约，专业大气';
  @override IconData get icon => Icons.business;
  @override Brightness get brightness => Brightness.dark;

  @override Color get primaryColor => const Color(0xFF3A3A3A);
  @override Color get backgroundColor => const Color(0xFF1C1C1E);
  @override Color get surfaceColor => const Color(0xFF2C2C2E);
  @override Color get cardColor => const Color(0xFF3A3A3C);

  @override Color get displayBackground => const Color(0xFF2C2C2E);
  @override Color get displayTextColor => const Color(0xFFFFFFFF);
  @override Color get expressionTextColor => const Color(0xFF8E8E93);

  @override Color get numberButtonBg => const Color(0xFF3A3A3C);
  @override Color get numberButtonFg => const Color(0xFFFFFFFF);
  @override Color get operatorButtonBg => const Color(0xFFFF9F0A);
  @override Color get operatorButtonFg => const Color(0xFFFFFFFF);
  @override Color get functionButtonBg => const Color(0xFF636366);
  @override Color get functionButtonFg => const Color(0xFFFFFFFF);
  @override Color get equalsButtonBg => const Color(0xFF0A84FF);
  @override Color get equalsButtonFg => const Color(0xFFFFFFFF);

  @override Color get navbarBg => const Color(0xFF1C1C1E);
  @override Color get navbarSelectedFg => const Color(0xFF0A84FF);
  @override Color get navbarUnselectedFg => const Color(0xFF636366);
  @override Color get appBarBg => const Color(0xFF1C1C1E);
  @override Color get appBarFg => const Color(0xFFFFFFFF);

  @override LinearGradient? get backgroundGradient => null;
  @override BoxDecoration? get displayDecoration => null;
  @override double get buttonRadius => 10;
  @override EdgeInsets get buttonMargin => const EdgeInsets.all(4);
  @override BoxBorder? get buttonBorder => null;

  @override Map<String, dynamic> toJson() => {'id': id, 'name': name, 'description': description, 'type': 'classic'};
}