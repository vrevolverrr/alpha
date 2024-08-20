import 'package:alpha/extensions.dart';
import 'package:alpha/services.dart';
import 'package:alpha/styles.dart';
import 'package:alpha/ui/common/alpha_button.dart';
import 'package:alpha/ui/common/alpha_scaffold.dart';
import 'package:alpha/ui/screens/budgeting/budgeting_screen.dart';
import 'package:alpha/ui/screens/dashboard/widgets/dashboard_action_card.dart';
import 'package:alpha/ui/screens/dashboard/widgets/dashboard_education_card.dart';
import 'package:alpha/ui/screens/dashboard/widgets/dashboard_player_card.dart';
import 'package:alpha/ui/screens/dashboard/widgets/dashboard_player_stats.dart';
import 'package:alpha/ui/screens/investments/investments_screen.dart';
import 'package:alpha/ui/screens/players_menu/players_menu_screen.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' show Vector3;

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  void _handleEndTurn(BuildContext context) {
    gameManager.nextTurn();
    context.navigateAndPopTo(const PlayersMenuScreen());
  }

  @override
  Widget build(BuildContext context) {
    return AlphaScaffold(
        title: "Dashboard",
        useDefaultPadding: true,
        next: Builder(
          builder: (context) => AlphaButton(
            width: 235.0,
            title: "End Turn",
            onTap: () => _handleEndTurn(context),
            onTapDisabled: () => context.showSnackbar(
                message:
                    "✋🏼 Plan your unallocated budgets before ending the turn"),
          ),
        ),
        children: const <Widget>[
          SizedBox(height: 25.0),
          _DashboardPlayerStats(),
          SizedBox(height: 35.0),
          _DashboardContents(),
        ]);
  }
}

class _DashboardPlayerStats extends StatelessWidget {
  const _DashboardPlayerStats();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        ListenableBuilder(
          listenable: activePlayer.savings,
          builder: (context, child) => DashboardPlayerStatCard(
              emoji: "💵",
              title: "Savings",
              value: "\$${activePlayer.savings.sBalance}"),
        ),
        ListenableBuilder(
          listenable: activePlayer.investments,
          builder: (context, child) => DashboardPlayerStatCard(
              emoji: "💵",
              title: "Investments",
              value: "\$${activePlayer.investments.sBalance}"),
        ),
        ListenableBuilder(
          listenable: activePlayer.stats,
          builder: (context, child) => DashboardPlayerStatCard(
              emoji: "❤️",
              title: "Happiness",
              value: activePlayer.stats.happiness.toString(),
              valueWidth: 50.0),
        ),
        ListenableBuilder(
          listenable: activePlayer.stats,
          builder: (context, child) => DashboardPlayerStatCard(
              emoji: "🕙",
              title: "Time",
              value: activePlayer.stats.time.toString(),
              valueWidth: 50.0),
        ),
      ],
    );
  }
}

class _DashboardContents extends StatelessWidget {
  const _DashboardContents();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          children: <Widget>[
            const DashboardPlayerCard(playerName: "Bryan"),
            const SizedBox(height: 50.0),
            DashboardCurrentTileCard(player: activePlayer)
          ],
        ),
        Column(
          children: <Widget>[
            const _DashboardPlayerExpLevel(),
            const SizedBox(height: 40.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                DashboardActionCard(
                  title: "Budgeting",
                  description: "Plan your budget to earn stats and level up.",
                  onTap: () => context.navigateTo(BudgetingScreen()),
                ),
                const SizedBox(width: 20.0),
                DashboardActionCard(
                  title: "Investments",
                  description: "Invest in various assets to earn money.",
                  onTap: () => context.navigateTo(const InvestmentsScreen()),
                ),
                const SizedBox(width: 20.0),
                const DashboardActionCard(
                  title: "Businesses",
                  description: "Manage your business operations.",
                ),
              ],
            )
          ],
        )
      ],
    );
  }
}

class _DashboardPlayerExpLevel extends StatelessWidget {
  const _DashboardPlayerExpLevel();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          width: 750.0,
          height: 55.0,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(50.0),
              border: Border.all(color: Colors.black, width: 4.0),
              boxShadow: const <BoxShadow>[
                BoxShadow(color: Colors.black, offset: Offset(1.0, 1.0))
              ]),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Container(
                  width: 700.0,
                  height: 12.0,
                  decoration: BoxDecoration(
                      color: const Color(0xffD9D9D9),
                      borderRadius: BorderRadius.circular(50.0),
                      border: Border.all(color: Colors.black, width: 2.0)),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: ListenableBuilder(
                    listenable: activePlayer.skill,
                    builder: (context, child) => Container(
                      /// To calculate progress percentage
                      width: activePlayer.skill.levelPercent * 700.0,
                      height: 12.0,
                      decoration: BoxDecoration(
                          color: const Color(0xffFF6B6B),
                          borderRadius: BorderRadius.circular(50.0),
                          border: Border.all(color: Colors.black, width: 2.0)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
            right: 20.0,
            child: Transform.translate(
              offset: const Offset(0.0, -28.0),
              child: ListenableBuilder(
                listenable: activePlayer.skill,
                builder: (context, child) => Text(
                  "XP ${activePlayer.skill.levelExp} / 1000",
                  style: TextStyles.bold18,
                ),
              ),
            )),
        Positioned(
            left: 20.0,
            child: Transform.translate(
              offset: const Offset(0.0, -28.0),
              child: ListenableBuilder(
                listenable: activePlayer.skill,
                builder: (context, child) => Text(
                  "LEVEL ${activePlayer.skill.level}",
                  style: TextStyles.bold18,
                ),
              ),
            )),
        Positioned.fill(
          child: Align(
            alignment: Alignment.topCenter,
            child: Container(
              alignment: Alignment.center,
              transform: Matrix4.translation(Vector3(0, -30.0, 0)),
              padding: const EdgeInsets.only(top: 4.0, right: 2.0),
              width: 150.0,
              height: 40.0,
              decoration: BoxDecoration(
                  color: const Color(0xffFFBFCA),
                  borderRadius: BorderRadius.circular(50.0),
                  border: Border.all(color: Colors.black, width: 3.0),
                  boxShadow: const <BoxShadow>[
                    BoxShadow(color: Colors.black, offset: Offset(1.5, 1.5))
                  ]),
              child: const Text(
                "Skill Level",
                style: TextStyles.bold18,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
