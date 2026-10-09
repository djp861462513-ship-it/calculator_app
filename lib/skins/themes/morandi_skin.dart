import 'package:flutter/material.dart';
import '../skin_interface.dart';

class MorandiSkin implements CalculatorSkin {
  const MorandiSkin();

  @override String get id => 'morandi';
  @override String get name => '莫兰迪';
  @override String get description => '低饱和度柔和配色，高级舒适';
  @override IconData get icon => Icons.palette;
  @override Brightness get brightness => Brightness.light;

  @override Color get primaryColor => const Color(0xFFB8A9C9);
  @override Color get backgroundColor => const Color(0xFFF5F0F0);
  @override Color get surfaceColor => const Color(0xFFFDFBFB);
  @override Color get cardColor => const Color(0xFFF0EBEB);

  @override Color get displayBackground => const Color(0xFFF0EBEB);
  @override Color get displayTextColor => const Color(0xFF4A4A5A);
  @override Color get expressionTextColor => const Color(0xFF8E8E9A);

  @override Color get numberButtonBg => const Color(0xFFFDFBFB);
  @override Color get numberButtonFg => const Color(0xFF4A4A5A);
  @override Color get operatorButtonBg => const Color(0xFFE8D5C4);
  @override Color get operatorButtonFg => const Color(0xFF7A6B5D);
  @override Color get functionButtonBg => const Color(0xFFD5E8D4);
  @override Color get functionButtonFg => const Color(0xFF5D7A5B);
  @override Color get equalsButtonBg => const Color(0xFFB8A9C9);
  @override Color get equalsButtonFg => const Color(0xFFFFFFFF);

  @override Color get navbarBg => const Color(0xFFFDFBFB);
  @override Color get navbarSelectedFg => const Color(0xFFB8A9C9);
  @override Color get navbarUnselectedFg => const Color(0xFFC5C0C8);
  @override Color get appBarBg => const Color(0xFFB8A9C9);
  @override Color get appBarFg => const Color(0xFFFFFFFF);

  @override LinearGradient? get backgroundGradient => null;
  @override BoxDecoration? get displayDecoration => null;
  @override double get buttonRadius => 14;
  @override EdgeInsets get buttonMargin => const EdgeInsets.all(5);
  @override BoxBorder? get buttonBorder => null;

  @override Map<String, dynamic> toJson() => {'id': id, 'name': name, 'description': description, 'type': 'morandi'};
}