import 'package:injectable/injectable.dart';
import '../repositories/mood_repository.dart';

@injectable
class DeleteMoodEntry {
  final MoodRepository _repository;

  DeleteMoodEntry(this._repository);

  Future<void> call(String id) async {
    await _repository.deleteEntry(id);
  }
}
