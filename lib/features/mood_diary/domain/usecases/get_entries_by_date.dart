import 'package:injectable/injectable.dart';
import '../entities/mood_entry.dart';
import '../repositories/mood_repository.dart';

@injectable
class GetEntriesByDate {
  final MoodRepository _repository;

  GetEntriesByDate(this._repository);

  Future<List<MoodEntry>> call(DateTime date) async {
    return await _repository.getEntriesByDate(date);
  }
}
