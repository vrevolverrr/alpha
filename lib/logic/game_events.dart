import 'package:alpha/logic/player.dart';

abstract class PlayerEvent {
  void trigger() {}
}

class SalaryEvent implements PlayerEvent {
  final Player player;
  SalaryEvent(this.player);

  @override
  void trigger() {
    player.creditSalary();
  }
}
