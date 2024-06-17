import 'package:alpha/logic/financial_market_logic.dart';
import 'package:alpha/logic/game_manager.dart';
import 'package:alpha/logic/players_logic.dart';
import 'package:alpha/ui/pages/main_menu_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';

void main() {
  GetIt.instance.registerSingleton<GameManager>(GameManager());
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight])
      .then((_) => runApp(const MyApp()));
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

GameManager get gameManager => GetIt.I.get<GameManager>();
PlayerManager get playerManager => GetIt.I.get<GameManager>().playerManager;
Player get activePlayer =>
    GetIt.I.get<GameManager>().playerManager.getActivePlayer();
FinancialMarketManager get marketManager =>
    GetIt.I.get<GameManager>().marketManager;
