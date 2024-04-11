import 'dart:collection';

import 'package:alpha/model/player.dart';
import 'package:flutter/material.dart';

class GameState extends ChangeNotifier {
  final List<Player> _playerList = [];
  int _activePlayerIndex = 0;

  GameState({required List<String> playerNames}) {
    for (String p in playerNames) {
      createPlayer(p);
    }
  }

  UnmodifiableListView<Player> get players => UnmodifiableListView(_playerList);

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

  Player getActivePlayer() {
    return _playerList[_activePlayerIndex];
  }

  void updatePlayer() {}

  int incrementGameState() {
    // TODO idk
    return ++_activePlayerIndex;
  }
}
