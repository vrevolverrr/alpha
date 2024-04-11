import 'package:alpha/model/game_state.dart';
import 'package:alpha/screens/job_selection/screen.dart';
import 'package:alpha/model/player.dart';
import 'package:alpha/screens/player_creation/screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Alpha Game',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
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
    // return Scaffold(body: PlayersScreen(players: players));
    // return Scaffold(body: DashboardScreen(player: players[0]));
    return ChangeNotifierProvider(
        create: (context) => GameState(
            playerNames: ["Bryan", "Alen", "Aaron", "Joyce", "Lisong"]),
        child: const JobSelectionScreen());
  }
}
