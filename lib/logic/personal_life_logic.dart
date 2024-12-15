import 'package:alpha/logic/data/personal_life.dart';
import 'package:flutter/foundation.dart';

class PersonalLife extends ChangeNotifier {
  PersonalLifeStatus _status;

  PersonalLife({required PersonalLifeStatus initial}) : _status = initial;

  PersonalLifeStatus get status => _status;

  /// Map to define the next possible status for each state
  static const Map<PersonalLifeStatus, PersonalLifeStatus> nextStatusMap = {
    PersonalLifeStatus.single: PersonalLifeStatus.dating,
    PersonalLifeStatus.divorced: PersonalLifeStatus.dating,
    PersonalLifeStatus.dating: PersonalLifeStatus.marriage,
    PersonalLifeStatus.marriage: PersonalLifeStatus.family,
  };

  /// Map to define the previous possible status for each state
  static const Map<PersonalLifeStatus, PersonalLifeStatus> previousStatusMap = {
    PersonalLifeStatus.dating: PersonalLifeStatus.single,
    PersonalLifeStatus.marriage: PersonalLifeStatus.divorced,
  };

  // Get the next stage in life, return the current status if invalid input
  PersonalLifeStatus getNext() {
    return nextStatusMap[status] ?? status;
  }

  // Get the previous stage in life, return the current status if invalid input
  PersonalLifeStatus getPrevious() {
    return previousStatusMap[status] ?? status;
  }

  /// Advance the player's [PersonalLifeStatus] to the next
  void pursueNext() {
    _status = getNext();
    notifyListeners();
  }

  void revert() {
    _status = getPrevious();
    notifyListeners();
  }

  List<PersonalLifeStatus> getList() {
    List<PersonalLifeStatus> list =
        List<PersonalLifeStatus>.empty(growable: true);
    PersonalLifeStatus tempStatus = getPrevious();

    // append the revertable status to the list
    if (tempStatus != status) {
      list.add(tempStatus);
    }

    // append the current status
    list.add(status);

    // append the pursueable status to the list
    tempStatus = getNext();
    if (tempStatus != status) {
      list.add(tempStatus);
    }

    return list;
  }
}
