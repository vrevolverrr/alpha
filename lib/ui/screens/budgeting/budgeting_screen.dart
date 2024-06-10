import 'dart:ffi';

import 'package:alpha/extensions.dart';
import 'package:alpha/logic/enums/budget.dart';
import 'package:alpha/ui/common/alpha_button.dart';
import 'package:alpha/ui/common/alpha_scaffold.dart';
import 'package:alpha/ui/screens/budgeting/budgeting_tile.dart';
import 'package:alpha/ui/screens/dashboard/dashboard_screen.dart';
import 'package:flutter/material.dart';

class BudgetingScreen extends StatefulWidget {
  const BudgetingScreen({super.key});

  @override
  State<BudgetingScreen> createState() => _BudgetingScreenState();
}

class _BudgetingScreenState extends State<BudgetingScreen> {
  void _handleIncrementBudget(Budget budget) {
    setState(() {
      context.gameState.activePlayer.incrementBudget(budget);
    });
  }

  void _handleDecrementBudget(Budget budget) {
    setState(() {
      context.gameState.activePlayer.decrementBudget(budget);
    });
  }

  void _handleConfirmInvalidBudget(BuildContext context) {
    context.showSnackbar(message: "✋🏼 Please provide a valid budgeting plan.");
  }

  void _handleConfirmBudget(BuildContext context) {
    context.gameState.activePlayer.applyBudget();
    // context.navigateAndPopTo(const DashboardScreen());
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final double disposableIncome = context.activePlayer.disposable;
    final double salary = context.activePlayer.salary;
    final double commitments = context.activePlayer.commitments;

    return AlphaScaffold(
        title: "Budgeting",
        onTapBack: () => Navigator.of(context).pop(),
        next: Builder(
          builder: (context) => AlphaButton(
            width: 230.0,
            title: "Confirm",
            disabled: !context.gameState.activePlayer.hasValidBudget,
            onTapDisabled: () => _handleConfirmInvalidBudget(context),
            onTap: () => _handleConfirmBudget(context),
          ),
        ),
        children: <Widget>[
          const SizedBox(height: 25.0),
          const Text(
            "Disposable Income",
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 35.0),
          ),
          Text(
            "(\$${salary.toStringAsFixed(2)} minus commitments \$${commitments.toStringAsFixed(2)})",
            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18.0),
          ),
          const SizedBox(height: 10.0),
          Text(
            "\$${disposableIncome.toStringAsFixed(2)}",
            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 40.0),
          ),
          const SizedBox(height: 30.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: context.gameState.activePlayer.budgets.entries
                  .map((MapEntry<Budget, int> entry) => BudgetingTile(
                        title: entry.key.title,
                        proportion: entry.value,
                        amount: (entry.value / 10) * disposableIncome,
                        onIncrement: () => _handleIncrementBudget(entry.key),
                        onDecrement: () => _handleDecrementBudget(entry.key),
                      ))
                  .toList(),
            ),
          )
        ]);
  }
}
