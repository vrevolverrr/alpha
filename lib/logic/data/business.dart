import 'package:alpha/assets.dart';

enum BusinessSector {
  foodAndBeverage(
      name: "Food and Beverages",
      initialMarketRevenue: 50000.0,
      growthRate: 1.25,
      timeConsumed: 100,
      baseOperationalCosts: 10000.0,
      asset: AlphaAssets.businessFoodAndBeverages),

  eCommerce(
      name: "E-commerce",
      initialMarketRevenue: 20000.0,
      growthRate: 1.50,
      timeConsumed: 100,
      baseOperationalCosts: 7000.0,
      asset: AlphaAssets.businessEcommerce),

  technology(
      name: "Technology",
      initialMarketRevenue: 30000.0,
      growthRate: 1.4,
      timeConsumed: 100,
      baseOperationalCosts: 13000.0,
      asset: AlphaAssets.businessTechnology),

  pharmaceutical(
      name: "Pharmaceutical",
      initialMarketRevenue: 40000.0,
      growthRate: 1.35,
      timeConsumed: 100,
      baseOperationalCosts: 20000.0,
      asset: AlphaAssets.businessPharmaceutical),

  influencer(
      name: "Influencer",
      initialMarketRevenue: 10000.0,
      growthRate: 1.2,
      timeConsumed: 100,
      baseOperationalCosts: 1000.0,
      asset: AlphaAssets.businessSocialMediaInfluencer),

  noBusiness(
      name: "No Business",
      initialMarketRevenue: 0,
      growthRate: 0,
      baseOperationalCosts: 0,
      timeConsumed: 0);

  const BusinessSector({
    required this.name,
    required this.initialMarketRevenue,
    required this.growthRate,
    required this.timeConsumed,
    required this.baseOperationalCosts,
    this.asset = AlphaAssets.jobProgrammer,
  });

  final String name;
  final double initialMarketRevenue;
  final double growthRate;
  final int timeConsumed;
  final double baseOperationalCosts;
  final AlphaAssets asset;

  bool greaterThanOrEqualsTo(BusinessSector other) =>
      initialMarketRevenue >= other.initialMarketRevenue;
}
