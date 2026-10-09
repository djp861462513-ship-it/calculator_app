import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../widgets/calculator_button.dart';
import '../widgets/display_widget.dart';

class ScientificCalculator extends StatefulWidget {
  final VoidCallback? onSwitchToBasic;

  const ScientificCalculator({super.key, this.onSwitchToBasic});

  @override
  State<ScientificCalculator> createState() => _ScientificCalculatorState();
}

class _ScientificCalculatorState extends State<ScientificCalculator> {
  String _expression = '';
  String _result = '0';
  bool _shouldReset = false;
  bool _isRad = true;

  String get angleMode => _isRad ? 'RAD' : 'DEG';

  void _onKeyTap(String key) {
    setState(() {
      if (_shouldReset) {
        _expression = '';
        _result = '0';
        _shouldReset = false;
      }
      _expression += key;
      _evaluate();
    });
  }

  void _onEquals() {
    setState(() {
      _evaluate(finalize: true);
      _shouldReset = true;
    });
  }

  void _onClear() {
    setState(() {
      _expression = '';
      _result = '0';
      _shouldReset = false;
    });
  }

  void _onDelete() {
    setState(() {
      if (_expression.isNotEmpty) {
        _expression = _expression.substring(0, _expression.length - 1);
        if (_expression.isEmpty) {
          _result = '0';
        } else {
          _evaluate();
        }
      }
    });
  }

  void _toggleMode() {
    setState(() {
      _isRad = !_isRad;
    });
  }

  void _evaluate({bool finalize = false}) {
    try {
      String expr = _expression
          .replaceAll('×', '*')
          .replaceAll('÷', '/')
          .replaceAll('π', '(${math.pi.toString()})')
          .replaceAll('e', '(${math.e.toString()})');
      if (expr.isEmpty) {
        _result = '0';
        return;
      }
      final evaluator = ScientificEvaluator(isRad: _isRad);
      final val = evaluator.evaluate(expr, finalize: finalize);
      if (val.isNaN || val.isInfinite) {
        _result = 'Error';
        return;
      }
      final absVal = val.abs();
      if (absVal < 1e12 && absVal > 1e-10) {
        if (val == val.toInt()) {
          _result = val.toInt().toString();
        } else {
          _result = val.toStringAsFixed(10).replaceAll(RegExp(r'0+$'), '').replaceAll(RegExp(r'\.$'), '');
        }
      } else if (absVal == 0) {
        _result = '0';
      } else {
        _result = val.toStringAsExponential(6);
      }
    } catch (_) {
      if (finalize) _result = 'Error';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CalculatorDisplay(expression: _expression, result: _result, height: 140),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 1),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(children: [
                    CalcButton(label: angleMode, type: ButtonType.function, onTap: _toggleMode),
                    CalcButton(label: '(', type: ButtonType.function, onTap: () => _onKeyTap('(')),
                    CalcButton(label: ')', type: ButtonType.function, onTap: () => _onKeyTap(')')),
                    CalcButton(label: 'AC', type: ButtonType.function, onTap: _onClear),
                    CalcButton(label: '⌫', type: ButtonType.function, onTap: _onDelete),
                  ]),
                  Row(children: [
                    CalcButton(label: 'sin', type: ButtonType.function, onTap: () => _onKeyTap('sin(')),
                    CalcButton(label: 'cos', type: ButtonType.function, onTap: () => _onKeyTap('cos(')),
                    CalcButton(label: 'tan', type: ButtonType.function, onTap: () => _onKeyTap('tan(')),
                    CalcButton(label: 'log', type: ButtonType.function, onTap: () => _onKeyTap('log(')),
                    CalcButton(label: 'ln', type: ButtonType.function, onTap: () => _onKeyTap('ln(')),
                  ]),
                  Row(children: [
                    CalcButton(label: '√', type: ButtonType.function, onTap: () => _onKeyTap('sqrt(')),
                    CalcButton(label: 'x²', type: ButtonType.function, onTap: () => _onKeyTap('^2')),
                    CalcButton(label: 'xʸ', type: ButtonType.function, onTap: () => _onKeyTap('^')),
                    CalcButton(label: 'x!', type: ButtonType.function, onTap: () => _onKeyTap('!')),
                    CalcButton(label: '1/x', type: ButtonType.function, onTap: () => _onKeyTap('1/(')),
                  ]),
                  Row(children: [
                    CalcButton(label: '7', type: ButtonType.number, onTap: () => _onKeyTap('7')),
                    CalcButton(label: '8', type: ButtonType.number, onTap: () => _onKeyTap('8')),
                    CalcButton(label: '9', type: ButtonType.number, onTap: () => _onKeyTap('9')),
                    CalcButton(label: '÷', type: ButtonType.operator, onTap: () => _onKeyTap('/')),
                    CalcButton(label: 'π', type: ButtonType.function, onTap: () => _onKeyTap('π')),
                  ]),
                  Row(children: [
                    CalcButton(label: '4', type: ButtonType.number, onTap: () => _onKeyTap('4')),
                    CalcButton(label: '5', type: ButtonType.number, onTap: () => _onKeyTap('5')),
                    CalcButton(label: '6', type: ButtonType.number, onTap: () => _onKeyTap('6')),
                    CalcButton(label: '×', type: ButtonType.operator, onTap: () => _onKeyTap('*')),
                    CalcButton(label: 'e', type: ButtonType.function, onTap: () => _onKeyTap('e')),
                  ]),
                  Row(children: [
                    CalcButton(label: '1', type: ButtonType.number, onTap: () => _onKeyTap('1')),
                    CalcButton(label: '2', type: ButtonType.number, onTap: () => _onKeyTap('2')),
                    CalcButton(label: '3', type: ButtonType.number, onTap: () => _onKeyTap('3')),
                    CalcButton(label: '-', type: ButtonType.operator, onTap: () => _onKeyTap('-')),
                    CalcButton(label: '%', type: ButtonType.function, onTap: () => _onKeyTap('%')),
                  ]),
                  Row(children: [
                    CalcButton(label: '.', type: ButtonType.number, onTap: () => _onKeyTap('.')),
                    CalcButton(label: '0', type: ButtonType.number, onTap: () => _onKeyTap('0')),
                    CalcButton(label: '±', type: ButtonType.function, onTap: () => _onKeyTap('negate')),
                    CalcButton(label: '+', type: ButtonType.operator, onTap: () => _onKeyTap('+')),
                    CalcButton(label: '=', type: ButtonType.equals, onTap: _onEquals),
                  ]),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ScientificEvaluator {
  final bool isRad;
  int _pos = 0;
  String _expr = '';

  ScientificEvaluator({this.isRad = true});

  double evaluate(String expr, {bool finalize = false}) {
    _expr = expr.replaceAll(' ', '');
    _pos = 0;
    final result = _parseExpression();
    if (finalize && _pos < _expr.length) throw FormatException('Unexpected');
    return result;
  }

  bool _match(String s) {
    if (_pos + s.length <= _expr.length && _expr.substring(_pos, _pos + s.length) == s) {
      _pos += s.length;
      return true;
    }
    return false;
  }

  double _parseExpression() {
    double left = _parseTerm();
    while (_pos < _expr.length) {
      if (_expr[_pos] == '+') { _pos++; left += _parseTerm(); }
      else if (_expr[_pos] == '-') { _pos++; left -= _parseTerm(); }
      else break;
    }
    return left;
  }

  double _parseTerm() {
    double left = _parsePower();
    while (_pos < _expr.length) {
      if (_expr[_pos] == '*') { _pos++; left *= _parsePower(); }
      else if (_expr[_pos] == '/') {
        _pos++;
        final d = _parsePower();
        if (d == 0) throw FormatException('/0');
        left /= d;
      }
      else if (_expr[_pos] == '%') { _pos++; left /= 100; }
      else break;
    }
    return left;
  }

  double _parsePower() {
    double left = _parseUnary();
    while (_pos < _expr.length && _expr[_pos] == '^') {
      _pos++;
      left = math.pow(left, _parseUnary()).toDouble();
    }
    return left;
  }

  double _parseUnary() {
    if (_pos >= _expr.length) throw FormatException('EOF');
    if (_expr[_pos] == '-') { _pos++; return -_parseUnary(); }
    if (_expr[_pos] == '+') { _pos++; return _parseUnary(); }
    return _parsePostfix(_parsePrimary());
  }

  double _parsePostfix(double val) {
    while (_pos < _expr.length && _expr[_pos] == '!') {
      _pos++;
      val = _factorial(val);
    }
    return val;
  }

  double _parsePrimary() {
    if (_pos >= _expr.length) throw FormatException('EOF');
    if (_expr[_pos] == '(') {
      _pos++;
      final r = _parseExpression();
      if (_pos < _expr.length && _expr[_pos] == ')') _pos++;
      return r;
    }
    for (final fn in ['sqrt', 'sin', 'cos', 'tan', 'log', 'ln']) {
      if (_match('$fn(')) {
        final arg = _parseExpression();
        if (_pos < _expr.length && _expr[_pos] == ')') _pos++;
        return _applyFn(fn, arg);
      }
    }
    if (_match('1/(')) {
      final arg = _parseExpression();
      if (_pos < _expr.length && _expr[_pos] == ')') _pos++;
      if (arg == 0) throw FormatException('/0');
      return 1 / arg;
    }
    return _parseNumber();
  }

  double _applyFn(String fn, double val) {
    switch (fn) {
      case 'sqrt': return math.sqrt(val);
      case 'sin': return math.sin(isRad ? val : val * math.pi / 180);
      case 'cos': return math.cos(isRad ? val : val * math.pi / 180);
      case 'tan': return math.tan(isRad ? val : val * math.pi / 180);
      case 'log': return math.log(val) / math.ln10;
      case 'ln': return math.log(val);
      default: throw FormatException('Unknown fn');
    }
  }

  double _factorial(double n) {
    if (n < 0 || n != n.toInt()) throw FormatException('! invalid');
    int x = n.toInt();
    double r = 1;
    for (int i = 2; i <= x; i++) r *= i;
   return r;
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