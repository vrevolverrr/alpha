import 'package:flutter/material.dart';

class SkillLevel extends ChangeNotifier {
  int _totalExp = 2450;

  int get totalExp => _totalExp;
  int get levelExp => _totalExp % 1000;
  double get expPercent => levelExp / 1000;
  int get level => _totalExp ~/ 1000;

  void addExp(int delta) {
    _totalExp += delta;
    notifyListeners();
  }
}
