import 'package:flutter/material.dart';
import '../services/unit_conversion_service.dart';

class UnitConverter extends StatefulWidget {
  const UnitConverter({super.key});

  @override
  State<UnitConverter> createState() => _UnitConverterState();
}

class _UnitConverterState extends State<UnitConverter> {
  String _selectedCategory = 'length';
  String _fromUnit = '米 (m)';
  String _toUnit = '千米 (km)';
  String _input = '1';
  String _result = '';

  @override
  void initState() {
    super.initState();
    _convert();
  }

  void _changeCategory(String cat) {
    setState(() {
      _selectedCategory = cat;
      final units = UnitConversionService.getUnits(cat);
      _fromUnit = units.first;
      _toUnit = units.length > 1 ? units[1] : units.first;
      _convert();
    });
  }

  void _convert() {
    final val = double.tryParse(_input);
    if (val == null) {
      setState(() => _result = 'Invalid');
      return;
    }
    final converted = UnitConversionService.convert(val, _fromUnit, _toUnit, _selectedCategory);
    if (converted == null) {
      setState(() => _result = 'Error');
      return;
    }
    setState(() {
      if (converted.abs() < 0.000001 && converted != 0) {
        _result = converted.toStringAsExponential(4);
      } else if (converted == converted.toInt()) {
        _result = converted.toInt().toString();
      } else {
        _result = converted.toStringAsFixed(6).replaceAll(RegExp(r'0+$'), '').replaceAll(RegExp(r'\.$'), '');
      }
    });
  }

  void _swapUnits() {
    setState(() {
      final temp = _fromUnit;
      _fromUnit = _toUnit;
      _toUnit = temp;
      _convert();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final categories = UnitConversionService.categories;
    final units = UnitConversionService.getUnits(_selectedCategory);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: categories.map((cat) {
                final isSelected = cat == _selectedCategory;
                final labels = {
                  'length': '长度', 'weight': '重量', 'temperature': '温度',
                  'area': '面积', 'volume': '体积', 'speed': '速度',
                };
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: ChoiceChip(
                    label: Text(labels[cat] ?? cat),
                    selected: isSelected,
                    onSelected: (_) => _changeCategory(cat),
                    selectedColor: theme.colorScheme.primary,
                    labelStyle: TextStyle(
                      color: isSelected ? theme.colorScheme.onPrimary : theme.colorScheme.onSurface,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerHighest.withOpacity(0.3),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Text('输入数值', style: TextStyle(color: theme.colorScheme.onSurface.withOpacity(0.7), fontSize: 14)),
                const SizedBox(height: 8),
                TextField(
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.w300, color: theme.colorScheme.onSurface),
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(border: InputBorder.none, hintText: '0'),
                  controller: TextEditingController(text: _input),
                  onChanged: (v) { _input = v; _convert(); },
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildUnitPicker(units, _fromUnit, (v) {
                  setState(() { _fromUnit = v!; _convert(); });
                }),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: IconButton(
                  icon: Icon(Icons.swap_vert, color: theme.colorScheme.primary, size: 32),
                  onPressed: _swapUnits,
                ),
              ),
              Expanded(
                child: _buildUnitPicker(units, _toUnit, (v) {
                  setState(() { _toUnit = v!; _convert(); });
                }),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [theme.colorScheme.primary, theme.colorScheme.primary.withOpacity(0.7)],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Text(
                  '$_input $_fromUnit =',
                  style: TextStyle(color: theme.colorScheme.onPrimary.withOpacity(0.8), fontSize: 14),
                ),
                const SizedBox(height: 4),
                Text(
                  _result,
                  style: TextStyle(color: theme.colorScheme.onPrimary, fontSize: 36, fontWeight: FontWeight.bold),
                ),
                Text(
                  _toUnit,
                  style: TextStyle(color: theme.colorScheme.onPrimary.withOpacity(0.8), fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUnitPicker(List<String> units, String value, ValueChanged<String?> onChanged) {
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
          items: units.map((u) => DropdownMenuItem(value: u, child: Text(u, overflow: TextOverflow.ellipsis))).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}