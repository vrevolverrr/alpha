import 'package:flutter/material.dart';

class SkillLevel extends ChangeNotifier {
  static int xpPerLevel = 1000;

  int _value = 0;

  int get totalExp => _value;
  int get levelExp => _value % xpPerLevel;
  double get levelPercent => levelExp / xpPerLevel;
  int get level => _value ~/ xpPerLevel + 1;

  void add(int delta) {
    assert(delta > 0);
    _value += delta;
    notifyListeners();
  }
}
