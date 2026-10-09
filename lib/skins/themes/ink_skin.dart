import 'package:flutter/material.dart';
import '../skin_interface.dart';
import '../skin_animation_config.dart';

class InkSkin implements CalculatorSkin {
  const InkSkin();

  @override String get id => 'ink';
  @override String get name => '水墨';
  @override String get description => '东方水墨意境，浓淡干湿虚实相生';
  @override String get animationLabel => '墨韵流动+墨点飘散';
  @override IconData get icon => Icons.brush;
  @override Brightness get brightness => Brightness.light;

  @override Color get primaryColor => const Color(0xFF2C2C2C);
  @override Color get backgroundColor => const Color(0xFFF5F0E8);
  @override Color get surfaceColor => const Color(0xFFFAF6EF);
  @override Color get cardColor => const Color(0xFFEDE5D8);

  @override Color get displayBackground => const Color(0xFFEDE5D8);
  @override Color get displayTextColor => const Color(0xFF1A1A1A);
  @override Color get expressionTextColor => const Color(0xFF6B6B6B);

  @override Color get numberButtonBg => const Color(0xFFFAF6EF);
  @override Color get numberButtonFg => const Color(0xFF2C2C2C);
  @override Color get operatorButtonBg => const Color(0xFF3A3A3A);
  @override Color get operatorButtonFg => const Color(0xFFF5F0E8);
  @override Color get functionButtonBg => const Color(0xFF8C8C8C);
  @override Color get functionButtonFg => const Color(0xFFFAF6EF);
  @override Color get equalsButtonBg => const Color(0xFF1A1A1A);
  @override Color get equalsButtonFg => const Color(0xFFF5F0E8);

  @override Color get navbarBg => const Color(0xFFFAF6EF);
  @override Color get navbarSelectedFg => const Color(0xFF1A1A1A);
  @override Color get navbarUnselectedFg => const Color(0xFFB0A898);
  @override Color get appBarBg => const Color(0xFFEDE5D8);
  @override Color get appBarFg => const Color(0xFF2C2C2C);

  @override LinearGradient? get backgroundGradient => const LinearGradient(
        colors: [Color(0xFFF5F0E8), Color(0xFFEDE5D8), Color(0xFFF5F0E8)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
  @override BoxDecoration? get displayDecoration => BoxDecoration(
        color: const Color(0xFFEDE5D8),
        border: Border.all(color: const Color(0x22000000), width: 1.5),
        borderRadius: BorderRadius.circular(20),
      );
  @override double get buttonRadius => 20;
  @override EdgeInsets get buttonMargin => const EdgeInsets.all(5);
  @override BoxBorder? get buttonBorder => Border.all(color: const Color(0x22000000), width: 1);

  @override bool get hasGradientButtons => true;
  @override SkinAnimationConfig get animationConfig => SkinAnimationConfig.inkWash;

  @override Map<String, dynamic> toJson() => {'id': id, 'name': name, 'description': description, 'type': 'ink', 'animation': animationLabel};
}
