import 'package:flutter/material.dart';
import '../skin_interface.dart';
import '../skin_animation_config.dart';

class LavaSkin implements CalculatorSkin {
  const LavaSkin();

  @override String get id => 'lava';
  @override String get name => '熔岩';
  @override String get description => '炽热岩浆翻涌，火星飞溅的烈焰世界';
  @override String get animationLabel => '脉冲发光+火星飞溅';
  @override IconData get icon => Icons.local_fire_department;
  @override Brightness get brightness => Brightness.dark;

  @override Color get primaryColor => const Color(0xFFFF4500);
  @override Color get backgroundColor => const Color(0xFF1A0500);
  @override Color get surfaceColor => const Color(0xFF2D0A00);
  @override Color get cardColor => const Color(0xFF3D1000);

  @override Color get displayBackground => const Color(0xFF1A0500);
  @override Color get displayTextColor => const Color(0xFFFFD700);
  @override Color get expressionTextColor => const Color(0xFFFF8C00);

  @override Color get numberButtonBg => const Color(0xFF3D1000);
  @override Color get numberButtonFg => const Color(0xFFFFE0B2);
  @override Color get operatorButtonBg => const Color(0xFFFF6B00);
  @override Color get operatorButtonFg => const Color(0xFFFFFFFF);
  @override Color get functionButtonBg => const Color(0xFF8B2500);
  @override Color get functionButtonFg => const Color(0xFFFFCC80);
  @override Color get equalsButtonBg => const Color(0xFFFF4500);
  @override Color get equalsButtonFg => const Color(0xFFFFFFFF);

  @override Color get navbarBg => const Color(0xFF1A0500);
  @override Color get navbarSelectedFg => const Color(0xFFFF6B00);
  @override Color get navbarUnselectedFg => const Color(0xFF8B4513);
  @override Color get appBarBg => const Color(0xFF1A0500);
  @override Color get appBarFg => const Color(0xFFFFD700);

  @override LinearGradient? get backgroundGradient => const LinearGradient(
        colors: [Color(0xFF1A0500), Color(0xFF3D1000), Color(0xFF1A0500)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      );
  @override BoxDecoration? get displayDecoration => BoxDecoration(
        color: const Color(0xFF1A0500),
        border: Border.all(color: const Color(0x44FF4500), width: 1.5),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Color(0x44FF4500), blurRadius: 16, spreadRadius: 2),
        ],
      );
  @override double get buttonRadius => 12;
  @override EdgeInsets get buttonMargin => const EdgeInsets.all(3);
  @override BoxBorder? get buttonBorder => Border.all(color: const Color(0x33FF4500), width: 1);

  @override bool get hasGlowEffect => true;
  @override bool get hasGradientButtons => true;
  @override SkinAnimationConfig get animationConfig => SkinAnimationConfig.lava;

  @override Map<String, dynamic> toJson() => {'id': id, 'name': name, 'description': description, 'type': 'lava', 'animation': animationLabel};
}
