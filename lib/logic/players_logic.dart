import 'dart:collection';

import 'package:alpha/logic/accounts_logic.dart';
import 'package:alpha/logic/budget_logic.dart';
import 'package:alpha/logic/career_logic.dart';
import 'package:alpha/logic/data/education.dart';
import 'package:alpha/logic/data/budget.dart';
import 'package:alpha/logic/data/job.dart';
import 'package:alpha/logic/education_logic.dart';
import 'package:alpha/logic/skills_logic.dart';
import 'package:alpha/logic/stats_logic.dart';
import 'package:flutter/foundation.dart';

/// The managing class for all [Player] related functionality.
class PlayerManager {
  final playersList = PlayersList();
  late Player _active;

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

  void registerPlayerEvent(Player player) {
    // TODO events manager
  }
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

class Player {
  final String _name;
  String get name => _name;

  Player(String name) : _name = name;

  final stats = PlayerStats();
  final savings = SavingsAccount(initial: 2000.0);
  final investments = InvestmentAccount(initial: 500.0, ownedShares: {});
  final skill = SkillLevel();
  final education = Education(initial: EducationDegree.uneducated);
  final career = Career(initial: Job.unemployed);
  final budgets = BudgetAllocation(budgets: {
    Budget.dailyExpenses: 2,
    Budget.selfImprovement: 2,
    Budget.recreational: 2,
    Budget.investments: 2,
    Budget.savings: 2
  });

  double get commitments => 671.0;
  double get disposable => career.salary - commitments;
  /////////
}
