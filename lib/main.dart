import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'app.dart';
import 'features/mood_diary/data/models/mood_entry_model.dart';
import 'injection/injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(MoodEntryModelAdapter());

  await configureDependencies();

  runApp(const MoodDiaryApp());
}
