import 'package:alpha/model/education.dart';
import 'dart:math';

class PlayerUpdates {
  final Player player;
  double _deltaSavings = 0;
  double _deltaSalary = 0;
  double _deltaCommitments = 0;
  int _deltaHappiness = 0;
  int _deltaTime = 0;
  bool _incrementEducation = false;
  Map<Budget, double> _deltaBudget = {};

  PlayerUpdates(this.player);

  PlayerUpdates setDeltaSavings(double delta) {
    _deltaSavings = delta;
    return this;
  }

  PlayerUpdates setDeltaSalary(double delta) {
    _deltaSalary = delta;
    return this;
  }

  PlayerUpdates setDeltaCommitments(double delta) {
    _deltaCommitments = delta;
    return this;
  }

  PlayerUpdates setDeltaHappiness(int delta) {
    _deltaHappiness = delta;
    return this;
  }

  PlayerUpdates setIncrementEducation(bool shouldIncrement) {
    _incrementEducation = shouldIncrement;
    return this;
  }

  PlayerUpdates setDeltaBudget(Map<Budget, double> delta) {
    _deltaBudget = delta;
    return this;
  }

  PlayerUpdates setDeltaTime(int delta) {
    _deltaTime = delta;
    return this;
  }

  double get deltaSavings => _deltaSavings;
  double get deltaSalary => _deltaSalary;
  double get deltaCommitments => _deltaCommitments;
  int get deltaHappiness => _deltaHappiness;
  int get deltaTime => _deltaTime;
  bool get incrementEducation => _incrementEducation;

  double get newSavings => player.savings + _deltaSavings;
  double get newSalary => player.salary + _deltaSalary;
  double get newCommitments => player.commitments + _deltaCommitments;
  int get newHappiness => player.happiness + _deltaHappiness;
  int get newTime => player.time + _deltaTime;
  Education get newEducation => _incrementEducation
      ? Education
          .values[min(player.education.index + 1, Education.values.length - 1)]
      : player.education;

  Map<Budget, double> get newBudgets {
    final Map<Budget, double> newBudgets = Map.from(player.budgets);

    _deltaBudget.forEach((key, value) {
      newBudgets[key] = value;
    });
    return newBudgets;
  }
}

enum Budget {
  savings("Savings"),
  dailyExpenses("Daily Expenses"),
  investments("Investment"),
  recreational("Recreational"),
  selfImprovement("Self Improvement");

  final String title;

  const Budget(this.title);
}

class Player {
  final String _name;

  // TODO set default values
  Education _education = Education.bachelors;
  double _savings = 2000.0;
  double _salary = 2400.0;
  double _commitments = 671.0;
  int _happiness = 100;
  int _time = 500;

  final Map<Budget, double> _budgets = {
    Budget.savings: 0.0,
    Budget.dailyExpenses: 0.0,
    Budget.investments: 0.0,
    Budget.recreational: 0.0,
    Budget.selfImprovement: 0.0
  };

  Player(this._name);

  String get name => _name;
  Education get education => _education;
  double get savings => _savings;
  double get salary => _salary;
  double get commitments => _commitments;
  int get happiness => _happiness;
  int get time => _time;
  Map<Budget, double> get budgets => _budgets;

  void update(PlayerUpdates updates) {
    _savings = updates.newSavings;
    _salary = updates.newSalary;
    _commitments = updates.newCommitments;
    _education = updates.newEducation;
    _happiness = updates.newHappiness;
    _time = updates.newTime;

    updates.newBudgets.forEach((key, value) {
      _budgets[key] = value;
    });
  }
}
