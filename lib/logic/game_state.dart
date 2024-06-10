import 'dart:collection';
import 'dart:math';

import 'package:alpha/logic/financial_market.dart';
import 'package:alpha/logic/player.dart';
import 'package:flutter/material.dart';

class GameState extends ChangeNotifier {
  /// Game Objects ///
  final FinancialMarket financialMarket = FinancialMarket();
  //////

  /// Game State ///
  /// The current round number.
  int _roundNumber = 0;
  int get round => _roundNumber;
  int get turn => (_roundNumber - 1) * numPlayers + (activePlayerIndex + 1);

  /// Increment the state of the game, ie: go to next turn.
  void incrementGameState() {
    financialMarket.incrementMarket();

    _activePlayerIndex = (_activePlayerIndex + 1) % players.length;

    /// Increment the round number if back at first player.
    if (_activePlayerIndex == 0) {
      _roundNumber++;
    }
  }

  int rollDice() {
    return Random().nextInt(6) + 1;
  }
  //////

  /// Players ///
  final List<Player> _playerList = [];
  UnmodifiableListView<Player> get players => UnmodifiableListView(_playerList);
  int get numPlayers => _playerList.length;

  /// Creates a new [Player] instance for the game.
  bool createPlayer(String name) {
    if (_playerList.length > 5) return false;

    final Player player = Player(name);

    /// Register an event listner to each player to listen to changes.
    /// Notify [GameState] listners to such changes in each [Player].
    player.addListener(() => notifyListeners());
    _playerList.add(player);

    return true;
  }

  /// Returns the [Player] instance give the index.
  Player getPlayer(int index) {
    if (index >= _playerList.length) _playerList.last;
    return _playerList[index];
  }

  /// Returns the [Player] instance with the `name` provided.
  Player? getPlayerByName(String name) {
    for (int i = 0; i < _playerList.length; i++) {
      if (_playerList[i].name == name) return _playerList[i];
    }

    return null;
  }
  //////

  /// Active Player ///
  int _activePlayerIndex = 0;

  /// The index of currently active player.
  int get activePlayerIndex => _activePlayerIndex;

  /// The [Player] instance of the currently active player.
  Player get activePlayer => _playerList[_activePlayerIndex];
  //////
}
