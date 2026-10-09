import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../skins/skin_manager.dart';

class CalculatorDisplay extends StatelessWidget {
  final String expression;
  final String result;
  final double height;

  const CalculatorDisplay({
    super.key,
    required this.expression,
    required this.result,
    this.height = 160,
  });

  @override
  Widget build(BuildContext context) {
    final skinManager = context.watch<SkinManager>();
    final skin = skinManager.currentSkin;

    final decoration = skin.displayDecoration ??
        BoxDecoration(
          color: skin.displayBackground.withOpacity(0.8),
          borderRadius: const BorderRadius.vertical(bottom: Radius.circular(24)),
        );

    final glowColor = skin.hasGlowEffect
        ? skin.primaryColor.withOpacity(0.15)
        : Colors.transparent;

    return Container(
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: decoration.color,
        gradient: decoration.gradient,
        border: decoration.border,
        borderRadius: decoration.borderRadius ??
            const BorderRadius.vertical(bottom: Radius.circular(24)),
        boxShadow: [
          ...?decoration.boxShadow,
          BoxShadow(
            color: glowColor,
            blurRadius: 20,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Flexible(
            child: SingleChildScrollView(
              reverse: true,
              scrollDirection: Axis.horizontal,
              child: Text(
                expression.isEmpty ? '0' : expression,
                style: TextStyle(
                  color: skin.expressionTextColor,
                  fontSize: 22,
                  fontFamily: 'monospace',
                ),
                textAlign: TextAlign.right,
              ),
            ),
          ),
          const SizedBox(height: 8),
          _GlitchText(
            text: result,
            color: skin.displayTextColor,
            hasGlow: skin.hasGlowEffect,
            glowColor: skin.primaryColor,
          ),
        ],
      ),
    );
  }
}

class _GlitchText extends StatelessWidget {
  final String text;
  final Color color;
  final bool hasGlow;
  final Color glowColor;

  const _GlitchText({
    required this.text,
    required this.color,
    this.hasGlow = false,
    required this.glowColor,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: 40,
        fontWeight: FontWeight.w300,
        fontFamily: 'monospace',
        shadows: hasGlow
            ? [
                Shadow(
                  color: glowColor.withOpacity(0.6),
                  blurRadius: 12,
                ),
                Shadow(
                  color: glowColor.withOpacity(0.3),
                  blurRadius: 24,
                ),
              ]
            : null,
      ),
      textAlign: TextAlign.right,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}
