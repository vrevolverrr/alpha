import 'dart:collection';

import 'package:alpha/logic/data/budget.dart';
import 'package:alpha/utils.dart';
import 'package:flutter/foundation.dart';

class BudgetManager {}

class BudgetAllocation extends ChangeNotifier {
  late Map<Budget, int> _budgets;
  final valid = ValueNotifier<bool>(true);

  BudgetAllocation({required Map<Budget, int> budgets}) {
    _budgets = Map.from(budgets);
  }

  UnmodifiableMapView<Budget, int> get value => UnmodifiableMapView(_budgets);
  Iterable<int> get values => UnmodifiableMapView(_budgets).values;

  operator [](Budget budget) => _budgets[budget]; // get

  operator []=(Budget budget, int value) {
    if (value == _budgets[budget]) return;

    _updateBudget(budget, value);
    notifyListeners();
  }

  /// Update local budgets map with an exact copy of the `budgets` provided
  void apply(BudgetAllocation tempBudgets) {
    _budgets = Map<Budget, int>.from(tempBudgets.value);
    notifyListeners();
  }

  void _updateBudget(Budget budget, int value) {
    if (value < 0 || value > 10) return;

    _budgets[budget] = value;

    final int proportionSum = sum<int>(_budgets.values);

    if (proportionSum == 10) {
      valid.value = true;
      return;
    }

    if (proportionSum < 10) {
      valid.value = false;
      return;
    }

    /// Else > 10, decrement the least priority budget by the exceeded amount.
    int excess = proportionSum - 10;

    final List<Budget> sortedBudgets = List.from(Budget.values)
      ..sort((a, b) => a.priority - b.priority);

    for (final b in sortedBudgets) {
      if (b == budget || this[b] <= 0) {
        continue;
      }

      if (excess <= 0) {
        break;
      }

      final int newBudget = this[b] - excess;
      excess -= this[b] - newBudget as int;
      _budgets[b] = newBudget >= 0 ? newBudget : 0;
    }
  }
}
