import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/mood_types.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../bloc/mood_diary_bloc.dart';
import '../widgets/custom_slider.dart';
import '../widgets/mood_selector.dart';
import '../widgets/sub_emotion_chips.dart';

class MoodDiaryPage extends StatefulWidget {
  const MoodDiaryPage({super.key});

  @override
  State<MoodDiaryPage> createState() => _MoodDiaryPageState();
}

class _MoodDiaryPageState extends State<MoodDiaryPage> {
  final TextEditingController _noteController = TextEditingController();

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MoodDiaryBloc, MoodDiaryState>(
      listener: (context, state) {
        if (state.isEditing && _noteController.text != state.note) {
          _noteController.text = state.note;
        }
        if (!state.isEditing && state.note.isEmpty && _noteController.text.isNotEmpty) {
          _noteController.clear();
        }
      },
      builder: (context, state) {
        return Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Что чувствуешь?', style: AppTextStyles.heading),
                    const SizedBox(height: 16),
                    MoodSelector(
                      selectedMood: state.selectedMood,
                      onMoodSelected: (mood) {
                        context.read<MoodDiaryBloc>().add(MoodDiaryEvent.selectMood(mood));
                      },
                    ),
                    if (state.selectedMood != null) ...[
                      const SizedBox(height: 16),
                      SubEmotionChips(
                        emotions: state.selectedMood!.subEmotions,
                        selectedEmotions: state.selectedSubEmotions,
                        onEmotionToggled: (emotion) {
                          context.read<MoodDiaryBloc>().add(
                            MoodDiaryEvent.toggleSubEmotion(emotion),
                          );
                        },
                      ),
                    ],
                    const SizedBox(height: 36),
                    CustomSlider(
                      title: 'Уровень стресса',
                      leftLabel: 'Низкий',
                      rightLabel: 'Высокий',
                      value: state.stressLevel,
                      onChanged: (value) {
                        context.read<MoodDiaryBloc>().add(MoodDiaryEvent.updateStressLevel(value));
                      },
                    ),
                    const SizedBox(height: 24),
                    CustomSlider(
                      title: 'Самооценка',
                      leftLabel: 'Неуверенность',
                      rightLabel: 'Уверенность',
                      value: state.selfEsteem,
                      onChanged: (value) {
                        context.read<MoodDiaryBloc>().add(MoodDiaryEvent.updateSelfEsteem(value));
                      },
                    ),
                    const SizedBox(height: 24),
                    Text('Заметки', style: AppTextStyles.heading),
                    const SizedBox(height: 12),
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(13),
                        boxShadow: const [
                          BoxShadow(color: Color(0x1CB6A1C0), blurRadius: 10, offset: Offset(2, 4)),
                        ],
                      ),
                      child: TextField(
                        controller: _noteController,
                        onChanged: (value) {
                          context.read<MoodDiaryBloc>().add(MoodDiaryEvent.updateNote(value));
                        },
                        maxLines: 4,
                        decoration: InputDecoration(
                          hintText: 'Введите заметку',
                          filled: true,
                          fillColor: AppColors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(13),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        style: AppTextStyles.bodyMedium,
                      ),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: state.isFormValid && !state.isSaving
                            ? () {
                                if (state.isEditing) {
                                  context.read<MoodDiaryBloc>().add(
                                    const MoodDiaryEvent.updateEntry(),
                                  );
                                } else {
                                  context.read<MoodDiaryBloc>().add(
                                    const MoodDiaryEvent.saveEntry(),
                                  );
                                }
                                _noteController.clear();
                              }
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: state.isFormValid
                              ? AppColors.activeTab
                              : AppColors.passiveTab,
                          foregroundColor: state.isFormValid
                              ? AppColors.white
                              : AppColors.hintTextColor,
                        ),
                        child: state.isSaving
                            ? const SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  color: AppColors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : Text(state.isEditing ? 'Обновить' : 'Сохранить'),
                      ),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
