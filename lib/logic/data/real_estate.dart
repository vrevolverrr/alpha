import 'package:alpha/logic/real_estate_logic.dart';

final class RealEstates {
  static final List<RealEstate> listings = [
    RealEstate(
        name: "34 Jurong East St",
        type: RealEstateType.hdb,
        propertyValue: 120000.0,
        growthRate: 1.03,
        repaymentPeriod: 20),
    RealEstate(
        name: "12 Orchard Road",
        type: RealEstateType.condo,
        propertyValue: 200000.0,
        growthRate: 1.06,
        repaymentPeriod: 20),
    RealEstate(
        name: "1 Bukit Timah Road",
        type: RealEstateType.landed,
        propertyValue: 500000.0,
        growthRate: 1.10,
        repaymentPeriod: 30),
    RealEstate(
        name: "1 Marina Bay Sands",
        type: RealEstateType.condo,
        propertyValue: 700000.0,
        growthRate: 1.08,
        repaymentPeriod: 40),
  ];
}
