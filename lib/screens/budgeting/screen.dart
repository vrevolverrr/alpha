import 'package:alpha/model/game_state.dart';
import 'package:alpha/screens/budgeting/budget_tile.dart';
import 'package:alpha/model/player.dart';
import 'package:alpha/widgets/alpha_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BudgetingScreen extends StatefulWidget {
  const BudgetingScreen({super.key});

  @override
  State<BudgetingScreen> createState() => _BudgetingScreenState();
}

class _BudgetingScreenState extends State<BudgetingScreen> {
  final Map<Budget, double> budget = {};

  void updateBudget(Budget field, double percentage) {
    /* Updates the internal budget map, does not persist changes to GameState */
    budget[field] = percentage;
  }

  void onTapBack() {
    GameState gameState = context.read<GameState>();
    PlayerUpdates updates = PlayerUpdates();
    updates.setDeltaBudget(budget);
    gameState.updatePlayer(gameState.activePlayer, updates);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GameState>(
        builder: (BuildContext context, GameState gameState, Widget? child) {
      final Player activePlayer = gameState.activePlayer;

      return Scaffold(
          appBar: AlphaAppBar(title: "Budgeting", onTapBack: onTapBack),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("💰 Monthly Budget",
                  style:
                      TextStyle(fontSize: 40.0, fontWeight: FontWeight.w700)),
              const SizedBox(height: 20.0),
              Text(
                """Take-Home Pay (\$${activePlayer.salary.toStringAsFixed(2)}) minus Financial
                      Commitments (\$${activePlayer.commitments.toStringAsFixed(2)})""",
                style: const TextStyle(
                    fontSize: 20.0, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 15.0),
              Text(
                "💵 ${activePlayer.savings.toStringAsFixed(2)}",
                style: const TextStyle(
                    fontSize: 28.0, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 30.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const SizedBox(width: 20.0),
                  BudgetingTile(
                    title: "Savings",
                    initial: activePlayer.budgets[Budget.savings]!,
                    color: Colors.red,
                    onPercentageChange: (percentage) =>
                        updateBudget(Budget.savings, percentage),
                  ),
                  BudgetingTile(
                    title: "Investments",
                    initial: activePlayer.budgets[Budget.investments]!,
                    color: Colors.red,
                    onPercentageChange: (percentage) =>
                        updateBudget(Budget.investments, percentage),
                  ),
                  BudgetingTile(
                    title: "Daily Expenses",
                    initial: activePlayer.budgets[Budget.dailyExpenses]!,
                    color: Colors.red,
                    onPercentageChange: (percentage) =>
                        updateBudget(Budget.dailyExpenses, percentage),
                  ),
                  BudgetingTile(
                    title: Budget.recreational.title,
                    initial: activePlayer.budgets[Budget.recreational]!,
                    color: Colors.red,
                    onPercentageChange: (percentage) =>
                        updateBudget(Budget.recreational, percentage),
                  ),
                  BudgetingTile(
                    title: Budget.selfImprovement.title,
                    initial: activePlayer.budgets[Budget.selfImprovement]!,
                    color: Colors.red,
                    onPercentageChange: (percentage) =>
                        updateBudget(Budget.selfImprovement, percentage),
                  ),
                  const SizedBox(width: 20.0),
                ],
              ),
              const SizedBox(height: 50.0)
            ],
          ));
    });
  }
}
