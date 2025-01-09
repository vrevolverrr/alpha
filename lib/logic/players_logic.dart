import 'dart:collection';

import 'package:alpha/assets.dart';
import 'package:alpha/logic/accounts_logic.dart';
import 'package:alpha/logic/budget_logic.dart';
import 'package:alpha/logic/business_logic.dart';
import 'package:alpha/logic/common/interfaces.dart';
import 'package:alpha/logic/data/education.dart';
import 'package:alpha/logic/data/budget.dart';
import 'package:alpha/logic/data/personal_life.dart';
import 'package:alpha/logic/education_logic.dart';
import 'package:alpha/logic/personal_life_logic.dart';
import 'package:alpha/logic/skills_logic.dart';
import 'package:alpha/logic/stats_logic.dart';
import 'package:alpha/services.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

enum PlayerAvatar {
  pinkHair(AlphaAssets.avatarPinkHair),
  greenBuns(AlphaAssets.avatarGreenBuns),
  orangePonytail(AlphaAssets.avatarOrangePonytail),
  brownHair(AlphaAssets.avatarBrownHair),
  blackGuy(AlphaAssets.avatarBlackGuy);

  const PlayerAvatar(this.image);

  final AlphaAssets image;
}

enum PlayerColor {
  red(Color(0xFFF75C5C)),
  green(Color(0xFF7FC36A)),
  blue(Color(0xFF6DBDFA)),
  yellow(Color(0xFFF7F091)),
  pink(Color(0xFFF78DCE));

  const PlayerColor(this.color);

  final Color color;
}

enum PlayerLifeGoal { family, career, wealth }

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

  List<PlayerColor> getAvailableColors() {
    final takenColors = playersList.players.map((player) => player.playerColor);
    return PlayerColor.values
        .where((color) => !takenColors.contains(color))
        .toList();
  }

  List<PlayerAvatar> getAvailableAvatars() {
    final takenAvatars =
        playersList.players.map((player) => player.playerAvatar);
    return PlayerAvatar.values
        .where((avatar) => !takenAvatars.contains(avatar))
        .toList();
  }

  void createPlayer(String name, PlayerAvatar avatar, PlayerColor color) {
    final newPlayer =
        Player(name: name, playerAvatar: avatar, playerColor: color);
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

class Player extends Equatable {
  final String name;
  final PlayerColor playerColor;
  final PlayerAvatar playerAvatar;

  Player(
      {required this.name,
      required this.playerColor,
      required this.playerAvatar})
      : _logger = Logger("Player @$name");

  @override
  List<Object?> get props => [name, playerColor, playerAvatar];

  final Logger _logger;

  final stats = PlayerStats();

  /// Player accounts
  final savings = SavingsAccount(initial: 999999.0);
  final cpf = CPFAccount(initial: 0.0);
  final investments = InvestmentAccount(initial: 500.0);
  final debt = DebtAccount(initial: 0.0);

  final skill = SkillLevel();
  final education = Education(initial: EducationDegree.bachelors);

  final business = BusinessVentures();

  final personalLife = PersonalLife(initial: PersonalLifeStatus.single);

  final budgets = BudgetAllocation(budgets: {
    Budget.dailyExpenses: 2,
    Budget.selfImprovement: 2,
    Budget.recreational: 2,
    Budget.investments: 2,
    Budget.savings: 2
  });

  void pursueDegree() {
    EducationDegree degree = education.getNext();
    final bool success = savings.deduct(degree.cost);

    /// If player has not enough balance in savings
    if (!success) {
      _logger.warning(
          "Failed to pursueDegree, balance check failed, player has insufficient savings.");
      return;
    }

    /// Else, advance the player's degree and add skill points
    education.pursueNext();
    skill.add(degree.xp);

    _logger.info("Pursued ${degree.name}, new XP: ${skill.levelExp}");
  }

  void pursueOnlineCourse() {
    final bool success = savings.deduct(OnlineCourse.basic.cost);

    /// If player has not enough balance in savings
    if (!success) {
      _logger.warning(
          "Failed to pursueOnlineCourse, balance check failed, player has insufficient savings.");
      return;
    }

    /// Else, add skill points
    skill.add(OnlineCourse.basic.xp);
    _logger.info("Pursued online course, new XP: ${skill.levelExp}");
  }

  void nextLifeStage() {
    PersonalLifeStatus status = personalLife.getNext();

    // check if time balance is enough
    if (stats.time - status.pursueTimeConsumed < 0) {
      _logger.warning("Not enough time to be deducted");
      return;
    }

    // check if next status can be pursued
    if (status == personalLife.status) {
      _logger.warning("Unable to purse from ${personalLife.status}");
      return;
    }

    // else, update time and savings , then proceed to next stage in life
    stats.updateTime(-status.pursueTimeConsumed);
    savings.deduct(status.pursueCostRatio * savings.balance);
    personalLife.pursueNext();

    _logger.info("Moved on to ${personalLife.status}");
  }

  void revertLifeStage() {
    PersonalLifeStatus status = personalLife.getPrevious();

    // check if status can be reverted
    if (status == personalLife.status) {
      _logger.warning("Unable to revert from ${personalLife.status}");
      return;
    }

    stats.updateHappiness(-status.revertHappinessCost);
    stats.updateTime(status.revertTimeGain);
    savings.deduct(status.revertCostRatio * savings.balance);
    personalLife.revert();

    _logger.info("Successfully reverted to ${personalLife.status}");
  }

  // to be called every round base on personal life status
  void gainHappiness() {
    PersonalLifeStatus status = personalLife.status;
    stats.updateHappiness(status.pursueHappinessPR);
  }

  /// Updates the [Player]'s balance with the interest earnings
  void creditInterest() {
    savings.returnOnInterest();
    investments.returnOnInterest();

    _logger.info(
        "Credited interest earnings, current Savings: ${savings.balance} Investments: ${investments.balance}");
  }

  /** 
  void applyBudget(BudgetAllocation budget) {
    activePlayer.budgets.apply(budget);

    activePlayer.savings.deduct(disposable);
    activePlayer.savings.add(disposable * (budget[Budget.savings] / 10));
    activePlayer.investments
        .add(disposable * (budget[Budget.investments] / 10));

    activePlayer.savings.clearUnbudgeted();
    _logger.info(
        "Applied budget, new Savings: ${savings.balance}, new Investments: ${investments.balance}");
  }
  */
}
