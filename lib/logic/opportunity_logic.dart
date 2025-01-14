import 'package:alpha/assets.dart';
import 'package:alpha/logic/common/interfaces.dart';
import 'package:alpha/logic/data/opportunity.dart';
import 'package:alpha/logic/players_logic.dart';
import 'package:alpha/services.dart';
import 'package:logging/logging.dart';

class Opportunity {
  final String title;
  final String description;
  final AlphaAssets image;
  final int happinessBonus;
  final double cashBonus;
  final double cashPenaltyPercentage;

  Opportunity(
      {required this.title,
      required this.description,
      required this.image,
      required this.happinessBonus,
      required this.cashBonus,
      required this.cashPenaltyPercentage});
}

class OpportunityManager implements IManager {
  @override
  Logger log = Logger("OpportunityManager");

  Opportunity getCurrentOpportunity() {
    return Opportunities.opportunityList[
        (gameManager.round + gameManager.turn) %
            Opportunities.opportunityList.length];
  }

  void applyOpportunity(Player player) {
    final opportunity = getCurrentOpportunity();

    statsManager.addHappiness(player, opportunity.happinessBonus);
    accountsManager.creditToSavings(player, opportunity.cashBonus);
    accountsManager.deductFromSavings(
        player,
        ((opportunity.cashPenaltyPercentage / 100) *
                accountsManager.getSavingsAccount(player).balance)
            .abs());

    log.info("Player ${player.name} has received ${opportunity.title}");
  }
}
