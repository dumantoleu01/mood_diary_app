import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/theme/app_theme.dart';
import 'features/mood_diary/presentation/bloc/mood_diary_bloc.dart';
import 'features/mood_diary/presentation/pages/main_page.dart';
import 'injection/injection.dart';

class MoodDiaryApp extends StatelessWidget {
  const MoodDiaryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Дневник настроения',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: BlocProvider(
        create: (context) => getIt<MoodDiaryBloc>()
          ..add(const MoodDiaryEvent.loadEntries()),
        child: const MainPage(),
      ),
    );
  }
}
