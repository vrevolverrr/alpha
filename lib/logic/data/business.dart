import 'package:alpha/assets.dart';

enum Business {
  foodAndBeverageTile(
      titleName: "Food and Beverages",
      totalMarketRevenue: 1500,
      timeConsumed: 100,
      asset: AlphaAssets.businessFoodAndBeverages),

  eCommerceTile(
      titleName: "E-commerce",
      totalMarketRevenue: 2000,
      timeConsumed: 100,
      asset: AlphaAssets.businessEcommerce),

  technologyTile(
      titleName: "Technology",
      totalMarketRevenue: 200000,
      timeConsumed: 100,
      asset: AlphaAssets.businessTechnology),

  pharmaceuticalTile(
      titleName: "Pharmaceutical",
      totalMarketRevenue: 300000,
      timeConsumed: 100,
      asset: AlphaAssets.businessPharmaceutical),

  influencerTile(
      titleName: "Influencer",
      totalMarketRevenue: 100000,
      timeConsumed: 100,
      asset: AlphaAssets.businessSocialMediaInfluencer),

  noBusiness(
      titleName: "No Business", totalMarketRevenue: 0, timeConsumed: 100);

  const Business(
      {required this.titleName,
      required this.totalMarketRevenue,
      this.asset = AlphaAssets.jobProgrammer,
      required this.timeConsumed});

  final String titleName;
  final int timeConsumed;
  final AlphaAssets asset;
  final int totalMarketRevenue;

  bool greaterThanOrEqualsTo(Business other) =>
      totalMarketRevenue >= other.totalMarketRevenue;
}
