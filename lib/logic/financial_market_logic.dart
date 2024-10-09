import 'dart:collection';
import 'dart:math';

class FinancialMarketManager {
  final List<Stock> _stocks = [];

  UnmodifiableListView<Stock> get stocks => UnmodifiableListView(_stocks);

  FinancialMarketManager() {
    _generateStocks();
  }

  void _generateStocks() {
    _stocks.add(Stock(
        name: "S&P 500",
        code: "GSPC",
        initialPrice: 570.0,
        percentDrift: 0.30,
        percentVolatility: 0.10));

    _stocks.add(Stock(
        name: "Dow Jones",
        code: "DJI",
        initialPrice: 420.0,
        percentDrift: 0.25,
        percentVolatility: 0.08));

    _stocks.add(Stock(
        name: "S-REIT Index",
        code: "PWR",
        initialPrice: 120.0,
        percentDrift: 0.15,
        percentVolatility: 0.05));

    /// ESG Stocks
    _stocks.add(Stock(
        name: "Mystic Enterprises Ltd.",
        code: "MYS",
        initialPrice: 20.0,
        percentDrift: 0.30,
        percentVolatility: 0.32));

    _stocks.add(Stock(
        name: "Vertigo Robotics Corporation",
        code: "VRX",
        initialPrice: 200.0,
        percentDrift: 0.02,
        percentVolatility: 0.05));
  }

  void updateMarket() => _stocks.forEach(updateStockPrice);

  void updateStockPrice(Stock stock) => stock.updatePrice();
}

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

  /// This function generates a normally distributed (gaussian) random number
  /// using the Box-Muller transform.
  double _nextGaussion() {
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
      this.T = 10.0,
      this.N = 400})
      : dt = T / N,
        S = s0 {
    rand = Random();
  }

  /// Calculate the s_t+1 stock price and return s_t price
  double getNextPrice() {
    historicPrices.add(double.parse(S.toStringAsFixed(2)));
    final double dW = sqrt(dt) * _nextGaussion();
    S *= exp((mu - 0.5 * sigma * sigma) * dt + sigma * dW);

    return historicPrices.last;
  }

  /// Generate N stock prices from the current step and return the latest price
  double generatePrices({int N = 1}) {
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

  double priceChange() {
    final int n = market.historicPrices.length;
    final double priceChange =
        market.historicPrices[n - 1] - market.historicPrices[n - 2];

    return priceChange;
  }

  double percentPriceChange() {
    final int n = market.historicPrices.length;
    final double percentChange =
        market.historicPrices[n - 1] / market.historicPrices[n - 2] - 1.0;

    return double.parse(percentChange.toStringAsFixed(2));
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
