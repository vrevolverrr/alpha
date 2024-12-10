import 'dart:math';

import 'package:alpha/logic/business_logic.dart';
import 'package:alpha/logic/common/interfaces.dart';
import 'package:alpha/logic/data/opportunity.dart';
import 'package:alpha/logic/economy_logic.dart';
import 'package:alpha/logic/financial_market_logic.dart';
import 'package:alpha/logic/players_logic.dart';
import 'package:logging/logging.dart';

class GameManager implements IManager {
  @override
  final Logger log = Logger("GameManager");

  /// Initial game states
  int _round = 0;
  int _turn = -1;

  int get round => _round;
  int get turn => _turn;

  /// Instantiate all managers
  final playerManager = PlayerManager();
  final marketManager = FinancialMarketManager();
  final economyManager = EconomyManager();
  final businessManager = BusinessManager();
  // final eventsManager = AlphaEventsManager();

  void startGame() {
    log.info("Game has started with ${playerManager.getPlayerCount()} players");
    nextTurn();
  }

  void onNextTurn() {
    /// Add turn specifc logic here
  }

  void onNextRound() {
    /// Add round specific logic here
    for (Player player in playerManager.getAllPlayers()) {
      player.creditInterest();
      player.creditSalary();
    }

    economyManager.updateCycle();
    marketManager.updateMarket();
    // businessManager.creditBusinessEarnings();
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
    int roll = Random().nextInt(6) + 1;
    log.info("Dice rolled with result: $roll");

    return roll;
  }

  String wheelSpin() {
    List<String> mylist = ['1.0x', '1.5x', '0.8x', '0.6x'];
    mylist.shuffle();
    return mylist.first;
  }

  Opportunity getOpportunityPrize() {
    List<Opportunity> myList = List<Opportunity>.from(Opportunity.values);
    myList.shuffle();
    return myList.first;
  }

  bool hasWinner() {
    // perform some check logic on each player
    return false;
  }
}
