import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'skin_interface.dart';
import 'themes/dopamine_skin.dart';
import 'themes/cyberpunk_skin.dart';
import 'themes/morandi_skin.dart';
import 'themes/nature_skin.dart';
import 'themes/classic_skin.dart';
import 'themes/aurora_skin.dart';
import 'themes/galaxy_skin.dart';
import 'themes/lava_skin.dart';
import 'themes/ink_skin.dart';
import 'themes/rainbow_skin.dart';
import 'themes/black_gold_skin.dart';
import 'themes/firework_skin.dart';
import 'themes/diamond_skin.dart';
import 'themes/sakura_skin.dart';
import 'themes/ocean_skin.dart';
import 'themes/neon_skin.dart';
import 'themes/stardust_skin.dart';

class SkinManager extends ChangeNotifier {
  final List<CalculatorSkin> _skins = [];
  CalculatorSkin _currentSkin = const DopamineSkin();

  SkinManager() {
    _registerBuiltInSkins();
  }

  void _registerBuiltInSkins() {
    _skins.add(const DopamineSkin());
    _skins.add(const CyberpunkSkin());
    _skins.add(const MorandiSkin());
    _skins.add(const NatureSkin());
    _skins.add(const ClassicSkin());
    _skins.add(const AuroraSkin());
    _skins.add(const GalaxySkin());
    _skins.add(const LavaSkin());
    _skins.add(const InkSkin());
    _skins.add(const RainbowSkin());
    _skins.add(const BlackGoldSkin());
    _skins.add(const FireworkSkin());
    _skins.add(const DiamondSkin());
    _skins.add(const SakuraSkin());
    _skins.add(const OceanSkin());
    _skins.add(const NeonSkin());
    _skins.add(const StardustSkin());
  }

  void registerSkin(CalculatorSkin skin) {
    _skins.add(skin);
    notifyListeners();
  }

  void setSkinByName(String name) {
    for (final s in _skins) {
      if (s.name == name) {
        _currentSkin = s;
        _savePreference(name);
        notifyListeners();
        return;
      }
    }
  }

  void setSkin(String id) {
    for (final s in _skins) {
      if (s.id == id) {
        _currentSkin = s;
        _savePreference(s.name);
        notifyListeners();
        return;
      }
    }
  }

  Future<void> _savePreference(String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('active_skin', name);
  }

  CalculatorSkin get currentSkin => _currentSkin;
  List<CalculatorSkin> get skins => List.unmodifiable(_skins);
}