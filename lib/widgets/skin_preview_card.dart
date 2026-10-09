import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../skins/skin_interface.dart';
import '../skins/skin_manager.dart';

class SkinPreviewCard extends StatelessWidget {
  final CalculatorSkin skin;
  final bool isSelected;
  final VoidCallback onTap;

  const SkinPreviewCard({
    super.key,
    required this.skin,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: skin.backgroundGradient,
          color: skin.backgroundGradient == null ? skin.backgroundColor : null,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? skin.primaryColor : Colors.transparent,
            width: 3,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: skin.primaryColor.withOpacity(0.3),
                    blurRadius: 12,
                    spreadRadius: 2,
                  )
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  )
                ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(skin.icon, color: skin.primaryColor, size: 28),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        skin.name,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: skin.appBarFg.withOpacity(0.9),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        skin.description,
                        style: TextStyle(
                          fontSize: 12,
                          color: skin.expressionTextColor,
                        ),
                      ),
                    ],
                  ),
                ),
                if (isSelected)
                  Icon(Icons.check_circle, color: skin.primaryColor, size: 28),
              ],
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                _buildSwatch(skin.numberButtonBg, skin.numberButtonFg, '123'),
                const SizedBox(width: 6),
                _buildSwatch(skin.operatorButtonBg, skin.operatorButtonFg, '÷'),
                const SizedBox(width: 6),
                _buildSwatch(skin.functionButtonBg, skin.functionButtonFg, '√'),
                const SizedBox(width: 6),
                _buildSwatch(skin.equalsButtonBg, skin.equalsButtonFg, '='),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSwatch(Color bg, Color fg, String label) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
      ),
      alignment: Alignment.center,
      child: Text(label, style: TextStyle(color: fg, fontSize: 12, fontWeight: FontWeight.bold)),
    );
  }
}