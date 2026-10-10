import 'package:flutter/material.dart';
import '../skin_interface.dart';
import '../skin_animation_config.dart';

class NeonSkin implements CalculatorSkin {
  const NeonSkin();

  @override String get id => 'neon';
  @override String get name => '霓虹流光';
  @override String get description => '赛博霓虹粒子流，电光火石间穿越未来';
  @override String get animationLabel => '粒子流+加法混合';
  @override IconData get icon => Icons.electric_bolt;
  @override Brightness get brightness => Brightness.dark;

  @override Color get primaryColor => const Color(0xFFD500F9);
  @override Color get backgroundColor => const Color(0xFF050015);
  @override Color get surfaceColor => const Color(0xFF0A0028);
  @override Color get cardColor => const Color(0xFF10003C);

  @override Color get displayBackground => const Color(0xFF050015);
  @override Color get displayTextColor => const Color(0xFF00E5FF);
  @override Color get expressionTextColor => const Color(0xFFD500F9);

  @override Color get numberButtonBg => const Color(0xFF10003C);
  @override Color get numberButtonFg => const Color(0xFFE0B0FF);
  @override Color get operatorButtonBg => const Color(0xFF6200EA);
  @override Color get operatorButtonFg => const Color(0xFFFFFFFF);
  @override Color get functionButtonBg => const Color(0xFF0A0028);
  @override Color get functionButtonFg => const Color(0xFF00BFA5);
  @override Color get equalsButtonBg => const Color(0xFFD500F9);
  @override Color get equalsButtonFg => const Color(0xFFFFFFFF);

  @override Color get navbarBg => const Color(0xFF050015);
  @override Color get navbarSelectedFg => const Color(0xFFD500F9);
  @override Color get navbarUnselectedFg => const Color(0xFF4A2870);
  @override Color get appBarBg => const Color(0xFF050015);
  @override Color get appBarFg => const Color(0xFF00E5FF);

  @override LinearGradient? get backgroundGradient => const LinearGradient(
        colors: [Color(0xFF050015), Color(0xFF10003C), Color(0xFF050015)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      );
  @override BoxDecoration? get displayDecoration => const BoxDecoration(
        color: Color(0xFF050015),
        border: Border.fromBorderSide(BorderSide(color: Color(0x44D500F9), width: 1.5)),
        borderRadius: BorderRadius.all(Radius.circular(12)),
        boxShadow: [BoxShadow(color: Color(0x44D500F9), blurRadius: 16, spreadRadius: 1)],
      );
  @override double get buttonRadius => 10;
  @override EdgeInsets get buttonMargin => const EdgeInsets.all(3);
  @override BoxBorder? get buttonBorder => Border.all(color: const Color(0x33D500F9), width: 1);

  @override bool get hasGlowEffect => true;
  @override bool get hasGradientButtons => true;
  @override SkinAnimationConfig get animationConfig => SkinAnimationConfig.neonStream;

  @override Map<String, dynamic> toJson() => {'id': id, 'name': name, 'description': description, 'type': 'neon', 'animation': animationLabel};
}
