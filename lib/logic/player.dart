import 'package:alpha/logic/enums/education.dart';
import 'package:alpha/logic/enums/budget.dart';
import 'package:alpha/logic/enums/job.dart';
import 'package:alpha/logic/enums/personal_life.dart';
import 'package:alpha/logic/stocks.dart';
import 'package:flutter/material.dart';

class Player extends ChangeNotifier {
  /// Configurations
  static const int kMaxTime = 500;
  static const int kBaseHappiness = 100;

  final String _name;

  Player(this._name);

  /// Player Events ///

  //////

  /// Player stats ///
  int _happiness = Player.kBaseHappiness;
  int _time = Player.kMaxTime;
  PersonalLife _personalLife = PersonalLife.single;

  void updateHappiness(int delta) {
    _happiness += delta;
  }

  void updateTime(int delta) {
    _time += delta;
  }

  String get name => _name;
  int get time => _time;
  int get happiness => _happiness;
  /////////

  /// Financial ///
  double _savings = 2000.0; // savings account
  double _investments = 500.0; // investment account

  // Maps stock does to units owned
  final Map<String, int> _ownedShares = {};

  double get savings => _savings;
  double get investments => _investments;
  double get commitments => 671.0;
  double get disposable => salary - commitments;
  double get totalAssets => _savings + _investments;
  Map<String, int> get ownedShares => _ownedShares;

  void addSavings(double amt) {
    _savings += amt;
  }

  bool deductSavings(double amt) {
    if (amt > _savings) {
      return false;
    }

    _savings -= amt;
    return true;
  }

  void addInvestmentAcc(double amt) {
    _investments += amt;
  }

  bool deductInvestmentAcc(double amt) {
    if (amt > _investments) {
      return false;
    }

    _investments -= amt;
    return true;
  }

  bool purchaseShare(Stock stock, int units) {
    final double totalPrice = stock.price * units;
    final bool status = deductInvestmentAcc(totalPrice);

    if (status) {
      /// Add to stock count if present else set as `units`
      ownedShares.update(stock.code, (owned) => owned + units,
          ifAbsent: () => units);
    }

    // true if enough cash in investment account to purchase else false
    return status;
  }

  bool sellShare(Stock stock, int units) {
    final int ownedUnits = _ownedShares[stock.code] ?? 0;

    if (ownedUnits < units) {
      /// Player does not have sufficient units to sell.
      return false;
    }

    final double totalPrice = stock.price * units;
    addInvestmentAcc(totalPrice);
    return true;
  }
  /////////

  /// Budgets ///
  double _unbudgetedSalary = 0.0;
  Map<Budget, int> get budgets => _budgets;

  final Map<Budget, int> _budgets = {
    Budget.dailyExpenses: 2,
    Budget.selfImprovement: 2,
    Budget.recreational: 2,
    Budget.investments: 2,
    Budget.savings: 2,
  };

  bool get hasUnbudgetedSalary => _unbudgetedSalary > 0;

  bool get hasValidBudget =>
      _budgets.values.reduce((value, acc) => value + acc) == 10;

  void applyBudget() {
    // TODO apply to all fields
    addSavings((_budgets[Budget.savings]! / 10) * _unbudgetedSalary);
    addInvestmentAcc((_budgets[Budget.investments]! / 10) * _unbudgetedSalary);

    _unbudgetedSalary = 0;
    notifyListeners();
  }

  Map<Budget, int> updateBudget(Budget budget, int value) {
    _budgets[budget] = value;

    final int proportionSum =
        _budgets.values.reduce((value, acc) => value + acc);

    if (proportionSum > 10) {
      // If sum of proportions greater than 10, decrement the least priority
      // budget by the exceeded amount.
      int excess = proportionSum - 10;
      final List<Budget> sortedBudgets = List.from(Budget.values)
        ..sort((a, b) => a.priority - b.priority);

      for (final b in sortedBudgets) {
        if (b == budget) {
          continue;
        }

        if (excess <= 0) {
          break;
        }

        if (_budgets[b]! <= 0) {
          continue;
        }

        final int newBudget = _budgets[b]! - excess;
        excess -= _budgets[b]! - newBudget;
        _budgets[b] = newBudget >= 0 ? newBudget : 0;
      }
    }

    return _budgets;
  }

  bool incrementBudget(Budget budget) {
    if (_budgets[budget]! >= 10) return false;

    updateBudget(budget, _budgets[budget]! + 1);
    return true;
  }

  bool decrementBudget(Budget budget) {
    if (_budgets[budget]! <= 0) return false;

    updateBudget(budget, _budgets[budget]! - 1);
    return true;
  }
  /////////

  /// Education ///
  Education _education = Education.bachelors;

  Education get education => _education;

  /// Get the next level of [Education] of the player.
  Education getNextEducation() {
    return Education.values[(education.index + 1) % Education.values.length];
  }

  /// Increment the level of [Education] of the player.
  void incrementEducation() {
    _education = getNextEducation();
  }
  /////////

  /// Job ///
  Job _job = Job.unemployed;

  Job get job => _job;
  double get salary => _job.jobSalary;
  bool get hasJob => _job != Job.unemployed;

  // Update the player's [Job] value.
  void updateJob(Job newJob) {
    _job = newJob;
  }

  void creditSalary() {
    _unbudgetedSalary += job.jobSalary;
  }
  /////////

  /// Personal Life ///
  PersonalLife get personalLife => _personalLife;
  /////////
}
