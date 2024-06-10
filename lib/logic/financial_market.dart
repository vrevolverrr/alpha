import 'package:alpha/logic/stocks.dart';

class FinancialMarket {
  final List<Stock> stocks = [];

  FinancialMarket() {
    _generateStocks();
  }

  void _generateStocks() {
    /// TODO generate randomly every time
    // FZT 5% drift 8% volatility
    stocks.add(Stock(
        name: "FutureTech Innovations Inc.",
        code: "FZT",
        initialPrice: 100.0,
        percentDrift: 0.12,
        percentVolatility: 0.20));

    // GLO 8% drift 10% volatility
    stocks.add(Stock(
        name: "Galactic Logistics Corporation",
        code: "GLO",
        initialPrice: 50.0,
        percentDrift: 0.10,
        percentVolatility: 0.16));

    // GLO 10% drift 12% volatility
    stocks.add(Stock(
        name: "Phoenix Energy Solutions",
        code: "PWR",
        initialPrice: 120.0,
        percentDrift: 0.20,
        percentVolatility: 0.25));

    // GLO 15% drift 20% volatility
    stocks.add(Stock(
        name: "Mystic Enterprises Ltd.",
        code: "MYS",
        initialPrice: 20.0,
        percentDrift: 0.30,
        percentVolatility: 0.32));

    // GLO 2% drift 5% volatility
    stocks.add(Stock(
        name: "Vertigo Robotics Corporation",
        code: "VRX",
        initialPrice: 200.0,
        percentDrift: 0.02,
        percentVolatility: 0.05));
  }

  void incrementMarket() {
    for (final stock in stocks) {
      stock.updatePrice();
    }
  }
}
