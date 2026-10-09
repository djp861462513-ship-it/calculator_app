import 'package:flutter/material.dart';

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
    final theme = Theme.of(context);
    return Container(
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withOpacity(0.3),
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(24)),
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
                  color: theme.colorScheme.onSurface.withOpacity(0.6),
                  fontSize: 22,
                  fontFamily: 'monospace',
                ),
                textAlign: TextAlign.right,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            result,
            style: TextStyle(
              color: theme.colorScheme.onSurface,
              fontSize: 40,
              fontWeight: FontWeight.w300,
              fontFamily: 'monospace',
            ),
            textAlign: TextAlign.right,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}