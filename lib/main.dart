import 'package:alpha/model/game_state.dart';
import 'package:alpha/screens/dashboard/screen.dart';
import 'package:alpha/screens/dice_roll/screen.dart';
import 'package:alpha/screens/job_selection/screen.dart';
import 'package:alpha/screens/player_creation/screen.dart';
import 'package:alpha/screens/players_menu/screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight])
      .then((_) => runApp(const MyApp()));
  ;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider(
        // instantiate a GameState that will be accessed by all children
        create: (BuildContext context) => GameState(
            playerNames: ["Bryan", "Alen", "Aaron", "Joyce", "Lisong"]),
        child: MaterialApp(
          title: 'Alpha Game',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: true,
          ),
          home: const HomePage(),
        ));
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return const PlayersMenuScreen();
  }
}
