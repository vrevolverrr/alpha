import 'package:alpha/extensions.dart';
import 'package:alpha/logic/budget_logic.dart';
import 'package:alpha/logic/data/budget.dart';
import 'package:alpha/services.dart';
import 'package:alpha/styles.dart';
import 'package:alpha/ui/common/alpha_button.dart';
import 'package:alpha/ui/common/alpha_scaffold.dart';
import 'package:alpha/ui/screens/budgeting/widgets/budgeting_tile.dart';
import 'package:alpha/ui/screens/dashboard/dashboard_screen.dart';
import 'package:flutter/material.dart';

class BudgetingScreen extends StatelessWidget {
  final tempBudget = BudgetAllocation(budgets: activePlayer.budgets.value);

  BudgetingScreen({super.key});

  void _handleIncrementBudget(Budget budget) =>
      tempBudget[budget] = tempBudget[budget] + 1;

  void _handleDecrementBudget(Budget budget) =>
      tempBudget[budget] = tempBudget[budget] - 1;

  void _handleConfirmInvalidBudget(BuildContext context) {
    context.showSnackbar(message: "✋🏼 Please provide a valid budgeting plan.");
  }

  void _handleConfirmBudget(BuildContext context) {
    // activePlayer.applyBudget(tempBudget);
    context.navigateAndPopTo(const DashboardScreen());
  }

  @override
  Widget build(BuildContext context) {
    return AlphaScaffold(
        title: "Budgeting",
        next: ValueListenableBuilder(
          valueListenable: tempBudget.valid,
          builder: _buildConfirmBtn,
        ),
        children: <Widget>[
          const SizedBox(height: 25.0),
          const Text("Unallocated Budget", style: TextStyles.bold32),
          const SizedBox(height: 4.03),
          Text(
            " minus (CPF)",
            style: TextStyles.medium22,
          ),
          const SizedBox(height: 12.0),
          Text(
            "",
            style: const TextStyle(
                fontSize: 44.0,
                color: Color(0xFF348A37),
                fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 15.0),
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
        width: 300.0,
        title: "Apply Budget",
        disabled: !value,
        onTapDisabled: () => _handleConfirmInvalidBudget(context),
        onTap: () => _handleConfirmBudget(context),
      );

  Widget _buildBudgetingTile(Budget key) => ListenableBuilder(
        listenable: tempBudget,
        builder: (context, child) => BudgetingTile(
          title: key.title,
          proportion: tempBudget[key],
          amount: (tempBudget[key] / 10),
          onIncrement: () => _handleIncrementBudget(key),
          onDecrement: () => _handleDecrementBudget(key),
        ),
      );
}
