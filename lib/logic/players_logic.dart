import 'dart:collection';

import 'package:alpha/logic/enums/education.dart';
import 'package:alpha/logic/enums/budget.dart';
import 'package:alpha/logic/enums/job.dart';
import 'package:alpha/logic/stocks.dart';
import 'package:alpha/utils.dart';
import 'package:flutter/foundation.dart';

/// The managing class for all [Player] related functionality.
class PlayerManager {
  final playersList = PlayersList();
  Player _active = Player.invalid();

  UnmodifiableListView<Player> getAllPlayers() => playersList.players;
  int getPlayerCount() => playersList.numPlayers;
  Player getActivePlayer() => _active;

  void setActivePlayer(int turn) {
    /// TODO add validation logic
    _active = playersList.get(turn);
  }

  void createPlayer(String name) {
    final newPlayer = Player(name);
    playersList.addPlayer(newPlayer);
  }

  void removePlayer(String name) {
    playersList.removePlayerByName(name);
  }

  void registerPlayerEvent(Player player) {}
}

/// This class manages the collection of currently active [Player]s of the game.
class PlayersList extends ChangeNotifier {
  final List<Player> _players = [];
  int _numPlayers = 0;

  int get numPlayers => _numPlayers;
  UnmodifiableListView<Player> get players => UnmodifiableListView(_players);

  Player get(int index) => _players[index];

  void addPlayer(Player player) {
    _numPlayers++;
    _players.add(player);
    notifyListeners();
  }

  void removePlayerByName(String name) {
    _players.remove(_players.firstWhere((player) => player.name == name));
    notifyListeners();
  }
}

/// The actual class that encapsulates player data and actions.
/// Each mutable field is stored as a [ValueNotifier] that implements
/// the [Listenable] interface.
class Player {
  /// Game player constants
  static const int kMaxTime = 500;
  static const int kBaseHappiness = 100;

  final String _name;
  String get name => _name;

  /// Default constructor
  Player(String name) : _name = name;

  /// Named consturctor for an invalid player
  Player.invalid() : _name = "";

  /// Player stats ///
  final _happiness = ValueNotifier<int>(Player.kBaseHappiness);
  final _time = ValueNotifier<int>(Player.kMaxTime);

  ValueNotifier<int> get lTime => _time;
  int get time => _time.value;

  ValueNotifier<int> get lHappiness => _happiness;
  int get happiness => _happiness.value;

  void updateHappiness(int delta) {
    _happiness.value += delta;
  }

  void updateTime(int delta) {
    _time.value += delta;
  }
  /////////

  /// Financial ///
  final _savings = ValueNotifier<double>(2000.0); // savings account
  final _investments = ValueNotifier<double>(500.0); // investment account

  // Maps stock does to units owned
  final Map<String, int> _ownedShares = {};

  double get savings => _savings.value;
  ValueNotifier<double> get lSavings => _savings;

  double get investments => _investments.value;
  ValueNotifier<double> get lInvestments => _investments;

  double get commitments => 671.0;
  double get disposable => salary - commitments;
  double get totalAssets => _savings.value + _investments.value;
  Map<String, int> get ownedShares => _ownedShares;

  void addSavings(double amt) {
    _savings.value += amt;
  }

  bool deductSavings(double amt) {
    if (amt > _savings.value) {
      return false;
    }

    _savings.value -= amt;
    return true;
  }

  void addInvestmentAcc(double amt) {
    _investments.value += amt;
  }

  bool deductInvestmentAcc(double amt) {
    if (amt > _investments.value) {
      return false;
    }

    _investments.value -= amt;
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
  final _budgets = BudgetAllocationNotifier();
  UnmodifiableMapView<Budget, int> get budgets => _budgets.value;

  void setBudget(BudgetAllocationNotifier tempBudget) {
    assert(tempBudget.valid.value);
    _budgets.copyValues(tempBudget);
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
  /////////
}

class BudgetAllocationNotifier extends ChangeNotifier {
  late final Map<Budget, int> _budgets;
  final valid = ValueNotifier<bool>(true);

  BudgetAllocationNotifier({UnmodifiableMapView<Budget, int>? budgets}) {
    assert(Budget.values.length % 5 == 0);

    _budgets = Map.from(budgets ??
        {for (final b in Budget.values) b: 10 ~/ Budget.values.length});
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
  void copyValues(BudgetAllocationNotifier budgets) {
    _budgets = Map<Budget, int>.from(budgets.value);
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
