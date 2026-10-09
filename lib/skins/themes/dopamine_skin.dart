import 'package:flutter/material.dart';
import '../skin_interface.dart';
import '../skin_animation_config.dart';

class DopamineSkin implements CalculatorSkin {
  const DopamineSkin();

  @override String get id => 'dopamine';
  @override String get name => '多巴胺';
  @override String get description => '高饱和亮色系，充满活力与快乐';
  @override String get animationLabel => '微光闪烁';
  @override IconData get icon => Icons.emoji_emotions;
  @override Brightness get brightness => Brightness.light;

  @override Color get primaryColor => const Color(0xFFFF6B6B);
  @override Color get backgroundColor => const Color(0xFFFFF5F5);
  @override Color get surfaceColor => const Color(0xFFFFFFFF);
  @override Color get cardColor => const Color(0xFFFFF0F0);

  @override Color get displayBackground => const Color(0xFFFFF0F0);
  @override Color get displayTextColor => const Color(0xFF2D3436);
  @override Color get expressionTextColor => const Color(0xFF636E72);

  @override Color get numberButtonBg => const Color(0xFFFFFFFF);
  @override Color get numberButtonFg => const Color(0xFF2D3436);
  @override Color get operatorButtonBg => const Color(0xFFFFEAA7);
  @override Color get operatorButtonFg => const Color(0xFFD63031);
  @override Color get functionButtonBg => const Color(0xFFDFE6E9);
  @override Color get functionButtonFg => const Color(0xFF0984E3);
  @override Color get equalsButtonBg => const Color(0xFFFF6B6B);
  @override Color get equalsButtonFg => const Color(0xFFFFFFFF);

  @override Color get navbarBg => const Color(0xFFFFFFFF);
  @override Color get navbarSelectedFg => const Color(0xFFFF6B6B);
  @override Color get navbarUnselectedFg => const Color(0xFFB2BEC3);
  @override Color get appBarBg => const Color(0xFFFF6B6B);
  @override Color get appBarFg => const Color(0xFFFFFFFF);

  @override LinearGradient? get backgroundGradient => const LinearGradient(
        colors: [Color(0xFFFFF5F5), Color(0xFFFFE0E0), Color(0xFFFFF5F5)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
  @override BoxDecoration? get displayDecoration => null;
  @override double get buttonRadius => 16;
  @override EdgeInsets get buttonMargin => const EdgeInsets.all(4);
  @override BoxBorder? get buttonBorder => Border.all(color: const Color(0x33FF6B6B), width: 1);

  @override bool get hasGlowEffect => true;
  @override bool get hasGradientButtons => true;
  @override SkinAnimationConfig get animationConfig => SkinAnimationConfig.dopamineShimmer;

  @override Map<String, dynamic> toJson() => {'id': id, 'name': name, 'description': description, 'type': 'dopamine'};
}