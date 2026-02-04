import 'package:injectable/injectable.dart';
import '../entities/mood_entry.dart';
import '../repositories/mood_repository.dart';

@injectable
class SaveMoodEntry {
  final MoodRepository _repository;

  SaveMoodEntry(this._repository);

  Future<void> call(MoodEntry entry) async {
    await _repository.saveEntry(entry);
  }
}
