import 'package:alpha/logic/players_logic.dart';
import 'package:alpha/services.dart';
import 'package:flutter/widgets.dart';

typedef AlphaAction = void Function(Player activePlayer);

class AlphaEvent {
  VoidCallback action;
  Player target;

  bool shouldTrigger() => activePlayer == target;

  AlphaEvent({required this.target, required this.action});
}

class AlphaEventsManager {
  void queue(AlphaEvent event) {}
  void next() {}
}
