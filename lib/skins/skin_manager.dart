import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'skin_interface.dart';
import 'themes/dopamine_skin.dart';
import 'themes/cyberpunk_skin.dart';
import 'themes/morandi_skin.dart';
import 'themes/nature_skin.dart';
import 'themes/classic_skin.dart';

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