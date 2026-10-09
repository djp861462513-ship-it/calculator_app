import 'package:flutter/material.dart';
import '../skin_interface.dart';
import '../skin_animation_config.dart';

class RainbowSkin implements CalculatorSkin {
  const RainbowSkin();

  @override String get id => 'rainbow';
  @override String get name => '彩虹糖';
  @override String get description => '七彩流动的糖果梦境，甜蜜而梦幻';
  @override String get animationLabel => '彩虹流转+气泡浮动';
  @override IconData get icon => Icons.looks;
  @override Brightness get brightness => Brightness.light;

  @override Color get primaryColor => const Color(0xFFFF0080);
  @override Color get backgroundColor => const Color(0xFFFFF8E7);
  @override Color get surfaceColor => const Color(0xFFFFFFFF);
  @override Color get cardColor => const Color(0xFFFFF0F5);

  @override Color get displayBackground => const Color(0xFFFFF8E7);
  @override Color get displayTextColor => const Color(0xFF4A0080);
  @override Color get expressionTextColor => const Color(0xFF8B008B);

  @override Color get numberButtonBg => const Color(0xFFFFFFFF);
  @override Color get numberButtonFg => const Color(0xFF4A0080);
  @override Color get operatorButtonBg => const Color(0xFFFF7F00);
  @override Color get operatorButtonFg => const Color(0xFFFFFFFF);
  @override Color get functionButtonBg => const Color(0xFF00BFFF);
  @override Color get functionButtonFg => const Color(0xFFFFFFFF);
  @override Color get equalsButtonBg => const Color(0xFFFF0080);
  @override Color get equalsButtonFg => const Color(0xFFFFFFFF);

  @override Color get navbarBg => const Color(0xFFFFFFFF);
  @override Color get navbarSelectedFg => const Color(0xFFFF0080);
  @override Color get navbarUnselectedFg => const Color(0xFFB0B0B0);
  @override Color get appBarBg => const Color(0xFFFF0080);
  @override Color get appBarFg => const Color(0xFFFFFFFF);

  @override LinearGradient? get backgroundGradient => const LinearGradient(
        colors: [
          Color(0xFFFFF8E7),
          Color(0xFFFFE0F0),
          Color(0xFFE0F0FF),
          Color(0xFFFFF8E7),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
  @override BoxDecoration? get displayDecoration => BoxDecoration(
        color: const Color(0xFFFFF8E7),
        border: Border.all(color: const Color(0x44FF0080), width: 1.5),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0x22FF0080),
            blurRadius: 12,
            spreadRadius: 2,
          ),
        ],
      );
  @override double get buttonRadius => 18;
  @override EdgeInsets get buttonMargin => const EdgeInsets.all(4);
  @override BoxBorder? get buttonBorder => Border.all(color: const Color(0x22FF0080), width: 1);

  @override bool get hasGlowEffect => true;
  @override bool get hasGradientButtons => true;
  @override SkinAnimationConfig get animationConfig => SkinAnimationConfig.rainbow;

  @override Map<String, dynamic> toJson() => {'id': id, 'name': name, 'description': description, 'type': 'rainbow', 'animation': animationLabel};
}
