import 'package:flutter/material.dart';
import '../skin_interface.dart';
import '../skin_animation_config.dart';

class GalaxySkin implements CalculatorSkin {
  const GalaxySkin();

  @override String get id => 'galaxy';
  @override String get name => '星河';
  @override String get description => '深邃星空，璀璨银河缓缓流淌';
  @override String get animationLabel => '星空漂移+星云闪烁';
  @override IconData get icon => Icons.stars;
  @override Brightness get brightness => Brightness.dark;

  @override Color get primaryColor => const Color(0xFFE6C0FF);
  @override Color get backgroundColor => const Color(0xFF0B0418);
  @override Color get surfaceColor => const Color(0xFF14082A);
  @override Color get cardColor => const Color(0xFF1E0D3D);

  @override Color get displayBackground => const Color(0xFF0B0418);
  @override Color get displayTextColor => const Color(0xFFE6C0FF);
  @override Color get expressionTextColor => const Color(0xFF9D70FF);

  @override Color get numberButtonBg => const Color(0xFF1E0D3D);
  @override Color get numberButtonFg => const Color(0xFFE0D0FF);
  @override Color get operatorButtonBg => const Color(0xFF9D70FF);
  @override Color get operatorButtonFg => const Color(0xFFFFFFFF);
  @override Color get functionButtonBg => const Color(0xFF5E2B9E);
  @override Color get functionButtonFg => const Color(0xFFE0D0FF);
  @override Color get equalsButtonBg => const Color(0xFFFFD700);
  @override Color get equalsButtonFg => const Color(0xFF0B0418);

  @override Color get navbarBg => const Color(0xFF0B0418);
  @override Color get navbarSelectedFg => const Color(0xFFFFD700);
  @override Color get navbarUnselectedFg => const Color(0xFF6A5A8A);
  @override Color get appBarBg => const Color(0xFF0B0418);
  @override Color get appBarFg => const Color(0xFFE6C0FF);

  @override LinearGradient? get backgroundGradient => const LinearGradient(
        colors: [Color(0xFF0B0418), Color(0xFF1E0D3D), Color(0xFF0B0418)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      );
  @override BoxDecoration? get displayDecoration => BoxDecoration(
        color: const Color(0xFF0B0418),
        border: Border.all(color: const Color(0x44E6C0FF), width: 1.5),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Color(0x449D70FF), blurRadius: 16, spreadRadius: 1),
        ],
      );
  @override double get buttonRadius => 14;
  @override EdgeInsets get buttonMargin => const EdgeInsets.all(4);
  @override BoxBorder? get buttonBorder => Border.all(color: const Color(0x33E6C0FF), width: 1);

  @override bool get hasGlowEffect => true;
  @override bool get hasGradientButtons => true;
  @override SkinAnimationConfig get animationConfig => SkinAnimationConfig.starfield;

  @override Map<String, dynamic> toJson() => {'id': id, 'name': name, 'description': description, 'type': 'galaxy', 'animation': animationLabel};
}
