import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/constants/mood_types.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class MoodSelector extends StatelessWidget {
  final MoodType? selectedMood;
  final ValueChanged<MoodType> onMoodSelected;

  const MoodSelector({super.key, required this.selectedMood, required this.onMoodSelected});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: MoodType.values.map((mood) {
          final isSelected = selectedMood == mood;
          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: GestureDetector(
              onTap: () => onMoodSelected(mood),
              child: Column(
                children: [
                  Container(
                    width: 83,
                    height: 118,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(76),
                      border: isSelected
                          ? Border.all(color: AppColors.selectedMoodBorder, width: 2)
                          : null,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Image.asset(mood.iconPath),
                        ),
                        Text(
                          mood.label,
                          style: AppTextStyles.moodLabel.copyWith(color: AppColors.textColor),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
