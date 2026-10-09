import 'package:flutter/material.dart';
import '../widgets/calculator_button.dart';
import '../widgets/display_widget.dart';

class BasicCalculator extends StatefulWidget {
  final VoidCallback? onSwitchToScientific;

  const BasicCalculator({super.key, this.onSwitchToScientific});

  @override
  State<BasicCalculator> createState() => _BasicCalculatorState();
}

class _BasicCalculatorState extends State<BasicCalculator> {
  String _expression = '';
  String _result = '0';
  bool _shouldReset = false;

  void _onKeyTap(String key) {
    setState(() {
      if (_shouldReset) {
        _expression = '';
        _result = '0';
        _shouldReset = false;
      }
      if (key == 'AC') {
        _expression = '';
        _result = '0';
      } else if (key == '⌫') {
        if (_expression.isNotEmpty) {
          _expression = _expression.substring(0, _expression.length - 1);
          if (_expression.isEmpty) {
            _result = '0';
          } else {
            _evaluate();
          }
        }
      } else if (key == '%') {
        _expression += '%';
      } else {
        _expression += key;
        _evaluate();
      }
    });
  }

  void _onEquals() {
    setState(() {
      _evaluate(finalize: true);
      _shouldReset = true;
    });
  }

  void _evaluate({bool finalize = false}) {
    try {
      final expr = _expression.replaceAll('×', '*').replaceAll('÷', '/');
      if (expr.isEmpty) {
        _result = '0';
        return;
      }
      final evaluator = ExpressionEvaluator();
      final val = evaluator.evaluate(expr, finalize: finalize);
      if (val == val.toInt()) {
        _result = val.toInt().toString();
      } else {
        _result = val.toStringAsFixed(10).replaceAll(RegExp(r'0+$'), '').replaceAll(RegExp(r'\.$'), '');
      }
    } catch (_) {
      if (finalize) _result = 'Error';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CalculatorDisplay(expression: _expression, result: _result),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Column(
              children: [
                Row(
                  children: [
                    CalcButton(label: 'AC', type: ButtonType.function, onTap: () => _onKeyTap('AC'), flex: 2),
                    CalcButton(label: '⌫', type: ButtonType.function, onTap: () => _onKeyTap('⌫')),
                    CalcButton(label: '%', type: ButtonType.function, onTap: () => _onKeyTap('%')),
                    CalcButton(label: '÷', type: ButtonType.operator, onTap: () => _onKeyTap('÷')),
                  ],
                ),
                Row(
                  children: [
                    CalcButton(label: '7', type: ButtonType.number, onTap: () => _onKeyTap('7')),
                    CalcButton(label: '8', type: ButtonType.number, onTap: () => _onKeyTap('8')),
                    CalcButton(label: '9', type: ButtonType.number, onTap: () => _onKeyTap('9')),
                    CalcButton(label: '×', type: ButtonType.operator, onTap: () => _onKeyTap('×')),
                  ],
                ),
                Row(
                  children: [
                    CalcButton(label: '4', type: ButtonType.number, onTap: () => _onKeyTap('4')),
                    CalcButton(label: '5', type: ButtonType.number, onTap: () => _onKeyTap('5')),
                    CalcButton(label: '6', type: ButtonType.number, onTap: () => _onKeyTap('6')),
                    CalcButton(label: '-', type: ButtonType.operator, onTap: () => _onKeyTap('-')),
                  ],
                ),
                Row(
                  children: [
                    CalcButton(label: '1', type: ButtonType.number, onTap: () => _onKeyTap('1')),
                    CalcButton(label: '2', type: ButtonType.number, onTap: () => _onKeyTap('2')),
                    CalcButton(label: '3', type: ButtonType.number, onTap: () => _onKeyTap('3')),
                    CalcButton(label: '+', type: ButtonType.operator, onTap: () => _onKeyTap('+')),
                  ],
                ),
                Row(
                  children: [
                    CalcButton(label: '0', type: ButtonType.number, onTap: () => _onKeyTap('0'), flex: 2),
                    CalcButton(label: '.', type: ButtonType.number, onTap: () => _onKeyTap('.')),
                    CalcButton(label: '=', type: ButtonType.equals, onTap: _onEquals),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ExpressionEvaluator {
  int _pos = 0;
  String _expr = '';

  double evaluate(String expr, {bool finalize = false}) {
    _expr = expr.replaceAll(' ', '');
    _pos = 0;
    final result = _parseExpression();
    if (finalize && _pos < _expr.length) {
      throw FormatException('Unexpected character');
    }
    return result;
  }

  double _parseExpression() {
    double left = _parseTerm();
    while (_pos < _expr.length) {
      if (_expr[_pos] == '+') {
        _pos++;
        left += _parseTerm();
      } else if (_expr[_pos] == '-') {
        _pos++;
        left -= _parseTerm();
      } else {
        break;
      }
    }
    return left;
  }

  double _parseTerm() {
    double left = _parseFactor();
    while (_pos < _expr.length) {
      if (_expr[_pos] == '*') {
        _pos++;
        left *= _parseFactor();
      } else if (_expr[_pos] == '/') {
        _pos++;
        final divisor = _parseFactor();
        if (divisor == 0) throw FormatException('Division by zero');
        left /= divisor;
      } else if (_expr[_pos] == '%') {
        _pos++;
        left = left / 100;
      } else {
        break;
      }
    }
    return left;
  }

  double _parseFactor() {
    if (_pos >= _expr.length) throw FormatException('Unexpected end');

    if (_expr[_pos] == '(') {
      _pos++;
      final result = _parseExpression();
      if (_pos >= _expr.length || _expr[_pos] != ')') {
        if (_pos >= _expr.length) return result;
        throw FormatException('Missing )');
      }
      _pos++;
      return result;
    }

    if (_expr[_pos] == '-') {
      _pos++;
      return -_parseFactor();
    }

    return _parseNumber();
  }

  double _parseNumber() {
    final start = _pos;
    while (_pos < _expr.length &&
        (_expr[_pos] == '.' || (_expr.codeUnitAt(_pos) >= 48 && _expr.codeUnitAt(_pos) <= 57))) {
      _pos++;
    }
    if (start == _pos) throw FormatException('Expected number');
    return double.parse(_expr.substring(start, _pos));
  }
}