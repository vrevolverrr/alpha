import 'package:alpha/assets.dart';
import 'package:flutter/material.dart';

enum BusinessSector {
  foodAndBeverage(
      name: "Food and Beverages",
      baseRevenue: 10000.0,
      sectorColor: Color(0xFFFFC68D),
      asset: AlphaAssets.businessFoodAndBeverages),

  eCommerce(
      name: "E-commerce",
      baseRevenue: 12000.0,
      sectorColor: Color(0xFF8BC7FF),
      asset: AlphaAssets.businessEcommerce),

  technology(
      name: "Technology",
      baseRevenue: 15000.0,
      sectorColor: Color(0xFFACFFC5),
      asset: AlphaAssets.businessTechnology),

  pharmaceutical(
      name: "Pharmaceutical",
      baseRevenue: 20000.0,
      sectorColor: Color(0xFFE3A1FF),
      asset: AlphaAssets.businessPharmaceutical),

  socialMedia(
      name: "Social Media",
      baseRevenue: 7000.0,
      sectorColor: Color(0xFFFFFEAC),
      asset: AlphaAssets.businessSocialMediaInfluencer),

  noBusiness(
    name: "No Business",
    baseRevenue: 0.0,
    sectorColor: Colors.white,
    asset: AlphaAssets.businessTechnology,
  );

  const BusinessSector(
      {required this.name,
      required this.asset,
      required this.sectorColor,
      required this.baseRevenue});

  final String name;
  final AlphaAssets asset;
  final Color sectorColor;
  final double baseRevenue;
}
