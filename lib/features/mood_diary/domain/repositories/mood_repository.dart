import '../entities/mood_entry.dart';

abstract class MoodRepository {
  Future<List<MoodEntry>> getAllEntries();
  Future<List<MoodEntry>> getEntriesByDate(DateTime date);
  Future<MoodEntry?> getEntryById(String id);
  Future<void> saveEntry(MoodEntry entry);
  Future<void> deleteEntry(String id);
  Future<void> updateEntry(MoodEntry entry);
}
