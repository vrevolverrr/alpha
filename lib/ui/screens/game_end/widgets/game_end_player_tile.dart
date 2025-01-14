import 'package:alpha/extensions.dart';
import 'package:alpha/logic/game_logic.dart';
import 'package:alpha/styles.dart';
import 'package:alpha/ui/common/alpha_container.dart';
import 'package:alpha/ui/screens/next_turn/widgets/player_avatar.dart';
import 'package:flutter/material.dart';

class GameEndPlayerTile extends StatelessWidget {
  final GameLeaderboard leaderboard;

  const GameEndPlayerTile(this.leaderboard, {super.key});

  @override
  Widget build(BuildContext context) {
    return AlphaContainer(
      width: 520.0,
      height: 440.0,
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
              height: 130.0,
              width: 130.0,
              child: PlayerAvatarWidget(player: leaderboard.player)),
          const SizedBox(width: 20.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(leaderboard.player.name, style: TextStyles.bold22),
              const SizedBox(height: 5.0),
              const Text("Total Points", style: TextStyles.bold18),
              Text(leaderboard.points.toString(), style: TextStyles.bold24),
              const SizedBox(height: 5.0),
              const Text("Total Assets", style: TextStyles.bold18),
              Text(leaderboard.totalAssets.prettyCurrency,
                  style: TextStyles.bold21),
              const SizedBox(height: 5.0),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Goal", style: TextStyles.bold18),
                      Text(leaderboard.playerGoal.toString(),
                          style: TextStyles.bold21),
                    ],
                  ),
                  const SizedBox(width: 20.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Goal Bonus", style: TextStyles.bold18),
                      Text(leaderboard.goalBonus.toString(),
                          style: TextStyles.bold21),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 5.0),
              const Text("Total Debt", style: TextStyles.bold18),
              Text(leaderboard.totalDebt.prettyCurrency,
                  style: TextStyles.bold21),
              const SizedBox(height: 5.0),
              const Text("Debt Penalty", style: TextStyles.bold18),
              Text(leaderboard.debtPenalty.toString(),
                  style: TextStyles.bold21),
              const SizedBox(height: 5.0),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("C. ESG", style: TextStyles.bold18),
                      Text(leaderboard.cumulativeEsgScore.toString(),
                          style: TextStyles.bold21),
                    ],
                  ),
                  const SizedBox(width: 20.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Happiness Factor", style: TextStyles.bold18),
                      Text(leaderboard.happinessFactor.toString(),
                          style: TextStyles.bold21),
                    ],
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
