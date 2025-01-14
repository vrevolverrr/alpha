import 'package:alpha/logic/common/interfaces.dart';
import 'package:logging/logging.dart';

enum EconomicCycle {
  recession("Recession", "Economy is in recession", multiplier: 0.80),
  depression("Depression", "Economy is in depression", multiplier: 0.60),
  recovery("Recovery", "Economy is recovering", multiplier: 1.0),
  boom("Boom", "Economy is booming", multiplier: 1.35);

  final String name;
  final String description;
  final double multiplier;

  const EconomicCycle(this.name, this.description, {required this.multiplier});
}

class EconomyManager implements IManager {
  @override
  final Logger log = Logger("Economy Manager");

  /// The CONSTANT rate of inflation in percent
  static const double inflationRate = 2.5;

  /// The multipler to use for inflation
  double _inflation = 1 + (inflationRate / 100);

  /// The current [EconomicCycle], which also acts as a multiplier for prices
  EconomicCycle _current = EconomicCycle.recovery;
  EconomicCycle get current => _current;

  double get inflation => _inflation;

  /// Updates the economic cycle, which does two things:
  void updateCycle() {
    /// 1. Increments the economic cycle
    _current = EconomicCycle.values[
        (EconomicCycle.recovery.index + 1) % EconomicCycle.values.length];

    /// 2. Increases the inflation by the [inflationRate]
    _inflation = _inflation * (1 + (inflationRate / 100));
    log.info(
        "Incremented economic cycle, current cycle: ${current.name} @ ${current.multiplier}, inflation multiplier: $inflation");
  }

  double getCycleMultiplier() {
    return current.multiplier;
  }

  /// Get economic cycle and inflation adjusted value
  double adjustValue(double price) => price * inflation * current.multiplier;
}
