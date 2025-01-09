import 'package:alpha/extensions.dart';
import 'package:alpha/services.dart';
import 'package:alpha/styles.dart';
import 'package:alpha/ui/common/alpha_button.dart';
import 'package:alpha/ui/common/alpha_scaffold.dart';
import 'package:alpha/ui/common/alpha_skill_bar.dart';
import 'package:alpha/ui/screens/dice_roll/dice_roll_screen.dart';
import 'package:alpha/ui/screens/next_turn/widgets/player_avatar.dart';
import 'package:flutter/material.dart';

class PlayersMenuScreen extends StatelessWidget {
  const PlayersMenuScreen({super.key});

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
        const SizedBox(height: 80.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PlayerAvatarWidget(player: activePlayer),
            const SizedBox(width: 40.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(activePlayer.name, style: TextStyles.bold28)),
                const SizedBox(height: 10.0),
                AlphaSkillBar(activePlayer)
              ],
            ),
          ],
        ),
        const SizedBox(height: 40.0),
        const Text("Players", style: TextStyles.bold20),
        const SizedBox(height: 20.0),
        Wrap(
          spacing: 15.0,
          children: playerManager.playersList.players.map((player) {
            final child = Column(
              children: [
                PlayerAvatarWidget(
                  player: player,
                  radius: 60.0,
                ),
                const SizedBox(height: 10.0),
                Text(
                  player.name,
                  style: TextStyles.medium16,
                )
              ],
            );

            return (activePlayer != player)
                ? ColorFiltered(
                    colorFilter: const ColorFilter.matrix([
                      // Standard grayscale matrix
                      0.2126, 0.7152, 0.0722, 0, 0,
                      0.2126, 0.7152, 0.0722, 0, 0,
                      0.2126, 0.7152, 0.0722, 0, 0,
                      0, 0, 0, 1, 0,
                    ]),
                    child: child,
                  )
                : child;
          }).toList(),
        ),
      ],
    );
  }
}
