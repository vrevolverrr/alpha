import 'package:alpha/assets.dart';
import 'package:alpha/logic/opportunity_logic.dart';

final class Opportunities {
  static final List<Opportunity> opportunityList = [
    Opportunity(
        title: "Lawsuit",
        description: "You've been sued!",
        image: AlphaAssets.opportunityLawsuit,
        happinessBonus: -5,
        cashBonus: 0,
        cashPenaltyPercentage: -20.0),
    Opportunity(
        title: "Audited",
        description: "You've been audited!",
        image: AlphaAssets.opportunityAudited,
        happinessBonus: -5,
        cashBonus: 0,
        cashPenaltyPercentage: -10.0),
    Opportunity(
        title: "Angel Investor",
        description: "You've met an angle investor!",
        image: AlphaAssets.opportunityAngelInvestor,
        happinessBonus: 5,
        cashBonus: 10000,
        cashPenaltyPercentage: 0.0),
    Opportunity(
        title: "Charity",
        description: "You've donated to charity!",
        image: AlphaAssets.opportunityCharity,
        happinessBonus: 15,
        cashBonus: 0,
        cashPenaltyPercentage: -5.0),
    Opportunity(
        title: "Lottery",
        description: "You've won the lottery",
        image: AlphaAssets.opportunityLottery,
        happinessBonus: 5,
        cashBonus: 10000,
        cashPenaltyPercentage: 0.0),
  ];
}
