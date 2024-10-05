import 'dart:collection';

import 'package:alpha/logic/common/interfaces.dart';
import 'package:alpha/logic/players_logic.dart';
import 'package:alpha/services.dart';
import 'package:flutter/widgets.dart';
import 'package:logging/logging.dart';

typedef AlphaAction = void Function(Player activePlayer);

class AlphaTimer {
  final int interval;
  int nextTrigger;

  bool shouldFire() => gameManager.round == nextTrigger;
  void hasFired() => nextTrigger = gameManager.round + interval;

  AlphaTimer({required this.interval})
      : nextTrigger = gameManager.round + interval;
}

class AlphaEvent {
  VoidCallback action;
  Player target;

  bool _shouldDestroy = false;

  bool shouldTrigger() => activePlayer == target;
  bool shouldDestroy() => _shouldDestroy;

  void trigger() {
    action();
    _shouldDestroy = true;
  }

  AlphaEvent({required this.target, required this.action});
}

class AlphaRecurringEvent extends AlphaEvent {
  final AlphaTimer timer;

  AlphaRecurringEvent(
      {required interval, required super.target, required super.action})
      : timer = AlphaTimer(interval: interval);

  @override
  bool shouldTrigger() {
    if (shouldDestroy()) return false;
    if (activePlayer != target) return false;
    if (!timer.shouldFire()) return false;

    return true;
  }

  @override
  void trigger() {
    /// Update the timer to schedule next trigger
    timer.hasFired();

    /// Trigget the action callable
    super.trigger();
  }
}

class AlphaEventCreditSalary extends AlphaRecurringEvent {
  AlphaEventCreditSalary({required super.target})
      : super(
            action: () {
              double salary = target.career.salary;
              target.savings.deduct(salary);
            },
            interval: 1);
}

class AlphaEventsManager implements IManager {
  late List<AlphaEvent> _queue;

  UnmodifiableListView get queue => UnmodifiableListView(_queue);

  @override
  Logger log = Logger("Events Manager");

  AlphaEventsManager() {
    _queue = List.empty(growable: true);
    log.info("Initialized Events Manager");
  }

  void subscribe(AlphaEvent event) {
    /// Subscribes to an event, basically allowing the event to trigger and make
    /// changes to the game's state
    _queue.add(event);
    log.info("Subscribed to new ${event.toString()} for ${event.target.name}");
  }

  void update() {
    /// Iterates through the event queue and update each event
    for (AlphaEvent event in _queue) {
      if (event.shouldTrigger()) {
        event.trigger();

        if (event is AlphaRecurringEvent) {
          log.info(
              "Triggered recurring ${event.toString()} for ${event.target.name}. Next trigger: Round ${event.timer.nextTrigger}");
        } else {
          log.info("Triggered ${event.toString()} for ${event.target.name}");
        }
      }
    }

    /// Destroys all unneeded events
    _queue.removeWhere((e) => e.shouldDestroy());
  }
}
