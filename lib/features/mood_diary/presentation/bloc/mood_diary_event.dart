part of 'mood_diary_bloc.dart';

@freezed
abstract class MoodDiaryEvent with _$MoodDiaryEvent {
  const factory MoodDiaryEvent.loadEntries() = _LoadEntries;
  const factory MoodDiaryEvent.selectMood(MoodType moodType) = _SelectMood;
  const factory MoodDiaryEvent.toggleSubEmotion(String emotion) = _ToggleSubEmotion;
  const factory MoodDiaryEvent.updateStressLevel(int level) = _UpdateStressLevel;
  const factory MoodDiaryEvent.updateSelfEsteem(int level) = _UpdateSelfEsteem;
  const factory MoodDiaryEvent.updateNote(String note) = _UpdateNote;
  const factory MoodDiaryEvent.updateDateTime(DateTime dateTime) = _UpdateDateTime;
  const factory MoodDiaryEvent.saveEntry() = _SaveEntry;
  const factory MoodDiaryEvent.resetForm() = _ResetForm;
  const factory MoodDiaryEvent.switchTab(int tabIndex) = _SwitchTab;
  const factory MoodDiaryEvent.deleteEntry(String id) = _DeleteEntry;
  const factory MoodDiaryEvent.startEditEntry(MoodEntry entry) = _StartEditEntry;
  const factory MoodDiaryEvent.updateEntry() = _UpdateEntry;
  const factory MoodDiaryEvent.cancelEdit() = _CancelEdit;
}
