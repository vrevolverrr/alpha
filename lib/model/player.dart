import 'package:alpha/model/education.dart';
import 'dart:math';

import 'package:alpha/model/job.dart';

class PlayerUpdates {
  double _deltaSavings = 0;
  double _deltaSalary = 0;
  double _deltaCommitments = 0;
  int _deltaHappiness = 0;
  int _deltaTime = 0;
  bool _incrementEducation = false;
  Map<Budget, double> _deltaBudget = {};
  Job? _newJob;

  PlayerUpdates();

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

  PlayerUpdates setJob(Job job) {
    _newJob = job;
    return this;
  }

  double get deltaSavings => _deltaSavings;
  double get deltaSalary => _deltaSalary;
  double get deltaCommitments => _deltaCommitments;
  int get deltaHappiness => _deltaHappiness;
  int get deltaTime => _deltaTime;
  bool get incrementEducation => _incrementEducation;
  Job? get newJob => _newJob;
  Map<Budget, double> get deltaBudget => _deltaBudget;
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

  Education _education = Education.bachelors;
  Job _job = Job.unemployed;

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
  Job get job => _job;
  Map<Budget, double> get budgets => _budgets;

  void update(PlayerUpdates updates) {
    _savings += updates.deltaSavings;
    _salary += updates.deltaSalary;
    _commitments += updates.deltaCommitments;
    _happiness += updates.deltaHappiness;

    if (updates.newJob != null) {
      _job = updates.newJob as Job;
    }

    _education = updates.incrementEducation
        ? Education
            .values[min(education.index + 1, Education.values.length - 1)]
        : education;

    updates.deltaBudget.forEach((key, value) {
      _budgets[key] = value;
    });
  }
}
