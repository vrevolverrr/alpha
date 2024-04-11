import 'package:alpha/model/game_state.dart';
import 'package:alpha/screens/players_menu/player_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlayersScreen extends StatefulWidget {
  const PlayersScreen({super.key});

  @override
  State<PlayersScreen> createState() => _PlayersScreenState();
}

class _PlayersScreenState extends State<PlayersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<GameState>(
        builder: (context, gameState, child) => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const SizedBox(
                  width: 150.0,
                ),
                PlayerCard(player: gameState.players[0]),
                PlayerCard(
                  player: gameState.players[1],
                ),
                const SizedBox(
                  width: 150.0,
                )
              ],
            ),
            const SizedBox(height: 50.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const SizedBox(
                  width: 5.0,
                ),
                PlayerCard(
                  player: gameState.players[2],
                ),
                PlayerCard(player: gameState.players[3]),
                PlayerCard(player: gameState.players[4]),
                const SizedBox(
                  width: 5.0,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
