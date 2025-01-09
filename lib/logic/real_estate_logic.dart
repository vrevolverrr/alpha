import 'dart:collection';
import 'dart:math';

import 'package:alpha/assets.dart';
import 'package:alpha/logic/common/interfaces.dart';
import 'package:alpha/logic/data/real_estate.dart';
import 'package:alpha/logic/players_logic.dart';
import 'package:alpha/services.dart';
import 'package:logging/logging.dart';

enum RealEstateType {
  hdb(image: AlphaAssets.realEstateHdb),
  condo(image: AlphaAssets.realEstateCondo),
  landed(image: AlphaAssets.realEstateBungalow);

  const RealEstateType({required this.image});

  final AlphaAssets image;
}

class RealEstate {
  final String name;
  final RealEstateType type;
  final double propertyValue;
  final int repaymentPeriod;
  final double growthRate;
  final double interestRate;

  double get downPayment => propertyValue * 0.2;
  double get mortgage => propertyValue - downPayment;
  double get loanAmount => mortgage * interestRate;
  double get repaymentPerRound => loanAmount / repaymentPeriod;

  RealEstate(
      {required this.name,
      required this.type,
      required this.propertyValue,
      this.repaymentPeriod = 12,
      this.growthRate = 1.5,
      this.interestRate = 1.2});
}

class RealEstateOwnership {
  final RealEstate realEstate;
  final int ownedRound;
  final Player player;
  int _remainingRepaymentTerms;

  int get remainingRepaymentTerms => _remainingRepaymentTerms;

  RealEstateOwnership(
      {required this.realEstate,
      required this.player,
      required this.ownedRound})
      : _remainingRepaymentTerms = realEstate.repaymentPeriod;

  void deductRepaymentTerm() {
    _remainingRepaymentTerms--;
  }
}

class RealEstateManager implements IManager {
  @override
  Logger log = Logger("RealEstateManager");

  final List<RealEstateOwnership> _ownedRealEstates = [];

  void buyRealEstate(Player player, RealEstate realEstate) {
    bool bought = player.savings.deduct(realEstate.downPayment);

    if (!bought) {
      log.warning("${player.name} does not have enough savings to buy");
      return;
    }

    player.debt.borrow(realEstate.loanAmount);

    _ownedRealEstates.add(RealEstateOwnership(
        realEstate: realEstate, player: player, ownedRound: gameManager.round));

    log.info("${player.name} bought ${realEstate.name}");
  }

  void sellRealEstate(Player player, RealEstate realEstate) {
    RealEstateOwnership ownership;

    try {
      ownership = _ownedRealEstates
          .firstWhere((o) => o.realEstate == realEstate && o.player == player);
    } catch (e) {
      log.warning("${player.name} does not own ${realEstate.name}");
      return;
    }

    double propertyValue = getCurrentPropertyValue(
        realEstate, gameManager.round - ownership.ownedRound);

    double remainingMortgage =
        ownership.remainingRepaymentTerms * realEstate.repaymentPerRound;
    double profit = propertyValue - remainingMortgage;

    player.savings.add(profit);
    log.info("Added profit of $profit to ${player.name}");

    player.debt.repay(remainingMortgage);
    log.info(
        "Repaid remaining mortgage of $remainingMortgage for ${player.name}");

    _ownedRealEstates.remove(ownership);
    log.info("${player.name} sold ${realEstate.name}");
  }

  bool payRealEstateMortgage(Player player, RealEstate realEstate) {
    RealEstateOwnership ownership;

    try {
      ownership = _ownedRealEstates.firstWhere((element) =>
          element.realEstate == realEstate && element.player == player);
    } catch (e) {
      log.warning("${player.name} does not own ${realEstate.name}");
      return false;
    }

    if (ownership.remainingRepaymentTerms == 0) {
      log.warning("${player.name} has fully repaid ${realEstate.name}");
      return false;
    }

    bool paid = player.savings.deduct(realEstate.repaymentPerRound);

    if (!paid) {
      log.warning("${player.name} does not have enough savings to repay");
      return false;
    }

    player.debt.repay(realEstate.repaymentPerRound);
    ownership.deductRepaymentTerm();

    log.info("${player.name} repaid a term of ${realEstate.name}");
    return true;
  }

  List<RealEstate> getOwnedRealEstates(Player player) {
    return UnmodifiableListView(_ownedRealEstates
        .where((element) => element.player == player)
        .map((e) => e.realEstate)
        .toList());
  }

  double getCurrentPropertyValue(RealEstate realEstate, int rounds) {
    return realEstate.propertyValue * pow(realEstate.growthRate, rounds);
  }

  List<RealEstate> getAvailableRealEstates(Player player) {
    return UnmodifiableListView(RealEstates.listings
        .where((element) => !_ownedRealEstates
            .any((e) => e.realEstate == element && e.player == player))
        .toList());
  }
}
