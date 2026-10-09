import 'package:flutter/material.dart';
import '../skins/skin_interface.dart';
import '../skins/skin_animation_config.dart';

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
    final hasAnim = skin.animationConfig.type != AnimationType.none;
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
                    color: skin.primaryColor.withOpacity(0.4),
                    blurRadius: 16,
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
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: skin.primaryColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(skin.icon, color: skin.primaryColor, size: 24),
                ),
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
                          color: skin.appBarFg.withOpacity(0.95),
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
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: skin.primaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.check, color: Colors.white, size: 18),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            if (hasAnim) ...[
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      skin.primaryColor.withOpacity(0.2),
                      skin.primaryColor.withOpacity(0.05),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: skin.primaryColor.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.play_circle_filled,
                        color: skin.primaryColor, size: 14),
                    const SizedBox(width: 4),
                    Flexible(
                      child: Text(
                        skin.animationLabel,
                        style: TextStyle(
                          fontSize: 11,
                          color: skin.primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
            ] else
              const SizedBox(height: 6),
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
    return Expanded(
      child: Container(
        height: 32,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              bg,
              Color.alphaBlend(
                fg.withOpacity(0.08),
                bg,
              ),
            ],
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.center,
        child: Text(label,
            style: TextStyle(color: fg, fontSize: 12, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
