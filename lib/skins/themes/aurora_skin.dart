import 'package:flutter/material.dart';
import '../skin_interface.dart';
import '../skin_animation_config.dart';

class AuroraSkin implements CalculatorSkin {
  const AuroraSkin();

  @override String get id => 'aurora';
  @override String get name => '极光';
  @override String get description => '北欧极光，深空舞动的流光溢彩';
  @override String get animationLabel => '极光波动+星空闪烁';
  @override IconData get icon => Icons.auto_awesome;
  @override Brightness get brightness => Brightness.dark;

  @override Color get primaryColor => const Color(0xFF00FF87);
  @override Color get backgroundColor => const Color(0xFF0A0E27);
  @override Color get surfaceColor => const Color(0xFF0D1B2A);
  @override Color get cardColor => const Color(0xFF1B2A41);

  @override Color get displayBackground => const Color(0xFF0D1B2A);
  @override Color get displayTextColor => const Color(0xFF00FF87);
  @override Color get expressionTextColor => const Color(0xFF60EFFD);

  @override Color get numberButtonBg => const Color(0xFF1B2A41);
  @override Color get numberButtonFg => const Color(0xFFE0FBFC);
  @override Color get operatorButtonBg => const Color(0xFF0099F7);
  @override Color get operatorButtonFg => const Color(0xFFFFFFFF);
  @override Color get functionButtonBg => const Color(0xFFA06CD4);
  @override Color get functionButtonFg => const Color(0xFFFFFFFF);
  @override Color get equalsButtonBg => const Color(0xFF00FF87);
  @override Color get equalsButtonFg => const Color(0xFF0A0E27);

  @override Color get navbarBg => const Color(0xFF0D1B2A);
  @override Color get navbarSelectedFg => const Color(0xFF00FF87);
  @override Color get navbarUnselectedFg => const Color(0xFF5A6A8A);
  @override Color get appBarBg => const Color(0xFF0D1B2A);
  @override Color get appBarFg => const Color(0xFF00FF87);

  @override LinearGradient? get backgroundGradient => const LinearGradient(
        colors: [Color(0xFF0A0E27), Color(0xFF0D1B2A), Color(0xFF1B2A41)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      );
  @override BoxDecoration? get displayDecoration => BoxDecoration(
        color: const Color(0xFF0D1B2A),
        border: Border.all(color: const Color(0x4400FF87), width: 1.5),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Color(0x4400FF87), blurRadius: 20, spreadRadius: 2),
        ],
      );
  @override double get buttonRadius => 16;
  @override EdgeInsets get buttonMargin => const EdgeInsets.all(4);
  @override BoxBorder? get buttonBorder => Border.all(color: const Color(0x3300FF87), width: 1);

  @override bool get hasGlowEffect => true;
  @override bool get hasGradientButtons => true;
  @override SkinAnimationConfig get animationConfig => SkinAnimationConfig.aurora;

  @override Map<String, dynamic> toJson() => {'id': id, 'name': name, 'description': description, 'type': 'aurora', 'animation': animationLabel};
}
