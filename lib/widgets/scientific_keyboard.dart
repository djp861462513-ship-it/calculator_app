import 'package:flutter/material.dart';
import 'calculator_button.dart';

class ScientificKeyboard extends StatelessWidget {
  final Function(String) onKeyTap;
  final VoidCallback onEquals;
  final VoidCallback onClear;
  final VoidCallback onDelete;
  final VoidCallback onToggleMode;
  final String angleMode;

  const ScientificKeyboard({
    super.key,
    required this.onKeyTap,
    required this.onEquals,
    required this.onClear,
    required this.onDelete,
    required this.onToggleMode,
    required this.angleMode,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            CalcButton(
              label: angleMode,
              type: ButtonType.function,
              onTap: onToggleMode,
            ),
            CalcButton(
              label: '(',
              type: ButtonType.function,
              onTap: () => onKeyTap('('),
            ),
            CalcButton(
              label: ')',
              type: ButtonType.function,
              onTap: () => onKeyTap(')'),
            ),
            CalcButton(
              label: 'AC',
              type: ButtonType.function,
              onTap: onClear,
            ),
            CalcButton(
              label: '⌫',
              type: ButtonType.function,
              onTap: onDelete,
            ),
          ],
        ),
        Row(
          children: [
            CalcButton(label: 'sin', type: ButtonType.function, onTap: () => onKeyTap('sin(')),
            CalcButton(label: 'cos', type: ButtonType.function, onTap: () => onKeyTap('cos(')),
            CalcButton(label: 'tan', type: ButtonType.function, onTap: () => onKeyTap('tan(')),
            CalcButton(label: 'log', type: ButtonType.function, onTap: () => onKeyTap('log(')),
            CalcButton(label: 'ln', type: ButtonType.function, onTap: () => onKeyTap('ln(')),
          ],
        ),
        Row(
          children: [
            CalcButton(label: '√', type: ButtonType.function, onTap: () => onKeyTap('sqrt(')),
            CalcButton(label: 'x²', type: ButtonType.function, onTap: () => onKeyTap('^2')),
            CalcButton(label: 'xʸ', type: ButtonType.function, onTap: () => onKeyTap('^')),
            CalcButton(label: 'x!', type: ButtonType.function, onTap: () => onKeyTap('!')),
            CalcButton(label: '1/x', type: ButtonType.function, onTap: () => onKeyTap('1/(')),
          ],
        ),
        Row(
          children: [
            CalcButton(label: '7', type: ButtonType.number, onTap: () => onKeyTap('7')),
            CalcButton(label: '8', type: ButtonType.number, onTap: () => onKeyTap('8')),
            CalcButton(label: '9', type: ButtonType.number, onTap: () => onKeyTap('9')),
            CalcButton(label: '÷', type: ButtonType.operator, onTap: () => onKeyTap('/')),
            CalcButton(label: 'π', type: ButtonType.function, onTap: () => onKeyTap('π')),
          ],
        ),
        Row(
          children: [
            CalcButton(label: '4', type: ButtonType.number, onTap: () => onKeyTap('4')),
            CalcButton(label: '5', type: ButtonType.number, onTap: () => onKeyTap('5')),
            CalcButton(label: '6', type: ButtonType.number, onTap: () => onKeyTap('6')),
            CalcButton(label: '×', type: ButtonType.operator, onTap: () => onKeyTap('*')),
            CalcButton(label: 'e', type: ButtonType.function, onTap: () => onKeyTap('e')),
          ],
        ),
        Row(
          children: [
            CalcButton(label: '1', type: ButtonType.number, onTap: () => onKeyTap('1')),
            CalcButton(label: '2', type: ButtonType.number, onTap: () => onKeyTap('2')),
            CalcButton(label: '3', type: ButtonType.number, onTap: () => onKeyTap('3')),
            CalcButton(label: '-', type: ButtonType.operator, onTap: () => onKeyTap('-')),
            CalcButton(label: '%', type: ButtonType.function, onTap: () => onKeyTap('%')),
          ],
        ),
        Row(
          children: [
            CalcButton(label: '.', type: ButtonType.number, onTap: () => onKeyTap('.')),
            CalcButton(label: '0', type: ButtonType.number, onTap: () => onKeyTap('0')),
            CalcButton(label: '±', type: ButtonType.function, onTap: () => onKeyTap('negate')),
            CalcButton(label: '+', type: ButtonType.operator, onTap: () => onKeyTap('+')),
            CalcButton(label: '=', type: ButtonType.equals, onTap: onEquals),
          ],
        ),
      ],
    );
  }
}