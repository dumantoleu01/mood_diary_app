import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';
import '../../../../core/constants/mood_types.dart';
import '../../domain/entities/mood_entry.dart';
import '../../domain/usecases/delete_mood_entry.dart';
import '../../domain/usecases/get_all_entries.dart';
import '../../domain/usecases/save_mood_entry.dart';

part 'mood_diary_event.dart';
part 'mood_diary_state.dart';
part 'mood_diary_bloc.freezed.dart';

@injectable
class MoodDiaryBloc extends Bloc<MoodDiaryEvent, MoodDiaryState> {
  final GetAllEntries _getAllEntries;
  final SaveMoodEntry _saveMoodEntry;
  final DeleteMoodEntry _deleteMoodEntry;
  final Uuid _uuid;

  MoodDiaryBloc(
    this._getAllEntries,
    this._saveMoodEntry,
    this._deleteMoodEntry,
  )   : _uuid = const Uuid(),
        super(MoodDiaryState(selectedDateTime: DateTime.now())) {
    on<_LoadEntries>(_onLoadEntries);
    on<_SelectMood>(_onSelectMood);
    on<_ToggleSubEmotion>(_onToggleSubEmotion);
    on<_UpdateStressLevel>(_onUpdateStressLevel);
    on<_UpdateSelfEsteem>(_onUpdateSelfEsteem);
    on<_UpdateNote>(_onUpdateNote);
    on<_UpdateDateTime>(_onUpdateDateTime);
    on<_SaveEntry>(_onSaveEntry);
    on<_ResetForm>(_onResetForm);
    on<_SwitchTab>(_onSwitchTab);
    on<_DeleteEntry>(_onDeleteEntry);
    on<_StartEditEntry>(_onStartEditEntry);
    on<_UpdateEntry>(_onUpdateEntry);
    on<_CancelEdit>(_onCancelEdit);
  }

  Future<void> _onLoadEntries(
    _LoadEntries event,
    Emitter<MoodDiaryState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      final entries = await _getAllEntries();
      emit(state.copyWith(entries: entries, isLoading: false));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to load entries',
      ));
    }
  }

  void _onSelectMood(_SelectMood event, Emitter<MoodDiaryState> emit) {
    emit(state.copyWith(
      selectedMood: event.moodType,
      selectedSubEmotions: [],
      isSaved: false,
    ));
  }

  void _onToggleSubEmotion(
    _ToggleSubEmotion event,
    Emitter<MoodDiaryState> emit,
  ) {
    final currentEmotions = List<String>.from(state.selectedSubEmotions);
    if (currentEmotions.contains(event.emotion)) {
      currentEmotions.remove(event.emotion);
    } else {
      currentEmotions.add(event.emotion);
    }
    emit(state.copyWith(selectedSubEmotions: currentEmotions, isSaved: false));
  }

  void _onUpdateStressLevel(
    _UpdateStressLevel event,
    Emitter<MoodDiaryState> emit,
  ) {
    emit(state.copyWith(stressLevel: event.level, isSaved: false));
  }

  void _onUpdateSelfEsteem(
    _UpdateSelfEsteem event,
    Emitter<MoodDiaryState> emit,
  ) {
    emit(state.copyWith(selfEsteem: event.level, isSaved: false));
  }

  void _onUpdateNote(_UpdateNote event, Emitter<MoodDiaryState> emit) {
    emit(state.copyWith(note: event.note, isSaved: false));
  }

  void _onUpdateDateTime(_UpdateDateTime event, Emitter<MoodDiaryState> emit) {
    emit(state.copyWith(selectedDateTime: event.dateTime, isSaved: false));
  }

  Future<void> _onSaveEntry(
    _SaveEntry event,
    Emitter<MoodDiaryState> emit,
  ) async {
    if (!state.isFormValid || state.selectedMood == null) return;

    emit(state.copyWith(isSaving: true, errorMessage: null));
    try {
      final entry = MoodEntry(
        id: _uuid.v4(),
        dateTime: state.selectedDateTime ?? DateTime.now(),
        moodType: state.selectedMood!,
        subEmotions: state.selectedSubEmotions,
        stressLevel: state.stressLevel,
        selfEsteem: state.selfEsteem,
        note: state.note,
      );
      await _saveMoodEntry(entry);
      final entries = await _getAllEntries();
      emit(state.copyWith(
        isSaving: false,
        isSaved: true,
        entries: entries,
      ));
    } catch (e) {
      emit(state.copyWith(
        isSaving: false,
        errorMessage: 'Failed to save entry',
      ));
    }
  }

  void _onResetForm(_ResetForm event, Emitter<MoodDiaryState> emit) {
    emit(MoodDiaryState(
      entries: state.entries,
      selectedDateTime: DateTime.now(),
    ));
  }

  void _onSwitchTab(_SwitchTab event, Emitter<MoodDiaryState> emit) {
    emit(state.copyWith(currentTabIndex: event.tabIndex));
  }

  Future<void> _onDeleteEntry(
    _DeleteEntry event,
    Emitter<MoodDiaryState> emit,
  ) async {
    try {
      await _deleteMoodEntry(event.id);
      final entries = await _getAllEntries();
      emit(state.copyWith(entries: entries));
    } catch (e) {
      emit(state.copyWith(errorMessage: 'Failed to delete entry'));
    }
  }

  void _onStartEditEntry(
    _StartEditEntry event,
    Emitter<MoodDiaryState> emit,
  ) {
    emit(state.copyWith(
      isEditing: true,
      editingEntryId: event.entry.id,
      selectedMood: event.entry.moodType,
      selectedSubEmotions: event.entry.subEmotions,
      stressLevel: event.entry.stressLevel,
      selfEsteem: event.entry.selfEsteem,
      note: event.entry.note,
      selectedDateTime: event.entry.dateTime,
      isSaved: false,
    ));
  }

  Future<void> _onUpdateEntry(
    _UpdateEntry event,
    Emitter<MoodDiaryState> emit,
  ) async {
    if (!state.isFormValid || state.selectedMood == null || state.editingEntryId == null) return;

    emit(state.copyWith(isSaving: true, errorMessage: null));
    try {
      final entry = MoodEntry(
        id: state.editingEntryId!,
        dateTime: state.selectedDateTime ?? DateTime.now(),
        moodType: state.selectedMood!,
        subEmotions: state.selectedSubEmotions,
        stressLevel: state.stressLevel,
        selfEsteem: state.selfEsteem,
        note: state.note,
      );
      await _saveMoodEntry(entry);
      final entries = await _getAllEntries();
      emit(MoodDiaryState(
        entries: entries,
        selectedDateTime: DateTime.now(),
        isSaved: true,
      ));
    } catch (e) {
      emit(state.copyWith(
        isSaving: false,
        errorMessage: 'Failed to update entry',
      ));
    }
  }

  void _onCancelEdit(_CancelEdit event, Emitter<MoodDiaryState> emit) {
    emit(MoodDiaryState(
      entries: state.entries,
      selectedDateTime: DateTime.now(),
    ));
  }
}
