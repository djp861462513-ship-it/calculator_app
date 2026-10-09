import 'package:flutter/material.dart';
import '../skin_interface.dart';

class CyberpunkSkin implements CalculatorSkin {
  const CyberpunkSkin();

  @override String get id => 'cyberpunk';
  @override String get name => '赛博朋克';
  @override String get description => '深色霓虹灯配色，科技感十足';
  @override IconData get icon => Icons.nightlight_round;
  @override Brightness get brightness => Brightness.dark;

  @override Color get primaryColor => const Color(0xFF00F5FF);
  @override Color get backgroundColor => const Color(0xFF0A0E27);
  @override Color get surfaceColor => const Color(0xFF11143A);
  @override Color get cardColor => const Color(0xFF1A1F4E);

  @override Color get displayBackground => const Color(0xFF0D1130);
  @override Color get displayTextColor => const Color(0xFF00F5FF);
  @override Color get expressionTextColor => const Color(0xFF7B68EE);

  @override Color get numberButtonBg => const Color(0xFF1A1F4E);
  @override Color get numberButtonFg => const Color(0xFFE0E0FF);
  @override Color get operatorButtonBg => const Color(0xFFFF007F);
  @override Color get operatorButtonFg => const Color(0xFFFFFFFF);
  @override Color get functionButtonBg => const Color(0xFF7B68EE);
  @override Color get functionButtonFg => const Color(0xFFFFFFFF);
  @override Color get equalsButtonBg => const Color(0xFF00F5FF);
  @override Color get equalsButtonFg => const Color(0xFF0A0E27);

  @override Color get navbarBg => const Color(0xFF0D1130);
  @override Color get navbarSelectedFg => const Color(0xFF00F5FF);
  @override Color get navbarUnselectedFg => const Color(0xFF5A5A8A);
  @override Color get appBarBg => const Color(0xFF0D1130);
  @override Color get appBarFg => const Color(0xFF00F5FF);

  @override LinearGradient? get backgroundGradient => const LinearGradient(
        colors: [Color(0xFF0A0E27), Color(0xFF11143A), Color(0xFF0A0E27)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      );
  @override BoxDecoration? get displayDecoration => BoxDecoration(
        color: const Color(0xFF0D1130),
        border: Border.all(color: const Color(0x4400F5FF), width: 1),
        borderRadius: BorderRadius.circular(12),
      );
  @override double get buttonRadius => 8;
  @override EdgeInsets get buttonMargin => const EdgeInsets.all(3);
  @override BoxBorder? get buttonBorder => Border.all(color: const Color(0x3300F5FF), width: 1);

  @override Map<String, dynamic> toJson() => {'id': id, 'name': name, 'description': description, 'type': 'cyberpunk'};
}