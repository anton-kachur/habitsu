import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:habits/app/App.dart';
import 'package:habits/app/DayDB.dart';
import 'package:habits/app/HabitsDB.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  final dir = await getApplicationDocumentsDirectory();

  Hive
    ..init(dir.path)
    ..registerAdapter<HabitData>(HabitDataAdapter())
    ..registerAdapter<DayData>(DayDataAdapter())
    ..initFlutter();


  var habits_box = await Hive.openBox('habits');
  //habits_box.clear();
  if (habits_box.isEmpty) {
    habits_box.put('habit0', HabitData('test', 'pages', 10.0, [DayData(DateTime.now().toString())]));
  } else {
    print("habits box is not empty!");
  }
  
  //habits_box.close();
  
  var days_box = await Hive.openBox('days');
  days_box.close();

  runApp(const App());
}
