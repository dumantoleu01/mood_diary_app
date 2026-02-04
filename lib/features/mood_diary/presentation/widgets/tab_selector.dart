import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class TabSelector extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTabSelected;

  const TabSelector({
    super.key,
    required this.selectedIndex,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.passiveTab,
        borderRadius: BorderRadius.circular(25),
      ),
      padding: const EdgeInsets.all(4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildTab(
            index: 0,
            label: 'Дневник настроения',
            iconPath: 'assets/icons/book.svg',
          ),
          _buildTab(
            index: 1,
            label: 'Статистика',
            iconPath: 'assets/icons/statistics.svg',
            isChart: true,
          ),
        ],
      ),
    );
  }

  Widget _buildTab({
    required int index,
    required String label,
    required String iconPath,
    bool isChart = false,
  }) {
    final isSelected = selectedIndex == index;
    return GestureDetector(
      onTap: () => onTabSelected(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.activeTab : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isChart)
              Icon(
                Icons.bar_chart,
                size: 18,
                color: isSelected ? AppColors.white : AppColors.hintTextColor,
              )
            else
              SvgPicture.asset(
                iconPath,
                width: 18,
                height: 18,
                colorFilter: ColorFilter.mode(
                  isSelected ? AppColors.white : AppColors.hintTextColor,
                  BlendMode.srcIn,
                ),
              ),
            const SizedBox(width: 8),
            Text(
              label,
              style: isSelected
                  ? AppTextStyles.tabActive
                  : AppTextStyles.tabInactive,
            ),
          ],
        ),
      ),
    );
  }
}
