import 'dart:math';

import 'package:alpha/logic/common/interfaces.dart';
import 'package:alpha/logic/events_manager.dart';
import 'package:alpha/logic/financial_market_logic.dart';
import 'package:alpha/logic/players_logic.dart';
import 'package:logging/logging.dart';

class GameManager implements IManager {
  /// Initial game states
  int _round = 0;
  int _turn = -1;

  int get round => _round;
  int get turn => _turn;

  /// Instantiate all managers
  final playerManager = PlayerManager();
  final marketManager = FinancialMarketManager();
  final eventsManager = AlphaEventsManager();

  @override
  final Logger log = Logger("GameManager");

  void startGame() {
    log.info("Game has started with ${playerManager.getPlayerCount()} players");
    nextTurn();
  }

  void nextTurn() {
    _turn = (_turn + 1) % playerManager.getPlayerCount();
    if (_turn == 0) _round++;
    playerManager.setActivePlayer(_turn);

    log.info(
        "Current round: $round, Current Turn: $_turn, Active Player: ${playerManager.getActivePlayer().name}");

    /// Update the events manager
    eventsManager.update();
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

  bool hasWinner() {
    // perform some check logic on each player
    return false;
  }
}
