import 'dart:collection';

import 'package:alpha/assets.dart';
import 'package:alpha/logic/budget_logic.dart';
import 'package:alpha/logic/common/interfaces.dart';
import 'package:alpha/services.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

enum PlayerGoals {
  family("Family", "Get married and start a family", AlphaAssets.goalFamily),
  career("Career", "Reach level 15 in skill level", AlphaAssets.goalCareer),
  wealth("Wealth", "Become a millionaire", AlphaAssets.goalWealth),
  ;

  final String title;
  final String description;
  final AlphaAssets image;
  const PlayerGoals(this.title, this.description, this.image);
}

enum PlayerAvatar {
  avatar1(AlphaAssets.avatarGreenBuns),
  avatar2(AlphaAssets.avatarOrangePonytail),
  avatar3(AlphaAssets.avatarBrownHair),
  avatar4(AlphaAssets.avatarBlackGuy),
  avatar5(AlphaAssets.avatarBlueTShirt),
  avatar6(AlphaAssets.avatarOrangeHoodie),
  avatar7(AlphaAssets.avatarBlueEarphones),
  avatar8(AlphaAssets.avatarBlueHairWhiteBlouse);

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

  void createPlayer(
      String name, PlayerAvatar avatar, PlayerColor color, PlayerGoals goal) {
    final newPlayer = Player(
        name: name, playerAvatar: avatar, playerColor: color, goal: goal);
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
  final PlayerGoals goal;

  Player(
      {required this.name,
      required this.playerColor,
      required this.playerAvatar,
      required this.goal});

  @override
  List<Object?> get props => [name, playerColor, playerAvatar];

  final budgets = BudgetAllocation(budgets: {
    Budget.dailyExpenses: 2,
    Budget.selfImprovement: 2,
    Budget.recreational: 2,
    Budget.investments: 2,
    Budget.savings: 2
  });
}
