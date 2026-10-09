import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../skins/skin_manager.dart';

enum ButtonType { number, operator, function, equals }

class CalcButton extends StatelessWidget {
  final String label;
  final ButtonType type;
  final VoidCallback? onTap;
  final int flex;
  final Widget? child;

  const CalcButton({
    super.key,
    required this.label,
    required this.type,
    this.onTap,
    this.flex = 1,
  }) : child = null;

  const CalcButton.icon({
    super.key,
    required this.label,
    required this.type,
    this.onTap,
    this.flex = 1,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final skinManager = context.watch<SkinManager>();
    final skin = skinManager.currentSkin;

    Color bg;
    Color fg;
    LinearGradient? gradient;

    switch (type) {
      case ButtonType.number:
        bg = skin.numberButtonBg;
        fg = skin.numberButtonFg;
        gradient = skin.hasGradientButtons
            ? LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  skin.numberButtonBg,
                  HSLColor.fromColor(skin.numberButtonBg)
                      .withLightness(
                        (HSLColor.fromColor(skin.numberButtonBg).lightness +
                            0.06)
                            .clamp(0.0, 1.0),
                      )
                      .toColor(),
                ],
              )
            : null;
        break;
      case ButtonType.operator:
        bg = skin.operatorButtonBg;
        fg = skin.operatorButtonFg;
        gradient = skin.hasGradientButtons
            ? LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  skin.operatorButtonBg,
                  HSLColor.fromColor(skin.operatorButtonBg)
                      .withLightness(
                        (HSLColor.fromColor(skin.operatorButtonBg).lightness +
                            0.08)
                            .clamp(0.0, 1.0),
                      )
                      .toColor(),
                ],
              )
            : null;
        break;
      case ButtonType.function:
        bg = skin.functionButtonBg;
        fg = skin.functionButtonFg;
        gradient = skin.hasGradientButtons
            ? LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  skin.functionButtonBg,
                  HSLColor.fromColor(skin.functionButtonBg)
                      .withLightness(
                        (HSLColor.fromColor(skin.functionButtonBg).lightness +
                            0.06)
                            .clamp(0.0, 1.0),
                      )
                      .toColor(),
                ],
              )
            : null;
        break;
      case ButtonType.equals:
        bg = skin.equalsButtonBg;
        fg = skin.equalsButtonFg;
        gradient = skin.hasGradientButtons
            ? LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  skin.equalsButtonBg,
                  HSLColor.fromColor(skin.equalsButtonBg)
                      .withHue(
                        (HSLColor.fromColor(skin.equalsButtonBg).hue + 15) %
                            360,
                      )
                      .toColor(),
                ],
              )
            : null;
        break;
    }

    final glowColor = skin.hasGlowEffect ? bg.withOpacity(0.35) : null;
    final radius = skin.buttonRadius > 0 ? skin.buttonRadius : 14.0;

    return Expanded(
      flex: flex,
      child: Padding(
        padding: skin.buttonMargin,
        child: _AnimatedButton(
          bg: bg,
          fg: fg,
          gradient: gradient,
          glowColor: glowColor,
          radius: radius,
          border: skin.buttonBorder,
          onTap: onTap,
          isEquals: type == ButtonType.equals,
          child: child ??
              Text(
                label,
                style: TextStyle(
                  color: fg,
                  fontSize: type == ButtonType.equals ? 26 : 22,
                  fontWeight: type == ButtonType.equals
                      ? FontWeight.bold
                      : FontWeight.w500,
                ),
              ),
        ),
      ),
    );
  }
}

class _AnimatedButton extends StatefulWidget {
  final Color bg;
  final Color fg;
  final LinearGradient? gradient;
  final Color? glowColor;
  final double radius;
  final BoxBorder? border;
  final VoidCallback? onTap;
  final bool isEquals;
  final Widget child;

  const _AnimatedButton({
    required this.bg,
    required this.fg,
    this.gradient,
    this.glowColor,
    required this.radius,
    this.border,
    this.onTap,
    this.isEquals = false,
    required this.child,
  });

  @override
  State<_AnimatedButton> createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<_AnimatedButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnim;
  late Animation<double> _glowAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnim = Tween<double>(begin: 1.0, end: 0.92).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _glowAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnim.value,
          child: child,
        );
      },
      child: GestureDetector(
        onTapDown: (_) => _controller.forward(),
        onTapUp: (_) {
          _controller.reverse();
          widget.onTap?.call();
        },
        onTapCancel: () => _controller.reverse(),
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Container(
              height: 60,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                gradient: widget.gradient,
                color: widget.gradient == null ? widget.bg : null,
                borderRadius: BorderRadius.circular(widget.radius),
                border: widget.border,
                boxShadow: widget.glowColor != null
                    ? [
                        BoxShadow(
                          color: widget.glowColor!,
                          blurRadius: 8 + _glowAnim.value * 12,
                          spreadRadius: _glowAnim.value * 2,
                        ),
                      ]
                    : null,
              ),
              child: child,
            );
          },
          child: widget.child,
        ),
      ),
    );
  }
}
