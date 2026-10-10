import 'package:flutter/material.dart';
import '../skin_interface.dart';
import '../skin_animation_config.dart';

class DiamondSkin implements CalculatorSkin {
  const DiamondSkin();

  @override String get id => 'diamond';
  @override String get name => '钻石璀璨';
  @override String get description => '钻石镶边闪烁，极光冰晶般的纯净光芒';
  @override String get animationLabel => '钻石闪烁+边框流光';
  @override IconData get icon => Icons.diamond;
  @override Brightness get brightness => Brightness.dark;

  @override Color get primaryColor => const Color(0xFFE1F5FE);
  @override Color get backgroundColor => const Color(0xFF0A0F1F);
  @override Color get surfaceColor => const Color(0xFF101830);
  @override Color get cardColor => const Color(0xFF182040);

  @override Color get displayBackground => const Color(0xFF0A0F1F);
  @override Color get displayTextColor => const Color(0xFFE1F5FE);
  @override Color get expressionTextColor => const Color(0xFF80DEEA);

  @override Color get numberButtonBg => const Color(0xFF182040);
  @override Color get numberButtonFg => const Color(0xFFE0F7FA);
  @override Color get operatorButtonBg => const Color(0xFF00BCD4);
  @override Color get operatorButtonFg => const Color(0xFFFFFFFF);
  @override Color get functionButtonBg => const Color(0xFF101830);
  @override Color get functionButtonFg => const Color(0xFFB2EBF2);
  @override Color get equalsButtonBg => const Color(0xFFE1F5FE);
  @override Color get equalsButtonFg => const Color(0xFF0A0F1F);

  @override Color get navbarBg => const Color(0xFF0A0F1F);
  @override Color get navbarSelectedFg => const Color(0xFFE1F5FE);
  @override Color get navbarUnselectedFg => const Color(0xFF506080);
  @override Color get appBarBg => const Color(0xFF0A0F1F);
  @override Color get appBarFg => const Color(0xFFE1F5FE);

  @override LinearGradient? get backgroundGradient => const LinearGradient(
        colors: [Color(0xFF0A0F1F), Color(0xFF101830), Color(0xFF0A0F1F)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      );
  @override BoxDecoration? get displayDecoration => const BoxDecoration(
        color: Color(0xFF0A0F1F),
        border: Border.fromBorderSide(BorderSide(color: Color(0x66E1F5FE), width: 1.5)),
        borderRadius: BorderRadius.all(Radius.circular(16)),
        boxShadow: [BoxShadow(color: Color(0x44E1F5FE), blurRadius: 20, spreadRadius: 1)],
      );
  @override double get buttonRadius => 14;
  @override EdgeInsets get buttonMargin => const EdgeInsets.all(4);
  @override BoxBorder? get buttonBorder => Border.all(color: const Color(0x44E1F5FE), width: 1);

  @override bool get hasGlowEffect => true;
  @override bool get hasGradientButtons => true;
  @override SkinAnimationConfig get animationConfig => SkinAnimationConfig.diamondSparkle;

  @override Map<String, dynamic> toJson() => {'id': id, 'name': name, 'description': description, 'type': 'diamond', 'animation': animationLabel};
}
