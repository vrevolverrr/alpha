import 'package:alpha/model/game_state.dart';
import 'package:alpha/screens/dice_roll/screen.dart';
import 'package:alpha/screens/players_menu/player_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlayersMenuScreen extends StatefulWidget {
  const PlayersMenuScreen({super.key});

  @override
  State<PlayersMenuScreen> createState() => _PlayersMenuScreenState();
}

class _PlayersMenuScreenState extends State<PlayersMenuScreen> {
  void onTapPlayerCard() {
    /// Callback for tapping the active [PlayerCard]
    /// Rolls the dice and pushes to the [DiceRollScreen]

    // Read the current [GameState] from global provider
    GameState gameState = context.read<GameState>();

    Navigator.of(context).push(CupertinoPageRoute(builder: (context) {
      int dice = gameState.rollDice();
      return DiceRollScreen(dice);
    }));
  }

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
                PlayerCard(
                  player: gameState.players[0],
                  onTap: onTapPlayerCard,
                ),
                PlayerCard(player: gameState.players[1]),
                const SizedBox(width: 150.0)
              ],
            ),
            const SizedBox(height: 50.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const SizedBox(width: 5.0),
                PlayerCard(player: gameState.players[2]),
                PlayerCard(player: gameState.players[3]),
                PlayerCard(player: gameState.players[4]),
                const SizedBox(width: 5.0)
              ],
            )
          ],
        ),
      ),
    );
  }
}
