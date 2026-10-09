import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'skins/skin_manager.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final skinManager = SkinManager();
  final savedSkin = prefs.getString('active_skin');
  if (savedSkin != null) {
    skinManager.setSkinByName(savedSkin);
  }

  runApp(
    ChangeNotifierProvider.value(
      value: skinManager,
      child: const CalculatorApp(),
    ),
  );
}