import 'package:alpha/logic/data/business.dart';

enum StockItem {
  // Technology
  quantumTech(
      name: "Quantum Tech",
      code: "QTS",
      sector: BusinessSector.technology,
      risk: StockRisk.high,
      esgRating: 75,
      initialPrice: 45.0,
      percentDrift: 0.30,
      percentVolatility: 0.25),

  vrx(
      name: "V Robotics Inc.",
      code: "VRX",
      sector: BusinessSector.technology,
      risk: StockRisk.high,
      esgRating: 0,
      initialPrice: 18.0,
      percentDrift: 0.38,
      percentVolatility: 0.35),

  // E-commerce
  cgrt(
      name: "GlobalCart Ltd.",
      code: "GCT",
      sector: BusinessSector.eCommerce,
      risk: StockRisk.medium,
      esgRating: 0,
      initialPrice: 28.0,
      percentDrift: 0.22,
      percentVolatility: 0.18),

  eti(
    name: "ShopGo Inc.",
    code: "SGI",
    sector: BusinessSector.eCommerce,
    risk: StockRisk.high,
    esgRating: 55,
    initialPrice: 45.0,
    percentDrift: 0.32,
    percentVolatility: 0.30,
  ),

  // Food & Beverage
  fest(
      name: "FreshFeast Grp.",
      code: "FST",
      sector: BusinessSector.foodAndBeverage,
      risk: StockRisk.low,
      esgRating: 10,
      initialPrice: 15.0,
      percentDrift: 0.12,
      percentVolatility: 0.08),

  ecw(
    name: "EcoWave Tech.",
    code: "ECW",
    sector: BusinessSector.technology,
    risk: StockRisk.high,
    esgRating: 30,
    initialPrice: 20.0,
    percentDrift: 0.25,
    percentVolatility: 0.32,
  ),

  // Pharmaceutical
  bnva(
      name: "BioNova Labs",
      code: "BNA",
      sector: BusinessSector.pharmaceutical,
      risk: StockRisk.high,
      esgRating: 15,
      initialPrice: 55.0,
      percentDrift: 0.35,
      percentVolatility: 0.30),

  mys(
      name: "Mystica Labs",
      code: "MYS",
      sector: BusinessSector.pharmaceutical,
      risk: StockRisk.medium,
      esgRating: 0,
      initialPrice: 20.0,
      percentDrift: 0.28,
      percentVolatility: 0.22),

  // Social Media
  soci(
      name: "SocialSphere",
      code: "SOC",
      sector: BusinessSector.socialMedia,
      risk: StockRisk.medium,
      esgRating: 10,
      initialPrice: 25.0,
      percentDrift: 0.25,
      percentVolatility: 0.20),

  amg(
    name: "AlphaMedia Grp.",
    code: "AMG",
    sector: BusinessSector.socialMedia,
    risk: StockRisk.low,
    esgRating: 0,
    initialPrice: 12.0,
    percentDrift: 0.12,
    percentVolatility: 0.12,
  );

  const StockItem(
      {required this.name,
      required this.code,
      required this.sector,
      required this.risk,
      required this.esgRating,
      required this.initialPrice,
      required this.percentDrift,
      required this.percentVolatility});

  final String name;
  final String code;
  final BusinessSector sector;
  final StockRisk risk;
  final int esgRating;
  final double initialPrice;
  final double percentDrift;
  final double percentVolatility;
}

enum StockRisk {
  low(value: "Low"),
  medium(value: "Medium"),
  high(value: "High");

  const StockRisk({required this.value});

  final String value;
}
