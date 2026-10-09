import 'package:flutter/material.dart';
import '../services/currency_service.dart';

class CurrencyConverter extends StatefulWidget {
  const CurrencyConverter({super.key});

  @override
  State<CurrencyConverter> createState() => _CurrencyConverterState();
}

class _CurrencyConverterState extends State<CurrencyConverter> {
  CurrencyService? _service;
  String _fromCurrency = 'USD';
  String _toCurrency = 'CNY';
  String _amount = '1';
  String _result = '';
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _initService();
  }

  Future<void> _initService() async {
    setState(() => _isLoading = true);
    final service = await CurrencyService.create(baseCurrency: 'USD');
    if (service.hasData) {
      setState(() {
        _service = service;
        _isLoading = false;
        _convert();
      });
    } else {
      setState(() {
        _error = '无法获取汇率数据，请检查网络连接';
        _isLoading = false;
      });
    }
  }

  void _convert() {
    if (_service == null) return;
    final amount = double.tryParse(_amount);
    if (amount == null) {
      setState(() => _result = '请输入有效金额');
      return;
    }
    final converted = _service!.convert(amount, _fromCurrency, _toCurrency);
    if (converted == null) {
      setState(() => _result = '汇率数据不完整');
      return;
    }
    setState(() {
      if (converted.abs() < 0.01) {
        _result = converted.toStringAsPrecision(4);
      } else {
        _result = converted.toStringAsFixed(2);
      }
    });
  }

  void _swapCurrencies() {
    setState(() {
      final temp = _fromCurrency;
      _fromCurrency = _toCurrency;
      _toCurrency = temp;
      _convert();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (_isLoading) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 16),
            Text('正在获取汇率数据...', style: TextStyle(color: theme.colorScheme.onSurface)),
          ],
        ),
      );
    }

    if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.wifi_off, size: 48, color: theme.colorScheme.error),
            const SizedBox(height: 16),
            Text(_error!, style: TextStyle(color: theme.colorScheme.error)),
            const SizedBox(height: 16),
            ElevatedButton(onPressed: _initService, child: const Text('重试')),
          ],
        ),
      );
    }

    final currencies = CurrencyService.supportedCurrencies;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerHighest.withOpacity(0.3),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Text('金额', style: TextStyle(color: theme.colorScheme.onSurface.withOpacity(0.7), fontSize: 14)),
                const SizedBox(height: 8),
                TextField(
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.w300, color: theme.colorScheme.onSurface),
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(border: InputBorder.none, hintText: '0'),
                  onChanged: (v) {
                    _amount = v;
                    _convert();
                  },
                  controller: TextEditingController(text: _amount),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(child: _buildCurrencyPicker(currencies, _fromCurrency, (v) {
                setState(() { _fromCurrency = v!; _convert(); });
              })),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: IconButton(
                  icon: Icon(Icons.swap_horiz, color: theme.colorScheme.primary, size: 32),
                  onPressed: _swapCurrencies,
                ),
              ),
              Expanded(child: _buildCurrencyPicker(currencies, _toCurrency, (v) {
                setState(() { _toCurrency = v!; _convert(); });
              })),
            ],
          ),
          const SizedBox(height: 24),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [theme.colorScheme.primary, theme.colorScheme.primary.withOpacity(0.7)],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Text(
                  '$_amount ${_service!.getCurrencyName(_fromCurrency)} =',
                  style: TextStyle(color: theme.colorScheme.onPrimary.withOpacity(0.8), fontSize: 14),
                ),
                const SizedBox(height: 4),
                Text(
                  _result,
                  style: TextStyle(
                    color: theme.colorScheme.onPrimary,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${_service!.getCurrencyName(_toCurrency)}',
                  style: TextStyle(color: theme.colorScheme.onPrimary.withOpacity(0.8), fontSize: 14),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Text(
            _service!.lastFetch != null
                ? '汇率更新于: ${_service!.lastFetch!.toString().substring(0, 19)}'
                : '',
            style: TextStyle(color: theme.colorScheme.onSurface.withOpacity(0.4), fontSize: 11),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrencyPicker(List<String> currencies, String value, ValueChanged<String?> onChanged) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          dropdownColor: theme.colorScheme.surface,
          style: TextStyle(color: theme.colorScheme.onSurface, fontSize: 16),
          items: currencies.map((c) => DropdownMenuItem(value: c, child: Text('$c ${_service!.getCurrencyName(c)}'))).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}