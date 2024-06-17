import 'package:alpha/extensions.dart';
import 'package:alpha/main.dart';
import 'package:alpha/styles.dart';
import 'package:alpha/ui/common/alpha_button.dart';
import 'package:alpha/ui/common/alpha_container.dart';
import 'package:alpha/ui/common/alpha_scaffold.dart';
import 'package:alpha/ui/screens/budgeting/budgeting_screen.dart';
import 'package:alpha/ui/screens/investments/investments_screen.dart';
import 'package:alpha/ui/screens/players_menu/screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
            const Text("❗ WORK IN PROGRESS ❗", style: TextStyles.bold24),
            const Text("Savings Account", style: TextStyles.bold24),
            Text(
              "\$${activePlayer.savings.toStringAsFixed(2)}",
              style: TextStyles.medium20,
            ),
            const SizedBox(height: 10.0),
            const Text("Investment Account", style: TextStyles.bold24),
            Text(
              "\$${activePlayer.investments.toStringAsFixed(2)}",
              style: TextStyles.medium20,
            ),
            const SizedBox(height: 30.0),
            const Text(
                "to show other relevant stats like knowledge,\nhealth, happiness etc etc",
                textAlign: TextAlign.center,
                style: TextStyles.bold18),
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
                  onTap: () => context.navigateTo(BudgetingScreen()),
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
