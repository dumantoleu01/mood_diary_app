import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../bloc/mood_diary_bloc.dart';
import '../widgets/date_time_picker.dart';
import '../widgets/success_dialog.dart';
import 'mood_diary_page.dart';
import 'statistics_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<MoodDiaryBloc, MoodDiaryState>(
      listener: (context, state) {
        if (state.isSaved) {
          SuccessDialog.show(
            context,
            onClose: () {
              context.read<MoodDiaryBloc>().add(const MoodDiaryEvent.resetForm());
              context.read<MoodDiaryBloc>().add(const MoodDiaryEvent.switchTab(0));
            },
          );
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: BlocBuilder<MoodDiaryBloc, MoodDiaryState>(
            builder: (context, state) {
              final currentIndex = state.currentTabIndex;

              return Column(
                children: [
                  const SizedBox(height: 12),
                  DateTimePicker(
                    selectedDateTime: state.selectedDateTime ?? DateTime.now(),
                    onDateTimeChanged: (dateTime) {
                      context.read<MoodDiaryBloc>().add(MoodDiaryEvent.updateDateTime(dateTime));
                    },
                  ),
                  const SizedBox(height: 24),
                  _TabSwitcher(
                    currentIndex: currentIndex,
                    onChanged: (index) =>
                        context.read<MoodDiaryBloc>().add(MoodDiaryEvent.switchTab(index)),
                  ),
                  const SizedBox(height: 30),
                  Expanded(
                    child: IndexedStack(
                      index: currentIndex,
                      children: const [MoodDiaryPage(), StatisticsPage()],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _TabSwitcher extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onChanged;

  const _TabSwitcher({required this.currentIndex, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final tabWidthLeft = screenWidth * 0.50;
    final tabWidthRight = screenWidth * 0.40;
    final overlap = screenWidth * 0.05;

    final isFirstActive = currentIndex == 0;

    Widget leftTab({required bool active}) => Align(
      alignment: Alignment.centerLeft,
      child: Transform.translate(
        offset: Offset(overlap, 0),
        child: SizedBox(
          width: tabWidthLeft,
          child: _TabButton(
            label: 'Дневник настроения',
            icon: 'book',
            isActive: active,
            onTap: () => onChanged(0),
          ),
        ),
      ),
    );

    Widget rightTab({required bool active}) => Align(
      alignment: Alignment.centerRight,
      child: Transform.translate(
        offset: Offset(-overlap, 0),
        child: SizedBox(
          width: tabWidthRight,
          child: _TabButton(
            label: 'Статистика',
            icon: 'statistics',
            isActive: active,
            onTap: () => onChanged(1),
          ),
        ),
      ),
    );

    final bottom = isFirstActive ? rightTab(active: false) : leftTab(active: false);
    final top = isFirstActive ? leftTab(active: true) : rightTab(active: true);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SizedBox(child: Stack(children: [bottom, top])),
    );
  }
}

class _TabButton extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;
  final String icon;

  const _TabButton({
    required this.label,
    required this.isActive,
    required this.onTap,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 9),
        decoration: BoxDecoration(
          color: isActive ? AppColors.activeTab : Color(0xFFF2F2F2),
          borderRadius: BorderRadius.circular(50),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/icons/$icon.svg',
              width: 12,
              height: 12,
              colorFilter: ColorFilter.mode(
                isActive ? AppColors.white : AppColors.textColor,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(width: 6),
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.bodyMedium.copyWith(
                color: isActive ? AppColors.white : AppColors.textColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
