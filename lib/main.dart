import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:done/app.dart';
import 'package:done/feature/app/models/priority.dart';
import 'package:done/feature/app/models/task.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'common/logger.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initLogger();
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  Hive.registerAdapter(PriorityAdapter());
  await Hive.openBox<Task>('tasks');
  AppMetrica.activate(const AppMetricaConfig(
      'efa0a8e5-44c7-43c4-aa8d-25bd20dfafac'));
  runApp(
    const App(
      isDebug: false,
    ),
  );
}
