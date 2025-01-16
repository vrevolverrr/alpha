import 'dart:collection';
import 'dart:math';

import 'package:alpha/logic/common/interfaces.dart';
import 'package:alpha/logic/data/stocks.dart';
import 'package:alpha/services.dart';
import 'package:logging/logging.dart';

/// A controller for the financial market systems in the game. Currently
///  manages the stocks and their prices
class FinancialMarketManager implements IManager {
  @override
  Logger log = Logger('Financial Market Manager');

  /// The list of [Stock]s with simulated prices, created for parameters
  /// provided by [StockItem].
  final List<Stock> _stocks =
      StockItem.values.map((StockItem item) => Stock(item)).toList();

  /// Gets the list of [Stock]s managed.
  UnmodifiableListView<Stock> get stocks => UnmodifiableListView(_stocks);

  void updateMarket() {
    _stocks.forEach(updateStockPrice);
    log.info("All stock prices updated for ${_stocks.length} stocks");
  }

  void updateStockPrice(Stock stock) {
    double lastPrice = stock.price;
    stock.updatePrice();

    log.info(
        "Stock price updated for ${stock.name} :  $lastPrice -> ${stock.price} (${stock.percentPriceChange(lastNth: 1)}%)");
  }

  /// Get the stock price of the [StockItem] at the nth round
  double getStockPrice(StockItem stock, {int? nth}) {
    nth = nth ?? gameManager.round;
    nth = nth.clamp(1, gameManager.round);

    final List<double> prices =
        _stocks.firstWhere((Stock s) => s.item == stock).history;

    return prices[prices.length - (gameManager.round - nth) - 1];
  }
}

/// This class simulates stock prices using Geometric Brownian Motion (GBM).
class StockMarket {
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
  final StockItem item;
  final StockMarket market;

  UnmodifiableListView<double> get history =>
      UnmodifiableListView(market.historicPrices);

  double get price => market.historicPrices.last;

  String get name => item.name;
  String get code => item.code;
  double get initialPrice => item.initialPrice;
  double get percentDrift => item.percentDrift;
  double get percentVolatility => item.percentVolatility;
  int get esgRating => item.esgRating;
  StockRisk get risk => item.risk;

  double priceChange({int lastNth = 20}) {
    final int n = market.historicPrices.length;

    return market.historicPrices[n - 1] - market.historicPrices[n - lastNth];
  }

  /// Calculate the percent change in stock price over the last Nth rounds
  double percentPriceChange({int lastNth = 20}) {
    final int n = market.historicPrices.length;

    final double percentChange =
        (market.historicPrices[n - 1] / market.historicPrices[n - lastNth] -
                1.0) *
            100;

    return double.parse(percentChange.toStringAsFixed(2));
  }

  Stock(this.item)
      : market = StockMarket(
            s0: item.initialPrice,
            mu: item.percentDrift,
            sigma: item.percentVolatility) {
    /// Generate 10 prices to plot the price graph, essentially the game starts
    /// with the stock market at t = 20 rounds
    market.generatePrices(N: 20);
  }

  void updatePrice() {
    /// This function should be called after every turn/round to update the stock price
    market.getNextPrice();
  }
}
