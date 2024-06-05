import 'package:alpha/logic/education.dart';
import 'dart:math';

import 'package:alpha/logic/job.dart';
import 'package:alpha/logic/personal_life.dart';

class PlayerUpdates {
  /// Changes to [savings] of [Player] instance
  double _deltaAssets = 0;

  /// Changes to [commitments] of [Player] instance
  double _deltaCommitments = 0;

  /// Changes to [time] of [Player] instance
  int _deltaTime = 0;

  /// Should increment [education] of [Player] instance
  bool _incrementEducation = false;

  /// Changes to [budgets] of [Player] instance
  Map<Budget, double> _deltaBudget = {};

  /// Changes to [job] of [Player] instance
  Job? _newJob;

  /// Changes to [personalLife] of [Player] instance
  PersonalLife? _newPersonalLife;

  PlayerUpdates();

  PlayerUpdates setDeltaSavings(double delta) {
    _deltaAssets = delta;
    return this;
  }

  PlayerUpdates setDeltaCommitments(double delta) {
    _deltaCommitments = delta;
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

  PlayerUpdates setPersonalLife(PersonalLife personalLife) {
    _newPersonalLife = personalLife;
    return this;
  }

  double get deltaAssets => _deltaAssets;
  double get deltaCommitments => _deltaCommitments;
  int get deltaTime => _deltaTime;
  bool get incrementEducation => _incrementEducation;
  Job? get newJob => _newJob;
  PersonalLife? get newPersonalLife => _newPersonalLife;
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
  static const int kMaxTime = 500;
  static const int kBaseHappiness = 100;

  final String _name;

  Education _education = Education.bachelors;
  Job _job = Job.unemployed;
  PersonalLife _personalLife = PersonalLife.single;

  double _assets = 2000.0;
  double _salary = 0;
  double _commitments = 671.0;

  int _happiness = Player.kBaseHappiness;
  int _time = Player.kMaxTime;

  final Map<Budget, double> _budgets = {
    Budget.savings: 0.0,
    Budget.dailyExpenses: 0.0,
    Budget.investments: 0.0,
    Budget.recreational: 0.0,
    Budget.selfImprovement: 0.0
  };

  Player(this._name);

  String get name => _name;

  Job get job => _job;
  Education get education => _education;
  PersonalLife get personalLife => _personalLife;

  double get assets => _assets;

  double get salary => _salary;
  double get commitments => _commitments;

  int get happiness => _happiness;
  int get time => _time;

  Map<Budget, double> get budgets => _budgets;

  void update(PlayerUpdates updates) {
    /// Apply changes to [savings] and [commitments]
    _assets += updates.deltaAssets;
    _commitments += updates.deltaCommitments;

    /// Apply changes to [job] if required
    if (updates.newJob != null) {
      _job = updates.newJob as Job;
    }

    /// Apply changes to [salary] based on current assigned [job]
    _salary = _job.jobSalary;

    /// Apply changes to [personalLife] if required
    if (updates.newPersonalLife != null) {
      _personalLife = updates.newPersonalLife as PersonalLife;
    }

    /// Increment [education] if required, capped by max [Education] level
    _education = updates.incrementEducation
        ? Education
            .values[min(education.index + 1, Education.values.length - 1)]
        : education;

    /// Apply changes to [budget]
    updates.deltaBudget.forEach((key, value) {
      _budgets[key] = value;
    });

    /// Apply changes to [time] based on current assigned [job] and
    /// [personalLife]
    _time = Player.kMaxTime - _job.timeConsumed - _personalLife.timeConsumed;

    // Apply changes to [happiness] based on current assigned [personalLife]
    _happiness = Player.kBaseHappiness + _personalLife.happiness;
  }
}
