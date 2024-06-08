import 'package:alpha/extensions.dart';
import 'package:alpha/ui/common/alpha_button.dart';
import 'package:alpha/ui/common/alpha_container.dart';
import 'package:alpha/ui/common/alpha_scaffold.dart';
import 'package:alpha/ui/screens/budgeting/screen.dart';
import 'package:alpha/ui/screens/investments/investments_screen.dart';
import 'package:alpha/ui/screens/players_menu/screen.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  void _endTurn(BuildContext context) {
    context.gameState.incrementGameState();
    context.navigateAndPopTo(const PlayersMenuScreen());
  }

  @override
  Widget build(BuildContext context) {
    return AlphaScaffold(
        title: "Dashboard",
        next: AlphaButton(
          width: 235.0,
          title: "End Turn",
          onTap: () => _endTurn(context),
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
    return const AlphaContainer(height: 450.0, child: Placeholder());
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
        AlphaButton(
          width: 330.0,
          title: "Budgeting",
          color: const Color(0xffFFBFCA),
          onTap: () => context.navigateTo(const BudgetingScreen()),
        ),
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
