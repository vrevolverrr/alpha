import 'dart:math';

class StockMarket {
  /// This class simulates stock prices using Geometric Brownian Motion (GBM)

  /// initial stock price
  final double s0;

  /// percent drift (average rate of return)
  final double mu;

  /// percent volatility
  final double sigma;

  /// default parameters
  /// total time period
  final double T;

  /// number of steps
  final int N;

  // delta time per step
  final double dt;

  // uniform distribution function
  late final Random rand;

  // current step
  int i = 0;

  // current stock price
  double S;

  // historical prices
  late final List<double> sp;

  double _nextGaussion() {
    /// This function generates a normally distributed (gaussian) random number
    /// using the Box-Muller transform

    // Generate two independent samples from the uniform distribution
    double u1 = rand.nextDouble();
    double u2 = rand.nextDouble();

    // Transform U1 and U2 to random distributed Z0
    return sqrt(-2 * log(u1)) * cos(2 * pi * u2);
  }

  StockMarket(
      {required this.s0,
      required this.mu,
      required this.sigma,
      // default 20 years
      this.T = 20.0,
      // default 365 * 2 = 730 steps, so one step is 10 days
      this.N = 730})
      : dt = T / N,
        S = s0 {
    rand = Random();
  }

  double getNextPrice() {
    final double dW = sqrt(dt) * _nextGaussion();
    S *= exp((mu - 0.5 * sigma * sigma) * dt + sigma * dW);
    sp[i + 1] = S;

    return sp[i++];
  }

  double generatePrices({int N = 1}) {
    /// Generate N stock prices from the current price and return the
    /// latest price
    double sp = 0.0;

    for (int i = 0; i < N; i++) {
      sp = getNextPrice();
    }

    return sp;
  }
}

class Stock {
  final double initialPrice;
  final double percentDrift;
  final double percentVolatility;

  late final StockMarket _market;
  double _unitPrice;

  double get unitPrice => _unitPrice;

  Stock(
      {required this.initialPrice,
      required this.percentDrift,
      required this.percentVolatility})
      : _unitPrice = initialPrice {
    _market = StockMarket(
        s0: initialPrice, mu: percentDrift, sigma: percentVolatility);
  }

  void updatePrice() {
    /// This function should be called after every turn/round to update the stock price
    _unitPrice = _market.getNextPrice();
  }
}
