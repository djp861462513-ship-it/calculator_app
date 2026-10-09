import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'skins/skin_manager.dart';
import 'screens/main_screen.dart';

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SkinManager>(
      builder: (context, skinManager, child) {
        final skin = skinManager.currentSkin;
        return MaterialApp(
          title: 'SkinCalc',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: skin.primaryColor,
              brightness: skin.brightness,
            ),
            scaffoldBackgroundColor: skin.backgroundColor,
            useMaterial3: true,
          ),
          home: const MainScreen(),
        );
      },
    );
  }
}