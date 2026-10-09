import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../skins/skin_manager.dart';
import '../widgets/skin_preview_card.dart';

class SkinPicker extends StatelessWidget {
  const SkinPicker({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SkinManager>(
      builder: (context, skinManager, child) {
        final theme = Theme.of(context);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
              child: Text(
                '选择皮肤',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                '切换主题，让计算器焕然一新',
                style: TextStyle(color: theme.colorScheme.onSurface.withOpacity(0.6), fontSize: 14),
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.only(bottom: 20),
                itemCount: skinManager.skins.length,
                itemBuilder: (context, index) {
                  final skin = skinManager.skins[index];
                  return SkinPreviewCard(
                    skin: skin,
                    isSelected: skin.name == skinManager.currentSkin.name,
                    onTap: () => skinManager.setSkin(skin.id),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}