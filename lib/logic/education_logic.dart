import 'dart:math';

import 'package:alpha/logic/data/education.dart';
import 'package:flutter/foundation.dart';

class Education extends ChangeNotifier {
  EducationDegree _level;

  Education({required EducationDegree initial}) : _level = initial;

  EducationDegree get level => _level;

  EducationDegree getNext() {
    return EducationDegree
        .values[min(_level.index + 1, EducationDegree.values.length - 1)];
  }

  /// Advance the player's [EducationDegree] to the next
  void pursueNext() {
    _level = getNext();
    notifyListeners();
  }
}
