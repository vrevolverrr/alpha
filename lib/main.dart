import 'package:alpha/logic/business_logic.dart';
import 'dart:developer';
import 'package:alpha/logic/game_logic.dart';
import 'package:alpha/ui/pages/main_menu_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:logging/logging.dart';

void main() {
  GetIt.instance.registerSingleton<GameManager>(GameManager());
  // TO-DO: how to integrate below business headcount class inside GetIt
  BusinessHeadCount.initializeHeadCount();
  WidgetsFlutterBinding.ensureInitialized();
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
        scaffoldBackgroundColor: const Color(0xffFCF7E8),
        useMaterial3: true,
        fontFamily: "MazzardH",
      ),
      home: const MainMenuPage(),
    );
  }
}
