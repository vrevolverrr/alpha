import 'package:alpha/logic/game_logic.dart';
import 'package:alpha/services.dart';
import 'package:alpha/styles.dart';
import 'package:alpha/ui/common/alpha_scaffold.dart';
import 'package:alpha/ui/screens/game_end/widgets/game_end_player_tile.dart';
import 'package:flutter/material.dart';

class GameEndScreen extends StatelessWidget {
  final List<GameLeaderboard> leaderboard = gameManager.leaderboard;

  GameEndScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AlphaScaffold(
      title: "Game Over",
      children: [
        const SizedBox(height: 20.0),
        const Text(
          "This page is for analysis purposes. Please do not close out.",
          style: TextStyles.medium20,
        ),
        const SizedBox(height: 10.0),
        Text(
          "Rounds Played: ${gameManager.round}",
          style: TextStyles.medium20,
        ),
        const SizedBox(height: 20.0),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Wrap(
              spacing: 20.0,
              runSpacing: 20.0,
              children: leaderboard
                  .map(
                    (ld) => GameEndPlayerTile(ld),
                  )
                  .toList()),
        )
      ],
    );
  }
}
