import 'package:injectable/injectable.dart';
import '../../domain/entities/mood_entry.dart';
import '../../domain/repositories/mood_repository.dart';
import '../datasources/mood_local_datasource.dart';
import '../models/mood_entry_model.dart';

@LazySingleton(as: MoodRepository)
class MoodRepositoryImpl implements MoodRepository {
  final MoodLocalDataSource _localDataSource;

  MoodRepositoryImpl(this._localDataSource);

  @override
  Future<List<MoodEntry>> getAllEntries() async {
    final models = await _localDataSource.getAllEntries();
    return models.map((model) => model.toEntity()).toList();
  }

  @override
  Future<List<MoodEntry>> getEntriesByDate(DateTime date) async {
    final models = await _localDataSource.getEntriesByDate(date);
    return models.map((model) => model.toEntity()).toList();
  }

  @override
  Future<MoodEntry?> getEntryById(String id) async {
    final model = await _localDataSource.getEntryById(id);
    return model?.toEntity();
  }

  @override
  Future<void> saveEntry(MoodEntry entry) async {
    final model = MoodEntryModel.fromEntity(entry);
    await _localDataSource.saveEntry(model);
  }

  @override
  Future<void> deleteEntry(String id) async {
    await _localDataSource.deleteEntry(id);
  }

  @override
  Future<void> updateEntry(MoodEntry entry) async {
    final model = MoodEntryModel.fromEntity(entry);
    await _localDataSource.updateEntry(model);
  }
}
