import 'package:alpha/screens/dashboard/dashboard_item.dart';
import 'package:alpha/screens/dashboard/horizontal_player_card.dart';
import 'package:alpha/model/player.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  final Player player;

  const DashboardScreen({super.key, required this.player});

  @override
  State<StatefulWidget> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          HorizontalPlayerCard(player: widget.player),
          const SizedBox(
            height: 50.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const SizedBox(width: 20.0),
              DashboardItem(
                player: widget.player,
                title: "Budgeting",
                description:
                    "Strategically allocate your budgets to maximise profits and happiness",
              ),
              DashboardItem(
                player: widget.player,
                title: "Investments",
                description:
                    "Invest your excess cash into the stock market to earn side income",
              ),
              DashboardItem(
                  player: widget.player,
                  title: "Businesses",
                  description:
                      "Manage your businesses to maximise profit or sell it based on its valuation"),
              const SizedBox(width: 20.0)
            ],
          )
        ]);
  }
}
