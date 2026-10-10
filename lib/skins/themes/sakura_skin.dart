import 'package:flutter/material.dart';
import '../skin_interface.dart';
import '../skin_animation_config.dart';

class SakuraSkin implements CalculatorSkin {
  const SakuraSkin();

  @override String get id => 'sakura';
  @override String get name => '樱花雨';
  @override String get description => '粉嫩花瓣随风飘舞，浪漫如春日花见';
  @override String get animationLabel => '花瓣飘落+风摇';
  @override IconData get icon => Icons.local_florist;
  @override Brightness get brightness => Brightness.light;

  @override Color get primaryColor => const Color(0xFFE91E63);
  @override Color get backgroundColor => const Color(0xFFFFF0F5);
  @override Color get surfaceColor => const Color(0xFFFFFFFF);
  @override Color get cardColor => const Color(0xFFFFE4EC);

  @override Color get displayBackground => const Color(0xFFFFE4EC);
  @override Color get displayTextColor => const Color(0xFF880E4F);
  @override Color get expressionTextColor => const Color(0xFFAD1457);

  @override Color get numberButtonBg => const Color(0xFFFFFFFF);
  @override Color get numberButtonFg => const Color(0xFF880E4F);
  @override Color get operatorButtonBg => const Color(0xFFE91E63);
  @override Color get operatorButtonFg => const Color(0xFFFFFFFF);
  @override Color get functionButtonBg => const Color(0xFFF8BBD0);
  @override Color get functionButtonFg => const Color(0xFF880E4F);
  @override Color get equalsButtonBg => const Color(0xFFE91E63);
  @override Color get equalsButtonFg => const Color(0xFFFFFFFF);

  @override Color get navbarBg => const Color(0xFFFFFFFF);
  @override Color get navbarSelectedFg => const Color(0xFFE91E63);
  @override Color get navbarUnselectedFg => const Color(0xFFE0B0C0);
  @override Color get appBarBg => const Color(0xFFFFC1CC);
  @override Color get appBarFg => const Color(0xFF880E4F);

  @override LinearGradient? get backgroundGradient => const LinearGradient(
        colors: [Color(0xFFFFF0F5), Color(0xFFFFE4EC), Color(0xFFFFC1CC), Color(0xFFFFE4EC)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
  @override BoxDecoration? get displayDecoration => const BoxDecoration(
        color: Color(0xFFFFE4EC),
        border: Border.fromBorderSide(BorderSide(color: Color(0x44E91E63), width: 1.5)),
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: [BoxShadow(color: Color(0x22E91E63), blurRadius: 12, spreadRadius: 2)],
      );
  @override double get buttonRadius => 20;
  @override EdgeInsets get buttonMargin => const EdgeInsets.all(4);
  @override BoxBorder? get buttonBorder => Border.all(color: const Color(0x22E91E63), width: 1);

  @override bool get hasGlowEffect => true;
  @override bool get hasGradientButtons => true;
  @override SkinAnimationConfig get animationConfig => SkinAnimationConfig.cherryBlossom;

  @override Map<String, dynamic> toJson() => {'id': id, 'name': name, 'description': description, 'type': 'sakura', 'animation': animationLabel};
}
