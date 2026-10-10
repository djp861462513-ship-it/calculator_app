import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../skins/skin_manager.dart';
import '../widgets/animated_background.dart';
import '../widgets/firework_overlay.dart';
import 'basic_calculator.dart';
import 'scientific_calculator.dart';
import 'currency_converter.dart';
import 'unit_converter.dart';
import 'skin_picker.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  bool _isScientific = false;
  final GlobalKey<FireworkOverlayState> _fireworkKey = GlobalKey();

  void _toggleCalculatorMode() {
    setState(() => _isScientific = !_isScientific);
  }

  void _triggerFirework(Offset position) {
    _fireworkKey.currentState?.triggerFirework(position);
  }

  @override
  Widget build(BuildContext context) {
    final skinManager = context.watch<SkinManager>();
    final skin = skinManager.currentSkin;

    final pages = <Widget>[
      _isScientific
          ? ScientificCalculator(onSwitchToBasic: _toggleCalculatorMode)
          : BasicCalculator(onSwitchToScientific: _toggleCalculatorMode, onFirework: _triggerFirework),
      const CurrencyConverter(),
      const UnitConverter(),
      const SkinPicker(),
    ];

    final titles = ['计算器', '汇率换算', '单位换算', '皮肤'];

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: skin.appBarBg,
        foregroundColor: skin.appBarFg,
        elevation: 0,
        title: Text(
          _currentIndex == 0 && _isScientific ? '科学计算器' : titles[_currentIndex],
          style: TextStyle(fontWeight: FontWeight.w600, color: skin.appBarFg),
        ),
        actions: [
          if (_currentIndex == 0)
            IconButton(
              icon: Icon(_isScientific ? Icons.calculate : Icons.science),
              tooltip: _isScientific ? '切换到基础模式' : '切换到科学模式',
              onPressed: _toggleCalculatorMode,
            ),
        ],
      ),
      extendBodyBehindAppBar: false,
      body: AnimatedBackground(
        config: skin.animationConfig,
        baseColor: skin.backgroundColor,
        child: FireworkOverlay(
          key: _fireworkKey,
          colors: skin.animationConfig.particleColors.isNotEmpty
              ? skin.animationConfig.particleColors
              : [skin.primaryColor],
          child: Container(
            decoration: BoxDecoration(
              gradient: skin.backgroundGradient,
              color: skin.backgroundGradient == null ? skin.backgroundColor : null,
            ),
            child: IndexedStack(
              index: _currentIndex,
              children: pages,
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: skin.navbarBg,
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -2)),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(Icons.calculate, '计算', 0, skin),
                _buildNavItem(Icons.currency_exchange, '汇率', 1, skin),
                _buildNavItem(Icons.straighten, '换算', 2, skin),
                _buildNavItem(Icons.palette, '皮肤', 3, skin),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index, dynamic skin) {
    final selected = index == _currentIndex;
    return GestureDetector(
      onTap: () => setState(() => _currentIndex = index),
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 72,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: selected ? skin.navbarSelectedFg : skin.navbarUnselectedFg,
              size: selected ? 26 : 24,
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                color: selected ? skin.navbarSelectedFg : skin.navbarUnselectedFg,
                fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
