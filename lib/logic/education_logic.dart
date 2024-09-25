import 'package:alpha/logic/data/education.dart';
import 'package:flutter/foundation.dart';

class Education extends ChangeNotifier {
  EducationDegree _level;

  Education({required EducationDegree initial}) : _level = initial;

  EducationDegree get level => _level;

  EducationDegree getNext() {
    return EducationDegree
        .values[(_level.index + 1) % EducationDegree.values.length];
  }

  void pursueNext() => _level = getNext();
}
