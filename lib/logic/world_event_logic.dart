import 'package:alpha/logic/common/interfaces.dart';
import 'package:logging/logging.dart';
import 'package:alpha/logic/data/world_event.dart';

class WorldEventManager implements IManager {
  static const kWorldEventDuration = 2;

  @override
  Logger log = Logger("WorldEventManager");

  WorldEvent _currentEvent = WorldEvent.none;
  int _roundsRemaining = 0;

  WorldEvent get currentEvent => _currentEvent;
  int get roundsRemaining => _roundsRemaining;

  void incrementWorldEvent() {
    if (_roundsRemaining > 0) {
      _roundsRemaining--;
    }

    if (_roundsRemaining == 0) {
      _currentEvent = WorldEvent.none;
    }
  }

  WorldEvent triggerEvent() {
    _currentEvent = WorldEvent.values[DateTime.now().second % 6];
    log.info("Triggered world event: $_currentEvent");

    _roundsRemaining = kWorldEventDuration;

    return _currentEvent;
  }
}
