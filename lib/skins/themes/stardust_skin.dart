import 'package:flutter/material.dart';
import '../skin_interface.dart';
import '../skin_animation_config.dart';

class StardustSkin implements CalculatorSkin {
  const StardustSkin();

  @override String get id => 'stardust';
  @override String get name => '星尘连线';
  @override String get description => '星际尘埃间的星座连线，宇宙深处的低语';
  @override String get animationLabel => '星座连线+钻石边框';
  @override IconData get icon => Icons.auto_awesome_outlined;
  @override Brightness get brightness => Brightness.dark;

  @override Color get primaryColor => const Color(0xFFFFD700);
  @override Color get backgroundColor => const Color(0xFF060418);
  @override Color get surfaceColor => const Color(0xFF0C0828);
  @override Color get cardColor => const Color(0xFF140F38);

  @override Color get displayBackground => const Color(0xFF060418);
  @override Color get displayTextColor => const Color(0xFFFFD700);
  @override Color get expressionTextColor => const Color(0xFF9D70FF);

  @override Color get numberButtonBg => const Color(0xFF140F38);
  @override Color get numberButtonFg => const Color(0xFFE6C0FF);
  @override Color get operatorButtonBg => const Color(0xFF5E2B9E);
  @override Color get operatorButtonFg => const Color(0xFFFFFFFF);
  @override Color get functionButtonBg => const Color(0xFF0C0828);
  @override Color get functionButtonFg => const Color(0xFFB8860B);
  @override Color get equalsButtonBg => const Color(0xFFFFD700);
  @override Color get equalsButtonFg => const Color(0xFF060418);

  @override Color get navbarBg => const Color(0xFF060418);
  @override Color get navbarSelectedFg => const Color(0xFFFFD700);
  @override Color get navbarUnselectedFg => const Color(0xFF5A4870);
  @override Color get appBarBg => const Color(0xFF060418);
  @override Color get appBarFg => const Color(0xFFE6C0FF);

  @override LinearGradient? get backgroundGradient => const LinearGradient(
        colors: [Color(0xFF060418), Color(0xFF0C0828), Color(0xFF140F38), Color(0xFF060418)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      );
  @override BoxDecoration? get displayDecoration => const BoxDecoration(
        color: Color(0xFF060418),
        border: Border.fromBorderSide(BorderSide(color: Color(0x44FFD700), width: 1.5)),
        borderRadius: BorderRadius.all(Radius.circular(16)),
        boxShadow: [BoxShadow(color: Color(0x449D70FF), blurRadius: 16, spreadRadius: 1)],
      );
  @override double get buttonRadius => 14;
  @override EdgeInsets get buttonMargin => const EdgeInsets.all(4);
  @override BoxBorder? get buttonBorder => Border.all(color: const Color(0x33FFD700), width: 1);

  @override bool get hasGlowEffect => true;
  @override bool get hasGradientButtons => true;
  @override SkinAnimationConfig get animationConfig => SkinAnimationConfig.constellation;

  @override Map<String, dynamic> toJson() => {'id': id, 'name': name, 'description': description, 'type': 'stardust', 'animation': animationLabel};
}
