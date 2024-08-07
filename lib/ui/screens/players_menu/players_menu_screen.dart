import 'package:alpha/extensions.dart';
import 'package:alpha/logic/players_logic.dart';
import 'package:alpha/services.dart';
import 'package:alpha/ui/common/alpha_button.dart';
import 'package:alpha/ui/common/alpha_scaffold.dart';
import 'package:alpha/ui/screens/dice_roll/dice_roll_screen.dart';
import 'package:alpha/ui/screens/players_menu/widgets/player_card.dart';
import 'package:flutter/material.dart';

class PlayersMenuScreen extends StatelessWidget {
  const PlayersMenuScreen({super.key});

  List<PlayerCard> _buildPlayerCards() =>
      gameManager.playerManager.playersList.players
          .map((Player player) => PlayerCard(
                player: player,
                active: activePlayer == player,
              ))
          .toList();

  @override
  Widget build(BuildContext context) {
    return AlphaScaffold(
      title: "It's ${activePlayer.name}'s turn",
      next: Builder(
        builder: (context) => AlphaButton(
          width: 270.0,
          title: "Start Turn",
          onTap: () => context.navigateAndPopTo(const DiceRollScreen()),
        ),
      ),
      children: [
        const SizedBox(height: 40.0),
        SizedBox(
            width: 1000.0,
            height: 600.0,
            child: Wrap(
              spacing: 25.0,
              runSpacing: 30.0,
              alignment: WrapAlignment.center,
              children: _buildPlayerCards(),
            ))
      ],
    );
  }
}
