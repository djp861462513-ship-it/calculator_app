import 'package:flutter/material.dart';
import '../skin_interface.dart';
import '../skin_animation_config.dart';

class OceanSkin implements CalculatorSkin {
  const OceanSkin();

  @override String get id => 'ocean';
  @override String get name => '深海微光';
  @override String get description => '幽蓝深渊中的气泡升腾，生物荧光如梦似幻';
  @override String get animationLabel => '气泡上升+荧光加叠';
  @override IconData get icon => Icons.water_drop;
  @override Brightness get brightness => Brightness.dark;

  @override Color get primaryColor => const Color(0xFF00BFA5);
  @override Color get backgroundColor => const Color(0xFF002633);
  @override Color get surfaceColor => const Color(0xFF003D4D);
  @override Color get cardColor => const Color(0xFF005266);

  @override Color get displayBackground => const Color(0xFF002633);
  @override Color get displayTextColor => const Color(0xFF80DEEA);
  @override Color get expressionTextColor => const Color(0xFF00ACC1);

  @override Color get numberButtonBg => const Color(0xFF003D4D);
  @override Color get numberButtonFg => const Color(0xFFB2EBF2);
  @override Color get operatorButtonBg => const Color(0xFF006C7A);
  @override Color get operatorButtonFg => const Color(0xFFE0F7FA);
  @override Color get functionButtonBg => const Color(0xFF002633);
  @override Color get functionButtonFg => const Color(0xFF4DD0E1);
  @override Color get equalsButtonBg => const Color(0xFF00BFA5);
  @override Color get equalsButtonFg => const Color(0xFF002633);

  @override Color get navbarBg => const Color(0xFF002633);
  @override Color get navbarSelectedFg => const Color(0xFF00BFA5);
  @override Color get navbarUnselectedFg => const Color(0xFF005266);
  @override Color get appBarBg => const Color(0xFF002633);
  @override Color get appBarFg => const Color(0xFF80DEEA);

  @override LinearGradient? get backgroundGradient => const LinearGradient(
        colors: [Color(0xFF002633), Color(0xFF005266), Color(0xFF002633)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      );
  @override BoxDecoration? get displayDecoration => const BoxDecoration(
        color: Color(0xFF002633),
        border: Border.fromBorderSide(BorderSide(color: Color(0x4400BFA5), width: 1.5)),
        borderRadius: BorderRadius.all(Radius.circular(16)),
        boxShadow: [BoxShadow(color: Color(0x4400BFA5), blurRadius: 16, spreadRadius: 1)],
      );
  @override double get buttonRadius => 16;
  @override EdgeInsets get buttonMargin => const EdgeInsets.all(4);
  @override BoxBorder? get buttonBorder => Border.all(color: const Color(0x3300BFA5), width: 1);

  @override bool get hasGlowEffect => true;
  @override bool get hasGradientButtons => true;
  @override SkinAnimationConfig get animationConfig => SkinAnimationConfig.ocean;

  @override Map<String, dynamic> toJson() => {'id': id, 'name': name, 'description': description, 'type': 'ocean', 'animation': animationLabel};
}
