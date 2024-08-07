import 'dart:math';

import 'package:alpha/logic/financial_market_logic.dart';
import 'package:alpha/logic/players_logic.dart';

class GameManager {
  /// Initial game states
  int _round = 1;
  int _turn = 0;

  int get round => _round;
  int get turn => _turn;

  /// Instantiate all managers
  final playerManager = PlayerManager();
  final marketManager = FinancialMarketManager();

  void startGame() {
    playerManager.setActivePlayer(0);
  }

  void nextTurn() {
    if (_turn == 0) _round++;

    _turn += (_turn + 1) % playerManager.getPlayerCount();
    playerManager.setActivePlayer(_turn);
    // trigger some game events
  }

  int rollDice() {
    return Random().nextInt(6) + 1;
  }

  bool hasWinner() {
    // perform some check logic on each player
    return false;
  }
}
