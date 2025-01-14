import 'package:alpha/logic/players_logic.dart';
import 'package:flutter/foundation.dart';

class PlayerStats extends ChangeNotifier {
  static const int kBaseHappiness = 100;
  static const int kBaseESG = 0;

  int _happiness = kBaseHappiness;
  int _esg = kBaseESG;

  PlayerStats({int? happiness, int? esg}) {
    _happiness = happiness ?? kBaseHappiness;
    _esg = esg ?? kBaseESG;
  }

  int get happiness => _happiness;
  int get esg => _esg;

  void updateHappiness(int delta) {
    _happiness += delta;
    notifyListeners();
  }

  void updateESG(int delta) {
    _esg += delta;
    notifyListeners();
  }
}

class StatsManager {
  final Map<Player, PlayerStats> _stats = {};

  void initialisePlayerStats(List<Player> players) {
    for (Player player in players) {
      _stats[player] = PlayerStats();
    }
  }

  PlayerStats getPlayerStats(Player player) {
    if (!_stats.containsKey(player)) {
      _stats[player] = PlayerStats();
    }

    return _stats[player]!;
  }

  void addHappiness(Player player, int delta) {
    _stats[player]!.updateHappiness(delta);
  }

  void deductHappiness(Player player, int delta) {
    _stats[player]!.updateHappiness(-delta);
  }

  void addESG(Player player, int delta) {
    _stats[player]!.updateESG(delta);
  }

  void deductESG(Player player, int delta) {
    _stats[player]!.updateESG(-delta);
  }
}
