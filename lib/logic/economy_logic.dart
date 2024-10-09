enum EconomicCycle {
  recession("Recession"),
  depression("Depression"),
  recovery("Recovery"),
  boom("Boom");

  final String name;

  const EconomicCycle(this.name);
}

class Economy {
  /// The rate of inflation (2.5%)
  static const double INFLATION_RATE = 2.5;

  double _inflation = 1.0;

  double get inflation => _inflation;

  /// Updates the economic cycle, which does two things:
  /// 1. Increments the economic cycle
  /// 2. Increases the inflation by [INFLATION_RATE]
  void updateCycle() {}
}
