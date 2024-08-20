import 'package:flutter/material.dart';

class SkillLevel extends ChangeNotifier {
  int _value = 0;

  int get totalExp => _value;
  int get levelExp => _value % 1000;
  double get levelPercent => levelExp / 1000;
  int get level => _value ~/ 1000 + 1;

  void add(int delta) {
    assert(delta > 0);
    _value += delta;
    notifyListeners();
  }
}
