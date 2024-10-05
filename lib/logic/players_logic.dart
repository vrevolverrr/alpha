import 'dart:collection';

import 'package:alpha/logic/accounts_logic.dart';
import 'package:alpha/logic/budget_logic.dart';
import 'package:alpha/logic/career_logic.dart';
import 'package:alpha/logic/common/interfaces.dart';
import 'package:alpha/logic/data/education.dart';
import 'package:alpha/logic/data/budget.dart';
import 'package:alpha/logic/data/job.dart';
import 'package:alpha/logic/education_logic.dart';
import 'package:alpha/logic/events_manager.dart';
import 'package:alpha/logic/skills_logic.dart';
import 'package:alpha/logic/stats_logic.dart';
import 'package:alpha/services.dart';
import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

/// The managing class for all [Player] related functionality.
class PlayerManager implements IManager {
  final playersList = PlayersList();
  late Player _active;

  @override
  final Logger log = Logger("PlayerManager");

  UnmodifiableListView<Player> getAllPlayers() => playersList.players;
  int getPlayerCount() => playersList.numPlayers;
  Player getActivePlayer() => _active;

  void setActivePlayer(int? turn) {
    turn = turn ?? gameManager.turn;

    if (turn != gameManager.turn) {
      log.warning(
          "setActivePlayer called for an inactive player! Expected: ${gameManager.turn}; Actual: $turn");
    }

    _active = playersList.get(turn);
  }

  void createPlayer(String name) {
    final newPlayer = Player(name);
    playersList.addPlayer(newPlayer);

    log.info("New player $name added to PlayerList");
  }

  void removePlayer(String name) {
    /// Remove the fist occurrence of [Player] from the [PlayerList] with the given name
    playersList.removePlayerByName(name);

    log.info("Player $name removed from PlayerList");
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
  final Logger _logger;

  String get name => _name;

  Player(String name)
      : _name = name,
        _logger = Logger("Player @$name");

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

  void setCareer(Job job) {
    career.set(job);
    eventsManager.subscribe(AlphaEventCreditSalary(target: this));
    _logger.info("Set carrer to ${job.jobTitle}");
  }

  void pursueDegree() {
    EducationDegree degree = education.getNext();
    final bool success = savings.deduct(degree.cost);

    /// If player has not enough balance in savings
    if (!success) {
      _logger.warning(
          "Failed to pursueDegree, balance check failed, player has insufficient savings.");
      return;
    }

    /// Else, Advance the player's degree and add skill points
    education.pursueNext();
    skill.add(degree.xp);
  }

  void pursueOnlineCourse() {}
}
