import 'package:flutter/material.dart';
import '../skin_interface.dart';
import '../skin_animation_config.dart';

class BlackGoldSkin implements CalculatorSkin {
  const BlackGoldSkin();

  @override String get id => 'black_gold';
  @override String get name => '黑金';
  @override String get description => '暗夜鎏金，奢华大气的王者之选';
  @override String get animationLabel => '金光闪耀+碎金漂浮';
  @override IconData get icon => Icons.diamond;
  @override Brightness get brightness => Brightness.dark;

  @override Color get primaryColor => const Color(0xFFFFD700);
  @override Color get backgroundColor => const Color(0xFF0A0A0A);
  @override Color get surfaceColor => const Color(0xFF141414);
  @override Color get cardColor => const Color(0xFF1A1A1A);

  @override Color get displayBackground => const Color(0xFF0A0A0A);
  @override Color get displayTextColor => const Color(0xFFFFD700);
  @override Color get expressionTextColor => const Color(0xFFB8860B);

  @override Color get numberButtonBg => const Color(0xFF1A1A1A);
  @override Color get numberButtonFg => const Color(0xFFFFD700);
  @override Color get operatorButtonBg => const Color(0xFF2A2A2A);
  @override Color get operatorButtonFg => const Color(0xFFFFC125);
  @override Color get functionButtonBg => const Color(0xFF141414);
  @override Color get functionButtonFg => const Color(0xFFDAA520);
  @override Color get equalsButtonBg => const Color(0xFFFFD700);
  @override Color get equalsButtonFg => const Color(0xFF0A0A0A);

  @override Color get navbarBg => const Color(0xFF0A0A0A);
  @override Color get navbarSelectedFg => const Color(0xFFFFD700);
  @override Color get navbarUnselectedFg => const Color(0xFF5A5A5A);
  @override Color get appBarBg => const Color(0xFF0A0A0A);
  @override Color get appBarFg => const Color(0xFFFFD700);

  @override LinearGradient? get backgroundGradient => const LinearGradient(
        colors: [Color(0xFF0A0A0A), Color(0xFF141414), Color(0xFF0A0A0A)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      );
  @override BoxDecoration? get displayDecoration => BoxDecoration(
        color: const Color(0xFF0A0A0A),
        border: Border.all(color: const Color(0x66FFD700), width: 1.5),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Color(0x44FFD700), blurRadius: 20, spreadRadius: 1),
        ],
      );
  @override double get buttonRadius => 14;
  @override EdgeInsets get buttonMargin => const EdgeInsets.all(4);
  @override BoxBorder? get buttonBorder => Border.all(color: const Color(0x44FFD700), width: 1);

  @override bool get hasGlowEffect => true;
  @override bool get hasGradientButtons => true;
  @override SkinAnimationConfig get animationConfig => SkinAnimationConfig.blackGold;

  @override Map<String, dynamic> toJson() => {'id': id, 'name': name, 'description': description, 'type': 'black_gold', 'animation': animationLabel};
}
