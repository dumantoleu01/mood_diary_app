import 'package:injectable/injectable.dart';
import '../entities/mood_entry.dart';
import '../repositories/mood_repository.dart';

@injectable
class GetAllEntries {
  final MoodRepository _repository;

  GetAllEntries(this._repository);

  Future<List<MoodEntry>> call() async {
    return await _repository.getAllEntries();
  }
}
