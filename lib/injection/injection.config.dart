// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../features/mood_diary/data/datasources/mood_local_datasource.dart'
    as _i1034;
import '../features/mood_diary/data/repositories/mood_repository_impl.dart'
    as _i937;
import '../features/mood_diary/domain/repositories/mood_repository.dart'
    as _i41;
import '../features/mood_diary/domain/usecases/delete_mood_entry.dart' as _i102;
import '../features/mood_diary/domain/usecases/get_all_entries.dart' as _i442;
import '../features/mood_diary/domain/usecases/get_entries_by_date.dart'
    as _i288;
import '../features/mood_diary/domain/usecases/save_mood_entry.dart' as _i509;
import '../features/mood_diary/presentation/bloc/mood_diary_bloc.dart' as _i565;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.lazySingleton<_i1034.MoodLocalDataSource>(
      () => _i1034.MoodLocalDataSourceImpl(),
    );
    gh.lazySingleton<_i41.MoodRepository>(
      () => _i937.MoodRepositoryImpl(gh<_i1034.MoodLocalDataSource>()),
    );
    gh.factory<_i102.DeleteMoodEntry>(
      () => _i102.DeleteMoodEntry(gh<_i41.MoodRepository>()),
    );
    gh.factory<_i442.GetAllEntries>(
      () => _i442.GetAllEntries(gh<_i41.MoodRepository>()),
    );
    gh.factory<_i288.GetEntriesByDate>(
      () => _i288.GetEntriesByDate(gh<_i41.MoodRepository>()),
    );
    gh.factory<_i509.SaveMoodEntry>(
      () => _i509.SaveMoodEntry(gh<_i41.MoodRepository>()),
    );
    gh.factory<_i565.MoodDiaryBloc>(
      () => _i565.MoodDiaryBloc(
        gh<_i442.GetAllEntries>(),
        gh<_i509.SaveMoodEntry>(),
        gh<_i102.DeleteMoodEntry>(),
      ),
    );
    return this;
  }
}
