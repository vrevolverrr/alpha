enum StockItem {
  // Index Funds
  gspc(
      name: "S&P 500",
      code: "GSPC",
      type: StockType.indexFund,
      risk: StockRisk.low,
      esgRating: 0,
      initialPrice: 20.0,
      percentDrift: 0.20,
      percentVolatility: 0.10),

  dji(
      name: "Dow Jones",
      code: "DJI",
      type: StockType.indexFund,
      risk: StockRisk.low,
      esgRating: 0,
      initialPrice: 18.0,
      percentDrift: 0.16,
      percentVolatility: 0.08),

  reit(
      name: "S-REIT",
      code: "REIT",
      type: StockType.etf,
      risk: StockRisk.low,
      esgRating: 0,
      initialPrice: 12.0,
      percentDrift: 0.12,
      percentVolatility: 0.06),

  // Equity Stocks
  mys(
      name: "Mystica Ltd.",
      code: "MYS",
      type: StockType.equity,
      risk: StockRisk.medium,
      esgRating: 0,
      initialPrice: 20.0,
      percentDrift: 0.28,
      percentVolatility: 0.22),

  vrx(
      name: "Vertigo Robotics Inc.",
      code: "VRX",
      type: StockType.equity,
      risk: StockRisk.high,
      esgRating: 0,
      initialPrice: 18.0,
      percentDrift: 0.38,
      percentVolatility: 0.35),

  /// ESG Stocks
  /// Low ESG score but with higher return and low risk.
  eti(
    name: "EcoTech Innovations",
    code: "ETI",
    type: StockType.equity,
    risk: StockRisk.low,
    esgRating: 10,
    initialPrice: 12.0,
    percentDrift: 0.18,
    percentVolatility: 0.15,
  ),

  /// Medium ESG score with medium return but very high risk.
  cwc(
    name: "EcoWave Tech.",
    code: "ECW",
    type: StockType.equity,
    risk: StockRisk.high,
    esgRating: 30,
    initialPrice: 20.0,
    percentDrift: 0.25,
    percentVolatility: 0.32,
  ),

  /// High ESG at the expense of very low return with relatively higher risk.
  sti(
    name: "SolarTech Industries",
    code: "STI",
    type: StockType.equity,
    risk: StockRisk.medium,
    esgRating: 50,
    initialPrice: 12.0,
    percentDrift: 0.12,
    percentVolatility: 0.18,
  );

  const StockItem(
      {required this.name,
      required this.code,
      required this.type,
      required this.risk,
      required this.esgRating,
      required this.initialPrice,
      required this.percentDrift,
      required this.percentVolatility});

  final String name;
  final String code;
  final StockType type;
  final StockRisk risk;
  final int esgRating;
  final double initialPrice;
  final double percentDrift;
  final double percentVolatility;
}

enum StockType {
  indexFund(value: "Index Fund"),
  etf(value: "ETF"),
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
