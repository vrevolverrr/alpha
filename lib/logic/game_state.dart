import 'dart:collection';
import 'dart:math';

import 'package:alpha/logic/player.dart';

class GameState {
  final List<Player> _playerList = [];
  int _activePlayerIndex = 0;

  GameState();

  UnmodifiableListView<Player> get players => UnmodifiableListView(_playerList);
  int get numPlayers => _playerList.length;
  Player get activePlayer => _playerList[_activePlayerIndex];
  int get activePlayerIndex => _activePlayerIndex;

  Player? getPlayer(int index) {
    if (index >= _playerList.length) return null;
    return _playerList[index];
  }

  Player? getPlayerByName(String name) {
    for (int i = 0; i < _playerList.length; i++) {
      if (_playerList[i].name == name) return _playerList[i];
    }

    return null;
  }

  bool createPlayer(String name) {
    if (_playerList.length > 5) return false;
    _playerList.add(Player(name));

    return true;
  }

  void updatePlayer(Player player, PlayerUpdates updates) {
    player.update(updates);
  }

  int incrementGameState() {
    _activePlayerIndex = (_activePlayerIndex + 1) % players.length;
    return _activePlayerIndex;
  }

  int rollDice() {
    return Random().nextInt(6) + 1;
  }
}
