import 'package:flutter/material.dart';

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
    final skin = Theme.of(context);
    Color bg;
    Color fg;

    switch (type) {
      case ButtonType.number:
        bg = skin.colorScheme.surface;
        fg = skin.colorScheme.onSurface;
        break;
      case ButtonType.operator:
        bg = skin.colorScheme.secondaryContainer;
        fg = skin.colorScheme.onSecondaryContainer;
        break;
      case ButtonType.function:
        bg = skin.colorScheme.tertiaryContainer;
        fg = skin.colorScheme.onTertiaryContainer;
        break;
      case ButtonType.equals:
        bg = skin.colorScheme.primary;
        fg = skin.colorScheme.onPrimary;
        break;
    }

    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.all(3),
        child: Material(
          color: bg,
          borderRadius: BorderRadius.circular(14),
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(14),
            child: Container(
              height: 60,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
              ),
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
        ),
      ),
    );
  }
}