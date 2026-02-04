import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import '../models/mood_entry_model.dart';

abstract class MoodLocalDataSource {
  Future<List<MoodEntryModel>> getAllEntries();
  Future<List<MoodEntryModel>> getEntriesByDate(DateTime date);
  Future<MoodEntryModel?> getEntryById(String id);
  Future<void> saveEntry(MoodEntryModel entry);
  Future<void> deleteEntry(String id);
  Future<void> updateEntry(MoodEntryModel entry);
}

@LazySingleton(as: MoodLocalDataSource)
class MoodLocalDataSourceImpl implements MoodLocalDataSource {
  static const String _boxName = 'mood_entries';

  Future<Box<MoodEntryModel>> get _box async {
    if (!Hive.isBoxOpen(_boxName)) {
      return await Hive.openBox<MoodEntryModel>(_boxName);
    }
    return Hive.box<MoodEntryModel>(_boxName);
  }

  @override
  Future<List<MoodEntryModel>> getAllEntries() async {
    final box = await _box;
    return box.values.toList();
  }

  @override
  Future<List<MoodEntryModel>> getEntriesByDate(DateTime date) async {
    final box = await _box;
    return box.values.where((entry) {
      return entry.dateTime.year == date.year &&
          entry.dateTime.month == date.month &&
          entry.dateTime.day == date.day;
    }).toList();
  }

  @override
  Future<MoodEntryModel?> getEntryById(String id) async {
    final box = await _box;
    try {
      return box.values.firstWhere((entry) => entry.id == id);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> saveEntry(MoodEntryModel entry) async {
    final box = await _box;
    await box.put(entry.id, entry);
  }

  @override
  Future<void> deleteEntry(String id) async {
    final box = await _box;
    await box.delete(id);
  }

  @override
  Future<void> updateEntry(MoodEntryModel entry) async {
    final box = await _box;
    await box.put(entry.id, entry);
  }
}
