import 'package:alpha/model/game_state.dart';
import 'package:alpha/screens/budgeting/screen.dart';
import 'package:alpha/screens/dashboard/dashboard_item.dart';
import 'package:alpha/screens/dashboard/horizontal_player_card.dart';
import 'package:alpha/widgets/alpha_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AlphaAppBar(
        title: "Dashboard",
        action: TextButton(
          onPressed: () => print("end turn"),
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
                  onTap: () => Navigator.of(context).push(CupertinoPageRoute(
                      builder: (BuildContext context) =>
                          const BudgetingScreen())),
                ),
                DashboardItem(
                    title: "Investments",
                    description:
                        "Invest your excess cash into the stock market to earn side income",
                    onTap: () => print("Investments")),
                DashboardItem(
                    title: "Businesses",
                    description:
                        "Manage your businesses to maximise profit or sell it based on its valuation",
                    onTap: () => print("Businesses")),
                const SizedBox(width: 20.0)
              ],
            )
          ]),
    );
  }
}
