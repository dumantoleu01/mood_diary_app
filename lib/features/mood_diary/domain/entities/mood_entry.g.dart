// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mood_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MoodEntry _$MoodEntryFromJson(Map<String, dynamic> json) => _MoodEntry(
  id: json['id'] as String,
  dateTime: DateTime.parse(json['dateTime'] as String),
  moodType: $enumDecode(_$MoodTypeEnumMap, json['moodType']),
  subEmotions: (json['subEmotions'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  stressLevel: (json['stressLevel'] as num).toInt(),
  selfEsteem: (json['selfEsteem'] as num).toInt(),
  note: json['note'] as String,
);

Map<String, dynamic> _$MoodEntryToJson(_MoodEntry instance) =>
    <String, dynamic>{
      'id': instance.id,
      'dateTime': instance.dateTime.toIso8601String(),
      'moodType': _$MoodTypeEnumMap[instance.moodType]!,
      'subEmotions': instance.subEmotions,
      'stressLevel': instance.stressLevel,
      'selfEsteem': instance.selfEsteem,
      'note': instance.note,
    };

const _$MoodTypeEnumMap = {
  MoodType.happiness: 'happiness',
  MoodType.fear: 'fear',
  MoodType.rage: 'rage',
  MoodType.sadness: 'sadness',
  MoodType.calmness: 'calmness',
  MoodType.strength: 'strength',
};
