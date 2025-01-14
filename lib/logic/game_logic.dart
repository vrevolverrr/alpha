import 'dart:collection';
import 'dart:math';

import 'package:alpha/logic/accounts_logic.dart';
import 'package:alpha/logic/board_logic.dart';
import 'package:alpha/logic/budget_logic.dart';
import 'package:alpha/logic/car_logic.dart';
import 'package:alpha/logic/career_logic.dart';
import 'package:alpha/logic/data/personal_life.dart';
import 'package:alpha/logic/education_logic.dart';
import 'package:alpha/logic/hints_logic.dart';
import 'package:alpha/logic/loan_logic.dart';
import 'package:alpha/logic/opportunity_logic.dart';
import 'package:alpha/logic/personal_life_logic.dart';
import 'package:alpha/logic/real_estate_logic.dart';
import 'package:alpha/logic/business_logic.dart';
import 'package:alpha/logic/common/interfaces.dart';
import 'package:alpha/logic/data/quiz.dart';
import 'package:alpha/logic/economy_logic.dart';
import 'package:alpha/logic/financial_market_logic.dart';
import 'package:alpha/logic/players_logic.dart';
import 'package:alpha/logic/skills_logic.dart';
import 'package:alpha/logic/stats_logic.dart';
import 'package:alpha/logic/world_event_logic.dart';
import 'package:alpha/services.dart';
import 'package:logging/logging.dart';

class DiceRollResult {
  final int roll;
  final int round;
  final int turn;

  DiceRollResult(this.roll, this.round, this.turn);
}

class GameLeaderboard {
  final Player player;
  final double points;
  final double totalAssets;
  final double totalDebt;
  final double debtPenalty;
  final double goalBonus;
  final PlayerGoals playerGoal;
  final int cumulativeEsgScore;
  final int happinessFactor;

  GameLeaderboard(
    this.player,
    this.points, {
    required this.totalAssets,
    required this.totalDebt,
    required this.debtPenalty,
    required this.goalBonus,
    required this.playerGoal,
    required this.cumulativeEsgScore,
    required this.happinessFactor,
  });
}

class GameManager implements IManager {
  @override
  final Logger log = Logger("GameManager");

  /// Initial game states
  int _round = 0;
  int _turn = -1;

  int get round => _round;
  int get turn => _turn;

  DiceRollResult lastDiceRoll = DiceRollResult(0, 0, -1);

  /// Leaderboard for the game, generated when the game ends
  final List<GameLeaderboard> _leaderboard = [];
  List<GameLeaderboard> get leaderboard => UnmodifiableListView(_leaderboard);

  /// Instantiate all managers
  final playerManager = PlayerManager();
  final careerManager = CareerManager();
  final marketManager = FinancialMarketManager();
  final economyManager = EconomyManager();
  final businessManager = BusinessManager();
  final realEstateManager = RealEstateManager();
  final carManager = CarManager();
  final hintsManager = HintsManager();
  final opportunityManager = OpportunityManager();
  final boardManager = BoardManager();
  final accountsManager = AccountsManager();
  final loanManager = LoanManager();
  final skillManager = SkillManager();
  final statsManager = StatsManager();
  final educationManager = EducationManager();
  final budgetManager = BudgetManager();
  final personalLifeManager = PersonalLifeManager();
  final worldEventManager = WorldEventManager();

  void startGame() {
    final List<Player> players = playerManager.getAllPlayers();

    boardManager.initialisePlayerLocations(players);
    accountsManager.initialisePlayerAccounts(players);
    skillManager.initialisePlayerSkills(players);
    businessManager.initialisePlayerBusinesses(players);
    educationManager.initialisePlayerEducations(players);
    loanManager.initialisePlayerDebts(players);
    personalLifeManager.initialisePlayerPersonalLife(players);
    statsManager.initialisePlayerStats(players);

    log.info("Game has started with ${playerManager.getPlayerCount()} players");
    nextTurn();
  }

  void endGame() {
    /// Calculate player points
    ///
    int numPlayers = playerManager.getAllPlayers().length;

    final int cumulativeEsgScore = playerManager.getAllPlayers().fold(
        0, (prev, player) => prev + statsManager.getPlayerStats(player).esg);

    for (Player player in playerManager.getAllPlayers()) {
      double points = 0.0;

      final int happiness = statsManager.getPlayerStats(player).happiness;

      final double totalAssets = accountsManager.getAvailableBalance(player) +
          accountsManager.getPlayerAccount(player).cpf.balance +
          businessManager.getTotalBusinessValuation(player) +
          realEstateManager.getTotalAssetValue(player) +
          carManager.getTotalAssetValue(player);

      final int happinessFactor =
          min(1, happiness - PlayerStats.kBaseHappiness + 1);
      points += totalAssets * happinessFactor;

      if (cumulativeEsgScore > numPlayers * 80) {
        points *= 1.2;
      }

      final double remainingDebt = loanManager.getTotalDebt(player);
      final double debtPenalty =
          (remainingDebt / (totalAssets + remainingDebt + 1)) *
              remainingDebt *
              2.0;

      points -= debtPenalty;

      double goalBonus = 0.0;

      if (player.goal == PlayerGoals.wealth && totalAssets >= 1000000) {
        goalBonus += 100.0;
      } else if (player.goal == PlayerGoals.family &&
          personalLifeManager.getPersonalLife(player).status ==
              PersonalLifeStatus.family) {
        goalBonus += 100.0;
      } else if (player.goal == PlayerGoals.career &&
          skillManager.getPlayerSkill(player).level >= 15) {
        goalBonus += 100.0;
      }

      points += goalBonus;

      _leaderboard.add(GameLeaderboard(player, points,
          totalAssets: totalAssets,
          totalDebt: remainingDebt,
          debtPenalty: debtPenalty,
          goalBonus: goalBonus,
          playerGoal: player.goal,
          happinessFactor: happinessFactor,
          cumulativeEsgScore: cumulativeEsgScore));
    }
  }

  void onNextTurn() {
    /// Add turn specifc logic here
  }

  void onNextRound() {
    /// Add round specific logic here
    accountsManager.creditInterest();
    careerManager.creditSalary();
    economyManager.updateCycle();
    marketManager.updateMarket();
    businessManager.creditBusinessEarnings();

    loanManager.autoRepayLoans();

    businessManager.businessStates.forEach((sector, sectorState) =>
        sectorState.updateState(economyManager.current));

    for (Player player in playerManager.getAllPlayers()) {
      skillManager.addExp(player, 500);
    }
  }

  /// This method updates all relavant systems and increments the game turn.
  void nextTurn() {
    _turn = (_turn + 1) % playerManager.getPlayerCount();

    if (_turn == 0) {
      /// Run all round triggered events, skip the starting round
      if (round != 0) onNextRound();

      /// Next round
      _round++;
    }

    playerManager.setActivePlayer(_turn);
    // eventsManager.update();

    /// Run all turn triggered events
    onNextTurn();

    log.info(
        "Current round: $round, Current Turn: $_turn, Active Player: ${playerManager.getActivePlayer().name}");
  }

  int rollDice() {
    if (turn == lastDiceRoll.turn && round == lastDiceRoll.round) {
      log.warning("Player has already rolled the dice this turn");
      return lastDiceRoll.roll;
    }

    int roll = Random().nextInt(6) + 1;
    lastDiceRoll = DiceRollResult(roll, round, turn);

    log.info("Dice rolled with result: $roll");

    boardManager.movePlayer(activePlayer, roll);
    return roll;
  }

  int getLastDiceRoll() {
    return lastDiceRoll.roll;
  }

  Quiz getQuizQuestion() {
    List<Quiz> questionSet = List<Quiz>.from(Quiz.values);
    questionSet.shuffle();
    return questionSet.first;
  }

  bool hasWinner() {
    // perform some check logic on each player
    return false;
  }
}
