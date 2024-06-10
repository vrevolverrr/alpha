import 'package:alpha/extensions.dart';
import 'package:alpha/logic/game_state.dart';
import 'package:alpha/ui/common/alpha_button.dart';
import 'package:alpha/ui/common/alpha_container.dart';
import 'package:alpha/ui/common/alpha_scaffold.dart';
import 'package:alpha/ui/screens/budgeting/budgeting_screen.dart';
import 'package:alpha/ui/screens/investments/investments_screen.dart';
import 'package:alpha/ui/screens/players_menu/screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  void _endTurn(BuildContext context) {
    context.gameState.incrementGameState();
    context.navigateAndPopTo(const PlayersMenuScreen());
  }

  @override
  Widget build(BuildContext context) {
    return AlphaScaffold(
        title: "Dashboard",
        next: Builder(
          builder: (context) => AlphaButton(
            width: 235.0,
            title: "End Turn",
            disabled:
                context.watch<GameState>().activePlayer.hasUnbudgetedSalary,
            onTap: () => _endTurn(context),
            onTapDisabled: () => context.showSnackbar(
                message:
                    "✋🏼 Plan your unallocated budgets before ending the turn"),
          ),
        ),
        landingMessage: context.gameState.activePlayer.hasUnbudgetedSalary
            ? "💰 Go to the Budgeting page to plan your budget"
            : null,
        children: <Widget>[
          const SizedBox(height: 30.0),
          const Padding(
              padding: EdgeInsets.symmetric(horizontal: 50.0),
              child: _DashboardContents()),
          const SizedBox(height: 30.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            child: Builder(
              builder: (context) => const _DashboardActionButtions(),
            ),
          ),
        ]);
  }
}

class _DashboardContents extends StatelessWidget {
  const _DashboardContents();

  @override
  Widget build(BuildContext context) {
    return AlphaContainer(
        width: 1200.0,
        height: 450.0,
        padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 30.0),
        child: Column(
          children: <Widget>[
            const Text(
              "❗ WORK IN PROGRESS ❗",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24.0),
            ),
            const Text(
              "Savings Account",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24.0),
            ),
            Text(
              "\$${context.gameState.activePlayer.savings.toStringAsFixed(2)}",
              style: const TextStyle(fontSize: 20.0),
            ),
            const SizedBox(height: 10.0),
            const Text(
              "Investment Account",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24.0),
            ),
            Text(
              "\$${context.gameState.activePlayer.investments.toStringAsFixed(2)}",
              style: const TextStyle(fontSize: 20.0),
            ),
            const SizedBox(height: 30.0),
            const Text(
              "to show other relevant stats like knowledge,\nhealth, happiness etc etc",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.0),
            ),
          ],
        ));
  }
}

class _DashboardActionButtions extends StatelessWidget {
  const _DashboardActionButtions();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Builder(
            builder: (context) => AlphaButton(
                  width: 330.0,
                  title: "Budgeting",
                  color: const Color(0xffFFBFCA),
                  disabled: !context
                      .watch<GameState>()
                      .activePlayer
                      .hasUnbudgetedSalary,
                  onTap: () => context.navigateTo(const BudgetingScreen()),
                  onTapDisabled: () => context.showSnackbar(
                      message: "✋🏼 You have no unallocated budgets"),
                )),
        AlphaButton(
          width: 330.0,
          title: "Investments",
          color: const Color(0xffFFBFCA),
          onTap: () => context.navigateTo(const InvestmentsScreen()),
        ),
        AlphaButton(
          width: 330.0,
          title: "Businesses",
          color: const Color(0xffFFBFCA),
          onTap: () => context.showSnackbar(message: "🚧 Not implemented yet"),
        )
      ],
    );
  }
}
