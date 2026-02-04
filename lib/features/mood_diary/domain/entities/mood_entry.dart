import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../core/constants/mood_types.dart';

part 'mood_entry.freezed.dart';
part 'mood_entry.g.dart';

@freezed
abstract class MoodEntry with _$MoodEntry {
  const factory MoodEntry({
    required String id,
    required DateTime dateTime,
    required MoodType moodType,
    required List<String> subEmotions,
    required int stressLevel,
    required int selfEsteem,
    required String note,
  }) = _MoodEntry;

  factory MoodEntry.fromJson(Map<String, dynamic> json) =>
      _$MoodEntryFromJson(json);
}
