class StockItem {
  final String name;
  final String code;
  final StockType type;
  final StockRisk risk;
  final int esgRating;
  final double initialPrice;
  final double percentDrift;
  final double percentVolatility;

  static final List<StockItem> values = [
    // Index Funds
    const StockItem(
        name: "S&P 500",
        code: "GSPC",
        type: StockType.indexFund,
        risk: StockRisk.low,
        esgRating: 0,
        initialPrice: 570.0,
        percentDrift: 0.20,
        percentVolatility: 0.10),

    const StockItem(
        name: "Dow Jones",
        code: "DJI",
        type: StockType.indexFund,
        risk: StockRisk.low,
        esgRating: 0,
        initialPrice: 420.0,
        percentDrift: 0.16,
        percentVolatility: 0.08),

    const StockItem(
        name: "S-REIT Index",
        code: "REIT",
        type: StockType.indexFund,
        risk: StockRisk.low,
        esgRating: 0,
        initialPrice: 120.0,
        percentDrift: 0.12,
        percentVolatility: 0.06),

    // Equity Stocks
    const StockItem(
        name: "Mystic Enterprises Ltd.",
        code: "MYS",
        type: StockType.equity,
        risk: StockRisk.medium,
        esgRating: 0,
        initialPrice: 20.0,
        percentDrift: 0.28,
        percentVolatility: 0.22),

    const StockItem(
        name: "Vertigo Robotics Corporation",
        code: "VRX",
        type: StockType.equity,
        risk: StockRisk.high,
        esgRating: 0,
        initialPrice: 200.0,
        percentDrift: 0.38,
        percentVolatility: 0.35),

    /// ESG Stocks
    /// Low ESG score but with higher return and low risk.
    const StockItem(
      name: "EcoTech Innovations",
      code: "ETI",
      type: StockType.equity,
      risk: StockRisk.low,
      esgRating: 10,
      initialPrice: 75.0,
      percentDrift: 0.18,
      percentVolatility: 0.15,
    ),

    /// Medium ESG score with medium return but very high risk.
    const StockItem(
      name: "Clean Water Corporation",
      code: "CWC",
      type: StockType.equity,
      risk: StockRisk.high,
      esgRating: 30,
      initialPrice: 200.0,
      percentDrift: 0.25,
      percentVolatility: 0.32,
    ),

    /// High ESG at the expense of very low return with relatively higher risk.
    const StockItem(
      name: "SolarTech Industries",
      code: "STI",
      type: StockType.equity,
      risk: StockRisk.medium,
      esgRating: 50,
      initialPrice: 120.0,
      percentDrift: 0.12,
      percentVolatility: 0.18,
    )
  ];

  const StockItem(
      {required this.name,
      required this.code,
      required this.type,
      required this.risk,
      required this.esgRating,
      required this.initialPrice,
      required this.percentDrift,
      required this.percentVolatility});

  void assertStockValidity() {
    for (var stock in values) {
      assert(stock.name.isNotEmpty);
      assert(stock.code.isNotEmpty);
      assert(stock.esgRating >= 0 && stock.esgRating <= 100);
      assert(stock.initialPrice > 0);
      assert(stock.percentDrift > 0 && stock.percentDrift < 1);
      assert(stock.percentVolatility > 0 && stock.percentVolatility < 1);
    }
  }
}

enum StockType {
  indexFund(value: "Index Fund"),
  equity(value: "Equity");

  const StockType({required this.value});

  final String value;
}

enum StockRisk {
  low(value: "Low"),
  medium(value: "Medium"),
  high(value: "High");

  const StockRisk({required this.value});

  final String value;
}
