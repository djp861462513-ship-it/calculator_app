import 'package:flutter/material.dart';
import '../skin_interface.dart';
import '../skin_animation_config.dart';

class FireworkSkin implements CalculatorSkin {
  const FireworkSkin();

  @override String get id => 'firework';
  @override String get name => '烟花夜';
  @override String get description => '暗夜绽放的璀璨烟花，每一瞬都是高光时刻';
  @override String get animationLabel => '烟花迸发+加法混合';
  @override IconData get icon => Icons.celebration;
  @override Brightness get brightness => Brightness.dark;

  @override Color get primaryColor => const Color(0xFFFFD700);
  @override Color get backgroundColor => const Color(0xFF050313);
  @override Color get surfaceColor => const Color(0xFF0A0820);
  @override Color get cardColor => const Color(0xFF121030);

  @override Color get displayBackground => const Color(0xFF050313);
  @override Color get displayTextColor => const Color(0xFFFFD700);
  @override Color get expressionTextColor => const Color(0xFFFF6E40);

  @override Color get numberButtonBg => const Color(0xFF121030);
  @override Color get numberButtonFg => const Color(0xFFE0E0FF);
  @override Color get operatorButtonBg => const Color(0xFFFF1744);
  @override Color get operatorButtonFg => const Color(0xFFFFFFFF);
  @override Color get functionButtonBg => const Color(0xFF1A1535);
  @override Color get functionButtonFg => const Color(0xFF76FF03);
  @override Color get equalsButtonBg => const Color(0xFFFFD700);
  @override Color get equalsButtonFg => const Color(0xFF050313);

  @override Color get navbarBg => const Color(0xFF050313);
  @override Color get navbarSelectedFg => const Color(0xFFFFD700);
  @override Color get navbarUnselectedFg => const Color(0xFF4A4068);
  @override Color get appBarBg => const Color(0xFF050313);
  @override Color get appBarFg => const Color(0xFFFFD700);

  @override LinearGradient? get backgroundGradient => const LinearGradient(
        colors: [Color(0xFF050313), Color(0xFF0A0820), Color(0xFF050313)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      );
  @override BoxDecoration? get displayDecoration => const BoxDecoration(
        color: Color(0xFF050313),
        border: Border.fromBorderSide(BorderSide(color: Color(0x44FFD700), width: 1.5)),
        borderRadius: BorderRadius.all(Radius.circular(16)),
        boxShadow: [BoxShadow(color: Color(0x44FFD700), blurRadius: 20, spreadRadius: 1)],
      );
  @override double get buttonRadius => 14;
  @override EdgeInsets get buttonMargin => const EdgeInsets.all(4);
  @override BoxBorder? get buttonBorder => Border.all(color: const Color(0x33FFD700), width: 1);

  @override bool get hasGlowEffect => true;
  @override bool get hasGradientButtons => true;
  @override SkinAnimationConfig get animationConfig => SkinAnimationConfig.fireworksNight;

  @override Map<String, dynamic> toJson() => {'id': id, 'name': name, 'description': description, 'type': 'firework', 'animation': animationLabel};
}
