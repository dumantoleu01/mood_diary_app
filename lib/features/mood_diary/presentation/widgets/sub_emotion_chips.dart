import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class SubEmotionChips extends StatelessWidget {
  final List<String> emotions;
  final List<String> selectedEmotions;
  final ValueChanged<String> onEmotionToggled;

  const SubEmotionChips({
    super.key,
    required this.emotions,
    required this.selectedEmotions,
    required this.onEmotionToggled,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: emotions.map((emotion) {
        final isSelected = selectedEmotions.contains(emotion);
        return GestureDetector(
          onTap: () => onEmotionToggled(emotion),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.activeTab : AppColors.passiveTab,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              emotion,
              style: isSelected
                  ? AppTextStyles.chipSelected
                  : AppTextStyles.chipUnselected,
            ),
          ),
        );
      }).toList(),
    );
  }
}
