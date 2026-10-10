import 'dart:math' as math;
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
  final GlobalKey? buttonKey;

  const CalcButton({
    super.key,
    required this.label,
    required this.type,
    this.onTap,
    this.flex = 1,
    this.buttonKey,
  }) : child = null;

  const CalcButton.icon({
    super.key,
    required this.label,
    required this.type,
    this.onTap,
    this.flex = 1,
    this.buttonKey,
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
                      .withLightness((HSLColor.fromColor(skin.numberButtonBg).lightness + 0.06).clamp(0.0, 1.0))
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
                      .withLightness((HSLColor.fromColor(skin.operatorButtonBg).lightness + 0.08).clamp(0.0, 1.0))
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
                      .withLightness((HSLColor.fromColor(skin.functionButtonBg).lightness + 0.06).clamp(0.0, 1.0))
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
                      .withHue((HSLColor.fromColor(skin.equalsButtonBg).hue + 15) % 360)
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
          key: buttonKey,
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
                  fontWeight: type == ButtonType.equals ? FontWeight.bold : FontWeight.w500,
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
    super.key,
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
    final skinManager = context.watch<SkinManager>();
    final skin = skinManager.currentSkin;
    final hasDiamondBorder = skin.id == 'diamond' || skin.id == 'stardust';

    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) {
        _controller.reverse();
        widget.onTap?.call();
      },
      onTapCancel: () => _controller.reverse(),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnim.value,
            child: Stack(
              children: [
                Container(
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
                ),
                if (hasDiamondBorder)
                  Positioned.fill(
                    child: _DiamondBorderEffect(
                      color: skin.primaryColor,
                      radius: widget.radius,
                    ),
                  ),
              ],
            ),
          );
        },
        child: widget.child,
      ),
    );
  }
}

class _DiamondBorderEffect extends StatefulWidget {
  final Color color;
  final double radius;

  const _DiamondBorderEffect({required this.color, required this.radius});

  @override
  State<_DiamondBorderEffect> createState() => _DiamondBorderEffectState();
}

class _DiamondBorderEffectState extends State<_DiamondBorderEffect>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (context, _) {
        return CustomPaint(
          painter: _DiamondBorderPainter(
            progress: _ctrl.value,
            color: widget.color,
            radius: widget.radius,
          ),
          child: Container(),
        );
      },
    );
  }
}

class _DiamondBorderPainter extends CustomPainter {
  final double progress;
  final Color color;
  final double radius;

  _DiamondBorderPainter({
    required this.progress,
    required this.color,
    required this.radius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final r = radius;
    final w = size.width;
    final h = size.height;
    final path = Path()
      ..moveTo(r, 0)
      ..lineTo(w - r, 0)
      ..arcToPoint(Offset(w, r), radius: Radius.circular(r))
      ..lineTo(w, h - r)
      ..arcToPoint(Offset(w - r, h), radius: Radius.circular(r))
      ..lineTo(r, h)
      ..arcToPoint(Offset(0, h - r), radius: Radius.circular(r))
      ..lineTo(0, r)
      ..arcToPoint(Offset(r, 0), radius: Radius.circular(r));

    final pathMetrics = path.computeMetrics();
    double totalLen = 0;
    for (final m in pathMetrics) {
      totalLen += m.length;
    }

    const sparkCount = 5;
    for (int i = 0; i < sparkCount; i++) {
      final t = (progress + i / sparkCount) % 1.0;
      final pos = t * totalLen;
      var remaining = pos;
      Offset? point;
      for (final m in pathMetrics) {
        if (remaining <= m.length) {
          point = m.getTangentForOffset(remaining)!.position;
          break;
        }
        remaining -= m.length;
      }
      if (point == null) continue;

      final sparkle = 0.5 + 0.5 * (math.sin(progress * 4 * math.pi + i)).abs();
      final paint = Paint()..color = color.withOpacity(sparkle);
      final s = 3.0 * sparkle;

      final diamondPath = Path()
        ..moveTo(point.dx, point.dy - s)
        ..lineTo(point.dx + s * 0.7, point.dy)
        ..lineTo(point.dx, point.dy + s)
        ..lineTo(point.dx - s * 0.7, point.dy)
        ..close();
      canvas.drawPath(diamondPath, paint);

      canvas.drawCircle(point, s * 2.5, Paint()..color = color.withOpacity(sparkle * 0.3));
    }
  }

  @override
  bool shouldRepaint(covariant _DiamondBorderPainter old) => old.progress != progress;
}
