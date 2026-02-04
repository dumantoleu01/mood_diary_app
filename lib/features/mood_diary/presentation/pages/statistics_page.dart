import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/mood_types.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../bloc/mood_diary_bloc.dart';

class StatisticsPage extends StatelessWidget {
  const StatisticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoodDiaryBloc, MoodDiaryState>(
      builder: (context, state) {
        if (state.entries.isEmpty) {
          return _buildEmptyState();
        }
        return _buildStatistics(context, state);
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.bar_chart,
              size: 64,
              color: AppColors.hintTextColor.withValues(alpha: 0.5),
            ),
            const SizedBox(height: 16),
            Text(
              'Пока нет записей',
              style: AppTextStyles.heading,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Добавьте первую запись в дневник настроения, чтобы увидеть статистику',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.hintTextColor,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatistics(BuildContext context, MoodDiaryState state) {
    final moodCounts = <MoodType, int>{};
    for (final entry in state.entries) {
      moodCounts[entry.moodType] = (moodCounts[entry.moodType] ?? 0) + 1;
    }

    final averageStress = state.entries.isEmpty
        ? 0.0
        : state.entries.map((e) => e.stressLevel).reduce((a, b) => a + b) /
            state.entries.length;

    final averageSelfEsteem = state.entries.isEmpty
        ? 0.0
        : state.entries.map((e) => e.selfEsteem).reduce((a, b) => a + b) /
            state.entries.length;

    final mostFrequentMood = moodCounts.entries.isEmpty
        ? null
        : moodCounts.entries.reduce((a, b) => a.value > b.value ? a : b).key;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Общая статистика', style: AppTextStyles.heading),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  'Всего записей',
                  '${state.entries.length}',
                  Icons.edit_note,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildStatCard(
                  'Частое настроение',
                  mostFrequentMood?.label ?? '-',
                  Icons.emoji_emotions_outlined,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  'Ср. стресс',
                  '${averageStress.toStringAsFixed(0)}%',
                  Icons.trending_up,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildStatCard(
                  'Ср. самооценка',
                  '${averageSelfEsteem.toStringAsFixed(0)}%',
                  Icons.psychology,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text('Распределение настроений', style: AppTextStyles.heading),
          const SizedBox(height: 16),
          _buildMoodChart(moodCounts, state.entries.length),
          const SizedBox(height: 24),
          Text('Детальная статистика', style: AppTextStyles.heading),
          const SizedBox(height: 16),
          _buildMoodDistribution(moodCounts, state.entries.length),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(13),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1CB6A1C0),
            blurRadius: 10,
            offset: Offset(2, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.activeTab.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: AppColors.activeTab, size: 20),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.hintTextColor,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: AppTextStyles.heading.copyWith(
              color: AppColors.activeTab,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMoodChart(Map<MoodType, int> counts, int total) {
    if (total == 0) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(13),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1CB6A1C0),
            blurRadius: 10,
            offset: Offset(2, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          SizedBox(
            height: 150,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: MoodType.values.map((mood) {
                final count = counts[mood] ?? 0;
                final percentage = total > 0 ? count / total : 0.0;
                final barHeight = 100 * percentage;

                return Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      count > 0 ? '$count' : '',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.activeTab,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      width: 36,
                      height: barHeight > 0 ? barHeight : 4,
                      decoration: BoxDecoration(
                        color: count > 0
                            ? AppColors.activeTab
                            : AppColors.sliderInactive,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: 32,
                      height: 32,
                      child: Opacity(
                        opacity: count > 0 ? 1.0 : 0.5,
                        child: Image.asset(mood.iconPath),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMoodDistribution(Map<MoodType, int> counts, int total) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(13),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1CB6A1C0),
            blurRadius: 10,
            offset: Offset(2, 4),
          ),
        ],
      ),
      child: Column(
        children: MoodType.values.map((mood) {
          final count = counts[mood] ?? 0;
          final percentage = total > 0 ? count / total : 0.0;
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: [
                SizedBox(
                  width: 32,
                  height: 32,
                  child: Image.asset(mood.iconPath),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(mood.label, style: AppTextStyles.bodySmall),
                          Text(
                            '$count (${(percentage * 100).toStringAsFixed(0)}%)',
                            style: AppTextStyles.bodySmall.copyWith(
                              color: AppColors.hintTextColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(2),
                        child: LinearProgressIndicator(
                          value: percentage,
                          backgroundColor: AppColors.passiveTab,
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            AppColors.activeTab,
                          ),
                          minHeight: 6,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
