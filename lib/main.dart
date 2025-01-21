import 'dart:developer';
import 'package:alpha/logic/game_logic.dart';
import 'package:alpha/ui/screens/main_menu/main_menu_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:logging/logging.dart';

const String version = "0.3.1 Build 1";

void main() {
  GetIt.instance.registerSingleton<GameManager>(GameManager());
  WidgetsFlutterBinding.ensureInitialized();

  /// Hide the status bar
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

  /// Configure logging
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    log(record.message,
        name: record.loggerName, time: record.time, level: record.level.value);
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Alpha Game',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xffFCF7E8),
        fontFamily: "MazzardH",
      ),
      home: const MainMenuScreen(),
    );
  }
}
