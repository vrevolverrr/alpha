import 'package:alpha/logic/common/interfaces.dart';
import 'package:alpha/logic/data/board_tiles.dart';
import 'package:alpha/logic/players_logic.dart';
import 'package:alpha/services.dart';
import 'package:logging/logging.dart';

class PlayerLocation {
  final Player player;
  int _location = -1;

  int get location => _location;

  PlayerLocation(this.player);

  void updateLocation(int newIndex) {
    _location = newIndex;
  }
}

class BoardManager implements IManager {
  final Logger log = Logger("BoardManager");

  final Map<BoardTile, List<int>> _boardTiles = {
    BoardTile.careerTile: [0, 8, 12, 19],
    BoardTile.educationTile: [1, 7, 13],
    BoardTile.opportunityTile: [3, 15],
    BoardTile.personalLifeTile: [5, 17],
    BoardTile.worldEventTile: [4, 16],
    BoardTile.realEstatesTile: [11, 20],
    BoardTile.carTile: [10, 21],
    BoardTile.businessEcommerceTile: [2],
    BoardTile.businessTechnologyTile: [9],
    BoardTile.businessFnBTile: [6],
    BoardTile.businessPharmaTile: [14],
    BoardTile.businessSocialMediaTile: [18],
  };

  final List<PlayerLocation> _playerLocations = [];

  void initialisePlayerLocations(List<Player> players) {
    for (final player in players) {
      _playerLocations.add(PlayerLocation(player));
    }
  }

  void movePlayer(Player player, int steps) {
    final playerLocation = _playerLocations.firstWhere(
      (playerLocation) => playerLocation.player == player,
    );

    final currentLocation = playerLocation.location;
    final newLocation = (currentLocation + steps) % 22;

    playerLocation.updateLocation(newLocation);

    log.info(
        "Player ${player.name} moved from $currentLocation to $newLocation, ${getTile(player)}");
  }

  BoardTile getTile(Player player) {
    PlayerLocation activePlayerLocation = _playerLocations.firstWhere(
      (playerLocation) => playerLocation.player == player,
    );

    for (BoardTile tile in _boardTiles.keys) {
      if (_boardTiles[tile]!.contains(activePlayerLocation.location)) {
        return tile;
      }
    }

    /// Fallback
    return BoardTile.educationTile;
  }

  BoardTile getActivePlayerTile() {
    return getTile(playerManager.getActivePlayer());
  }
}
