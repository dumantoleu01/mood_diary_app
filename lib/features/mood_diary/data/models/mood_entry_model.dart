import 'package:hive/hive.dart';
import '../../../../core/constants/mood_types.dart';
import '../../domain/entities/mood_entry.dart';

class MoodEntryModel {
  final String id;
  final DateTime dateTime;
  final int moodTypeIndex;
  final List<String> subEmotions;
  final int stressLevel;
  final int selfEsteem;
  final String note;

  MoodEntryModel({
    required this.id,
    required this.dateTime,
    required this.moodTypeIndex,
    required this.subEmotions,
    required this.stressLevel,
    required this.selfEsteem,
    required this.note,
  });

  factory MoodEntryModel.fromEntity(MoodEntry entry) {
    return MoodEntryModel(
      id: entry.id,
      dateTime: entry.dateTime,
      moodTypeIndex: entry.moodType.index,
      subEmotions: entry.subEmotions,
      stressLevel: entry.stressLevel,
      selfEsteem: entry.selfEsteem,
      note: entry.note,
    );
  }

  MoodEntry toEntity() {
    return MoodEntry(
      id: id,
      dateTime: dateTime,
      moodType: MoodType.values[moodTypeIndex],
      subEmotions: subEmotions,
      stressLevel: stressLevel,
      selfEsteem: selfEsteem,
      note: note,
    );
  }
}

class MoodEntryModelAdapter extends TypeAdapter<MoodEntryModel> {
  @override
  final int typeId = 0;

  @override
  MoodEntryModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MoodEntryModel(
      id: fields[0] as String,
      dateTime: fields[1] as DateTime,
      moodTypeIndex: fields[2] as int,
      subEmotions: (fields[3] as List).cast<String>(),
      stressLevel: fields[4] as int,
      selfEsteem: fields[5] as int,
      note: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, MoodEntryModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.dateTime)
      ..writeByte(2)
      ..write(obj.moodTypeIndex)
      ..writeByte(3)
      ..write(obj.subEmotions)
      ..writeByte(4)
      ..write(obj.stressLevel)
      ..writeByte(5)
      ..write(obj.selfEsteem)
      ..writeByte(6)
      ..write(obj.note);
  }
}
