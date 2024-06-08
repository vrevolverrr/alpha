import 'dart:collection';
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
  late List<double> historicPrices = [];

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
    historicPrices.add(double.parse(S.toStringAsFixed(2)));
    final double dW = sqrt(dt) * _nextGaussion();
    S *= exp((mu - 0.5 * sigma * sigma) * dt + sigma * dW);

    return historicPrices.last;
  }

  double generatePrices({int N = 1}) {
    /// Generate N stock prices from the current price and return the
    /// latest price
    double historicPrices = 0.0;

    for (int i = 0; i < N; i++) {
      historicPrices = getNextPrice();
    }

    return historicPrices;
  }
}

class Stock {
  final String name;
  final String code;
  final double initialPrice;
  final double percentDrift;
  final double percentVolatility;
  final int start;

  late final StockMarket market;

  UnmodifiableListView<double> get history =>
      UnmodifiableListView(market.historicPrices);

  double get price => market.historicPrices.last;

  double percentPriceChange() {
    final int n = market.historicPrices.length;
    final double percentChange =
        market.historicPrices[n - 1] / market.historicPrices[n - 2] - 1.0;

    return percentChange;
  }

  Stock(
      {required this.name,
      required this.code,
      required this.initialPrice,
      required this.percentDrift,
      required this.percentVolatility,
      this.start = 30}) {
    market = StockMarket(
        s0: initialPrice, mu: percentDrift, sigma: percentVolatility);

    /// Generate 10 prices to plot the price graph, essentially the game starts
    /// with the stock market at t = start days
    market.generatePrices(N: start);
  }

  void updatePrice() {
    /// This function should be called after every turn/round to update the stock price
    market.getNextPrice();
  }
}
