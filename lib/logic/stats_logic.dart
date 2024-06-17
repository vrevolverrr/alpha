import 'package:flutter/foundation.dart';

class PlayerStats extends ChangeNotifier {
  static const int kMaxTime = 500;
  static const int kBaseHappiness = 100;

  int _happiness = kBaseHappiness;
  int _time = kMaxTime;

  PlayerStats();

  int get happiness => _happiness;
  int get time => _time;

  void updateTime(int delta) {
    _time += delta;
    notifyListeners();
  }

  void updateHappiness(int delta) {
    _happiness += delta;
    notifyListeners();
  }
}
