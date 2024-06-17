import 'package:alpha/extensions.dart';
import 'package:alpha/logic/data/budget.dart';
import 'package:alpha/logic/players_logic.dart';
import 'package:alpha/main.dart';
import 'package:alpha/styles.dart';
import 'package:alpha/ui/common/alpha_button.dart';
import 'package:alpha/ui/common/alpha_scaffold.dart';
import 'package:alpha/ui/screens/budgeting/budgeting_tile.dart';
import 'package:flutter/material.dart';

class BudgetingScreen extends StatelessWidget {
  final tempBudget = BudgetAllocationNotifier(budgets: activePlayer.budgets);

  BudgetingScreen({super.key});

  void _handleIncrementBudget(Budget budget) =>
      tempBudget[budget] = tempBudget[budget] + 1;

  void _handleDecrementBudget(Budget budget) =>
      tempBudget[budget] = tempBudget[budget] - 1;

  void _handleConfirmInvalidBudget(BuildContext context) {
    context.showSnackbar(message: "✋🏼 Please provide a valid budgeting plan.");
  }

  void _handleConfirmBudget(BuildContext context) {
    activePlayer.setBudget(tempBudget);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AlphaScaffold(
        title: "Budgeting",
        onTapBack: () => Navigator.of(context).pop(),
        next: ValueListenableBuilder(
          valueListenable: tempBudget.valid,
          builder: _buildConfirmBtn,
        ),
        children: <Widget>[
          const SizedBox(height: 25.0),
          const Text("Disposable Income", style: TextStyles.bold35),
          Text(
            "(\$${activePlayer.salary.toStringAsFixed(2)} minus commitments \$${activePlayer.commitments.toStringAsFixed(2)})",
            style: TextStyles.bold18,
          ),
          const SizedBox(height: 10.0),
          Text(
            "\$${activePlayer.disposable.toStringAsFixed(2)}",
            style: TextStyles.bold40,
          ),
          const SizedBox(height: 30.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: tempBudget.value.keys
                  .map((Budget key) => _buildBudgetingTile(key))
                  .toList(),
            ),
          )
        ]);
  }

  /// Widget builders
  Widget _buildConfirmBtn(BuildContext context, bool value, Widget? child) =>
      AlphaButton(
        width: 230.0,
        title: "Confirm",
        disabled: !value,
        onTapDisabled: () => _handleConfirmInvalidBudget(context),
        onTap: () => _handleConfirmBudget(context),
      );

  Widget _buildBudgetingTile(Budget key) => ListenableBuilder(
        listenable: tempBudget,
        builder: (context, child) => BudgetingTile(
          title: key.title,
          proportion: tempBudget[key],
          amount: (tempBudget[key] / 10) * activePlayer.disposable,
          onIncrement: () => _handleIncrementBudget(key),
          onDecrement: () => _handleDecrementBudget(key),
        ),
      );
}
