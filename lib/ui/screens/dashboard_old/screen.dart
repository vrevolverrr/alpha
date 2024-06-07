import 'package:alpha/logic/game_state.dart';
import 'package:alpha/ui/screens/budgeting/screen.dart';
import 'package:alpha/ui/screens/dashboard_old/widgets/dashboard_item.dart';
import 'package:alpha/ui/screens/dashboard_old/horizontal_player_card.dart';
import 'package:alpha/ui/screens/players_menu/screen.dart';
import 'package:alpha/ui/common/alpha_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  void onTapItemBudgeting() {
    Navigator.of(context).push(CupertinoPageRoute(
        builder: (BuildContext context) => const BudgetingScreen()));
  }

  void onTapItemInvestments() {
    print("Investments");
  }

  void onTapItemBusinesses() {
    print("Businesses");
  }

  void endTurn() {
    context.read<GameState>().incrementGameState();
    Navigator.of(context).pushAndRemoveUntil(
        CupertinoPageRoute(builder: (context) => const PlayersMenuScreen()),
        (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AlphaAppBar(
        title: "Dashboard",
        action: TextButton(
          onPressed: endTurn,
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.0),
            child: Text(
              "End Turn",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 17.0,
              ),
            ),
          ),
        ),
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Consumer(
                builder: (BuildContext context, GameState gameState,
                        Widget? child) =>
                    HorizontalPlayerCard(player: gameState.activePlayer)),
            const SizedBox(
              height: 50.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const SizedBox(width: 20.0),
                DashboardItem(
                  title: "Budgeting",
                  description:
                      "Strategically allocate your budgets to maximise profits and happiness",
                  onTap: onTapItemBudgeting,
                ),
                DashboardItem(
                    title: "Investments",
                    description:
                        "Invest your excess cash into the stock market to earn side income",
                    onTap: onTapItemInvestments),
                DashboardItem(
                    title: "Businesses",
                    description:
                        "Manage your businesses to maximise profit or sell it based on its valuation",
                    onTap: onTapItemBusinesses),
                const SizedBox(width: 20.0)
              ],
            )
          ]),
    );
  }
}
