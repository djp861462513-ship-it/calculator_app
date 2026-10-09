import 'package:flutter/material.dart';
import '../skin_interface.dart';
import '../skin_animation_config.dart';

class NatureSkin implements CalculatorSkin {
  const NatureSkin();

  @override String get id => 'nature';
  @override String get name => '森系自然';
  @override String get description => '绿色大地色系，清新宁静';
  @override String get animationLabel => '浮叶飘动';
  @override IconData get icon => Icons.forest;
  @override Brightness get brightness => Brightness.light;

  @override Color get primaryColor => const Color(0xFF6B8F71);
  @override Color get backgroundColor => const Color(0xFFF2F7F2);
  @override Color get surfaceColor => const Color(0xFFFAFCFA);
  @override Color get cardColor => const Color(0xFFEDF4ED);

  @override Color get displayBackground => const Color(0xFFEDF4ED);
  @override Color get displayTextColor => const Color(0xFF2C3E2D);
  @override Color get expressionTextColor => const Color(0xFF6B7F6C);

  @override Color get numberButtonBg => const Color(0xFFFAFCFA);
  @override Color get numberButtonFg => const Color(0xFF2C3E2D);
  @override Color get operatorButtonBg => const Color(0xFFD4A76A);
  @override Color get operatorButtonFg => const Color(0xFFFFFFFF);
  @override Color get functionButtonBg => const Color(0xFFAED8B0);
  @override Color get functionButtonFg => const Color(0xFF2C3E2D);
  @override Color get equalsButtonBg => const Color(0xFF6B8F71);
  @override Color get equalsButtonFg => const Color(0xFFFFFFFF);

  @override Color get navbarBg => const Color(0xFFFAFCFA);
  @override Color get navbarSelectedFg => const Color(0xFF6B8F71);
  @override Color get navbarUnselectedFg => const Color(0xFFB0C4B1);
  @override Color get appBarBg => const Color(0xFF6B8F71);
  @override Color get appBarFg => const Color(0xFFFFFFFF);

  @override LinearGradient? get backgroundGradient => const LinearGradient(
        colors: [Color(0xFFF2F7F2), Color(0xFFE8F0E4), Color(0xFFF2F7F2)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
  @override BoxDecoration? get displayDecoration => null;
  @override double get buttonRadius => 20;
  @override EdgeInsets get buttonMargin => const EdgeInsets.all(5);
  @override BoxBorder? get buttonBorder => null;

  @override bool get hasGlowEffect => false;
  @override bool get hasGradientButtons => true;
  @override SkinAnimationConfig get animationConfig => SkinAnimationConfig.natureFloat;

  @override Map<String, dynamic> toJson() => {'id': id, 'name': name, 'description': description, 'type': 'nature'};
}