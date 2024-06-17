import 'dart:collection';

import 'package:alpha/logic/stocks.dart';

class FinancialMarketManager {
  final List<Stock> _stocks = [];

  UnmodifiableListView<Stock> get stocks => UnmodifiableListView(_stocks);

  FinancialMarketManager() {
    _generateStocks();
  }

  void _generateStocks() {
    /// TODO generate randomly every time
    // FZT 5% drift 8% volatility
    _stocks.add(Stock(
        name: "FutureTech Innovations Inc.",
        code: "FZT",
        initialPrice: 100.0,
        percentDrift: 0.12,
        percentVolatility: 0.20));

    // GLO 8% drift 10% volatility
    _stocks.add(Stock(
        name: "Galactic Logistics Corporation",
        code: "GLO",
        initialPrice: 50.0,
        percentDrift: 0.10,
        percentVolatility: 0.16));

    // GLO 10% drift 12% volatility
    _stocks.add(Stock(
        name: "Phoenix Energy Solutions",
        code: "PWR",
        initialPrice: 120.0,
        percentDrift: 0.20,
        percentVolatility: 0.25));

    // GLO 15% drift 20% volatility
    _stocks.add(Stock(
        name: "Mystic Enterprises Ltd.",
        code: "MYS",
        initialPrice: 20.0,
        percentDrift: 0.30,
        percentVolatility: 0.32));

    // GLO 2% drift 5% volatility
    _stocks.add(Stock(
        name: "Vertigo Robotics Corporation",
        code: "VRX",
        initialPrice: 200.0,
        percentDrift: 0.02,
        percentVolatility: 0.05));
  }

  void incrementMarket() => _stocks.forEach(updateStockPrice);

  void updateStockPrice(Stock stock) => stock.updatePrice();
}
