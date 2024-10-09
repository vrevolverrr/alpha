import 'package:alpha/logic/common/interfaces.dart';
import 'package:alpha/logic/data/business.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

class BusinessHeadCount extends ChangeNotifier {
  static final Map<Business, int> _headCount = {};

  // // constructor
  // BusinessHeadCount(Business business) {
  //   _headCount[business] = 0;
  // }

  // Private constructor
  BusinessHeadCount._privateConstructor();

  // Static variable to hold the single instance
  static final BusinessHeadCount _instance =
      BusinessHeadCount._privateConstructor();

  // Factory constructor to return the single instance
  factory BusinessHeadCount() {
    return _instance;
  }

  static void initializeHeadCount() {
    for (var business in Business.values) {
      _headCount[business] = 0;
    }
  }

  // get
  static int getHeadCount(Business business) {
    return _headCount[business]!;
  }

  // set
  static void set(Business business, int headcount) {
    _headCount[business] = headcount;
    // Notify listeners of the change
    _instance.notifyListeners();
  }

  static void incrementHeadCount(Business business) {
    set(business, _headCount[business]! + 1);
  }

  static void decrementHeadCount(Business business) {
    set(business, _headCount[business]! - 1);
  }
}

class BusinessManager implements IManager {
  /// The number of owners for each business
  final Map<Business, int> _headcount = {
    for (Business b in Business.values) b: 0
  };

  final Logger log = Logger("BusinessManager");

  /// Calculate and credit business earnings to each player
  void distributeEarnings() {
    // TODO factor in sector economic state
    // TOOO factor in economic cycle
  }
}
