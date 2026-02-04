part of 'mood_diary_bloc.dart';

@freezed
abstract class MoodDiaryState with _$MoodDiaryState {
  const factory MoodDiaryState({
    @Default([]) List<MoodEntry> entries,
    MoodType? selectedMood,
    @Default([]) List<String> selectedSubEmotions,
    @Default(50) int stressLevel,
    @Default(50) int selfEsteem,
    @Default('') String note,
    DateTime? selectedDateTime,
    @Default(false) bool isLoading,
    @Default(false) bool isSaving,
    @Default(false) bool isSaved,
    String? errorMessage,
    @Default(0) int currentTabIndex,
    String? editingEntryId,
    @Default(false) bool isEditing,
  }) = _MoodDiaryState;
}

extension MoodDiaryStateX on MoodDiaryState {
  bool get isFormValid {
    return selectedMood != null &&
        selectedSubEmotions.isNotEmpty &&
        note.isNotEmpty;
  }
}
