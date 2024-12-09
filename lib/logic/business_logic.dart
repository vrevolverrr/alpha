import 'dart:collection';
import 'dart:math';

import 'package:alpha/logic/common/interfaces.dart';
import 'package:alpha/logic/data/business.dart';
import 'package:alpha/logic/players_logic.dart';
import 'package:alpha/services.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

enum SectorEconomicState {
  depression(rate: 0.85),
  recession(rate: 0.90),
  stable(rate: 1.05),
  growth(rate: 1.20);

  const SectorEconomicState({required this.rate});

  /// The rate of change in the sector's economic state. In this context,
  /// it acts as a per round multiplier for the total market revenue of the sector.
  final double rate;
}

class BusinessSectorState {
  final BusinessSector sector;

  SectorEconomicState _state;
  double _totalMarketRevenue;
  int _numberOfBusinesses;

  SectorEconomicState get state => _state;
  double get totalMarketRevenue => _totalMarketRevenue;
  int get numberOfBusinesses => _numberOfBusinesses;
  double get grossProfit => _totalMarketRevenue / max(_numberOfBusinesses, 1);

  BusinessSectorState({required this.sector})
      : _totalMarketRevenue = sector.initialMarketRevenue,
        _numberOfBusinesses = 0,
        _state = SectorEconomicState.stable;

  void updateState(SectorEconomicState newState) => _state = newState;

  /// Increases the total market revenue of the sector based on the growth rate and sector state.
  /// Total Market Revenue = Total Market Revenue * (Sector Economic State  + Growth Rate - 1)
  void updateMarketRevenue() {
    _totalMarketRevenue *= (_state.rate + sector.growthRate - 1);
  }

  void incrementBusinessCount() => _numberOfBusinesses++;

  void decrementBusinessCount() => _numberOfBusinesses--;
}

class BusinessManager implements IManager {
  late final Map<BusinessSector, BusinessSectorState> businessStates = {};

  /// A list of businesses that have been created for the current turn.
  /// This allows us to always give the same businesses to the player in his turn.
  final List<Business> _cachedBusinesses = [];
  int _cachedTurn = -1;

  /// The maximum number of businesses there can be in a sector
  static const int kMaxBusinesses = 10;
  final Random _random = Random();

  @override
  final Logger log = Logger('Business Manager');

  BusinessManager() {
    for (BusinessSector sector in BusinessSector.values) {
      businessStates[sector] = BusinessSectorState(sector: sector);
    }
  }

  void updateBusinessStates() {
    for (BusinessSectorState state in businessStates.values) {
      state.updateMarketRevenue();
    }
  }

  BusinessSectorState getBusinessState(BusinessSector sector) {
    return businessStates[sector]!;
  }

  int getBusinessCount(BusinessSector sector) {
    return getBusinessState(sector).numberOfBusinesses;
  }

  bool buyBusiness(Business business, Player player) {
    BusinessSector sector = business.sector;

    if (getBusinessCount(sector) >= kMaxBusinesses) {
      log.warning(
          'Player ${player.name} tried to buy a business in sector $sector but the maximum number of businesses has been reached');
      return false;
    }

    final double cost = business.initialCost;

    if (player.savings.balance < cost) {
      log.warning(
          'Player ${player.name} tried to buy a business in sector $sector but they do not have enough money');
      return false;
    }

    player.savings.deduct(cost);
    player.business.addBusiness(business);

    getBusinessState(sector).incrementBusinessCount();

    return true;
  }

  void sellBusiness(Business business, Player player) {}

  void creditBusinessEarnings() {
    final players = playerManager.getAllPlayers();

    for (Player player in players) {
      if (player.business.numBusinesses == 0) continue;

      log.info("Crediting business earnings to player ${player.name}");

      for (Business business in player.business.ownedBusinesses) {
        final double earnings = calculateBusinessEarnings(business);
        player.savings.add(earnings);
      }

      log.info(
          "Credited business earnings of ${player.business.numBusinesses} to player ${player.name}");
    }
  }

  /// Calculate the earnings of a business in a sector.
  /// The earnings are distributed evenly among all businesses in the sector
  /// from the total market revenue of the sector.
  double calculateBusinessEarnings(Business business) {
    final BusinessSectorState state = getBusinessState(business.sector);

    if (state.numberOfBusinesses == 0) return 0;

    return state.totalMarketRevenue / state.numberOfBusinesses;
  }

  /// Calculate the cost of starting a business in a sector.
  double calculateBusinessCost(BusinessSector sector, int esgRating) {
    final BusinessSectorState state = getBusinessState(sector);

    // The base cost of the business
    final double baseCost =
        state.totalMarketRevenue / (state.numberOfBusinesses + 1);

    // The penalty to incur on the cost of the business because of its ESG score.
    // Higher ESG score leads to higher intiial costs, but lower operational costs.
    // ESG cost penalty is at most 35% of the base cost.
    final double esgCostPenalty = (esgRating / 100) * baseCost * 0.35;

    // Random factor to simulate unexpected expenses (±10%)
    final double randomFactor = 1 - 0.1 * (_random.nextDouble() * 2 - 1);

    double businessCost = (baseCost * randomFactor) + esgCostPenalty;

    businessCost = (businessCost / 100).round() * 100.0;

    print(
        "Business cost: $businessCost, base cost: $baseCost, esg penalty: $esgCostPenalty, random factor: $randomFactor");

    return businessCost.clamp(1000.0, double.infinity);
  }

  /// Creates a business in a sector
  Business createBusiness(BusinessSector sector) {
    String name;

    do {
      name = BusinessNameGenerator.generateName(sector);
    } while (_cachedBusinesses.any((business) => business.name == name));

    // Generate a random ESG rating rounded to 10
    final int esgRating = ((Random().nextInt(100) + 1) / 10).round() * 10;

    // Calculate the ESG scale factor, up to 45% reduction in costs
    final double esgScaleFactor = 1 - pow(esgRating / 100, 2) * 0.45;

    final double operationalCosts =
        sector.baseOperationalCosts * esgScaleFactor;

    final double initialCost = calculateBusinessCost(sector, esgRating);

    final int marketShare =
        (1 / (getBusinessState(sector)._numberOfBusinesses + 1) * 100).round();

    return Business(
        name: name,
        sector: sector,
        marketShare: marketShare,
        esgRating: esgRating,
        initialCost: initialCost,
        operationalCosts: operationalCosts);
  }

  List<Business> generateBusinesses(BusinessSector sector, int count) {
    final int currentTurn =
        gameManager.round * playerManager.getPlayerCount() + gameManager.turn;

    if (_cachedBusinesses.isNotEmpty && _cachedTurn == currentTurn) {
      return _cachedBusinesses;
    }

    _cachedBusinesses.clear();

    for (int i = 0; i < count; i++) {
      _cachedBusinesses.add(createBusiness(sector));
    }

    _cachedTurn = currentTurn;

    return UnmodifiableListView(_cachedBusinesses);
  }

  double calculateEsgScaleFactor(
    int esgScore, {
    int maxEsg = 100,
    double maxReduction = 0.3,
    double exponent = 2.0,
  }) {
    // Clamp ESG score to the range [0, maxEsg].
    int clampedEsg = esgScore.clamp(0, maxEsg);

    // Normalize ESG score to [0, 1].
    double esgRatio = clampedEsg / maxEsg;

    // Apply the scaling formula with diminishing returns.
    double scaleFactor = 1 - pow(esgRatio, exponent) * maxReduction;

    // Calculate the minimum scale factor.
    double minScaleFactor = 1 - maxReduction;

    // Clamp the scale factor to ensure it doesn't go below the minimum.
    scaleFactor = scaleFactor.clamp(minScaleFactor, 1.0);

    return scaleFactor;
  }
}

class BusinessVentures extends ChangeNotifier {
  final List<Business> _ownedBusinesses = [];

  UnmodifiableListView get ownedBusinesses =>
      UnmodifiableListView(_ownedBusinesses);

  int get numBusinesses => _ownedBusinesses.length;

  BusinessVentures();

  void addBusiness(Business business) {
    _ownedBusinesses.add(business);
    notifyListeners();
  }

  void removeBusiness(Business business) {
    _ownedBusinesses.remove(business);
    notifyListeners();
  }
}

class Business {
  final String name;
  final BusinessSector sector;
  final int marketShare;
  final int esgRating;
  final double initialCost;
  final double operationalCosts;

  Business(
      {required this.name,
      required this.sector,
      required this.marketShare,
      required this.esgRating,
      required this.initialCost,
      required this.operationalCosts});
}

class BusinessNameGenerator {
  static final Logger log = Logger('Business Name Generator');

  static const Map<BusinessSector, List<String>> names = {
    BusinessSector.technology: [
      "TechNova Solutions",
      "InnovateX Systems",
      "QuantumLeap Technologies",
      "CyberWave Innovations",
      "ByteCrafters",
      "NextGen Tech",
      "AlphaByte",
      "FutureLink",
      "NexusSoft",
      "PixelPulse",
      "FusionCode",
      "DataSphere",
      "CloudMatrix",
      "VertexTech",
      "OptiTech",
      "CodeCrafters",
      "TechFusion",
      "SparkWare",
      "ZenithTech",
      "AeroByte"
    ],
    BusinessSector.eCommerce: [
      "ShopEase Store",
      "UrbanMart",
      "RetailHub",
      "FashionFrenzy",
      "MarketPlace",
      "TrendSetters",
      "StyleSphere",
      "GlamourGroove",
      "BargainBarn",
      "PrimePicks",
      "EcoMart",
      "LuxuryLane",
      "ValueVault",
      "UrbanEdge",
      "ChicChoice",
      "SelectShop",
      "MetroMart",
      "SavvyStore",
      "EliteEmporium",
      "DailyDeals"
    ],
    BusinessSector.foodAndBeverage: [
      "TasteBuds Café",
      "FlavorFusion Bistro",
      "GourmetGlow",
      "SavorySprings",
      "DelishDelights",
      "EpicureanEats",
      "PalatePleasures",
      "CraveCrafters",
      "SizzleStation",
      "HarvestHaven",
      "BrewBerry",
      "Fork&Flavor",
      "NourishNest",
      "SpiceSphere",
      "VitalVittles",
      "CulinaryCanvas",
      "PurePlate",
      "FusionFlavors",
      "DelightDine",
      "FreshFusion"
    ],
    BusinessSector.pharmaceutical: [
      "MedSpectrum",
      "PharmaPulse",
      "HealthCure Labs",
      "VitaPharma",
      "NovaMedica",
      "CureQuest Pharmaceuticals",
      "BioVantage Pharma",
      "PureHealth Labs",
      "ZenithPharma",
      "OptiLife Pharmaceuticals",
      "LifeLine Meds",
      "PrimeCure Pharmaceuticals",
      "QuantumBio Pharma",
      "ApexMedical",
      "UnityPharma",
      "InnovoPharma",
      "GlobalCure Labs",
      "VitalEdge Pharmaceuticals",
      "FusionMeds",
      "BioSphere Pharma"
    ],
    BusinessSector.influencer: [
      "ConnectSphere",
      "BuzzBlend",
      "ShareStream",
      "LinkLounge",
      "VibeVault",
      "EchoEngage",
      "PulsePoint",
      "TrendTribe",
      "SocialSync",
      "MediaMingle",
      "SnapShift",
      "ChatChamber",
      "InfluenceInk",
      "ViralVista",
      "EchoEra",
      "FlickFusion",
      "StreamSync",
      "ConnectCraze",
      "BuzzBridge",
      "LinkLuminary"
    ]
  };

  static String generateName(BusinessSector sector) {
    List<String> sectorNames;

    if (names.containsKey(sector)) {
      sectorNames = names[sector]!;
    } else {
      sectorNames = names[BusinessSector.technology]!;
      log.warning(
          "No predefined names for sector $sector. Using technology names");
    }

    final int index = Random().nextInt(sectorNames.length);
    final String selectedName = sectorNames[index];

    return selectedName;
  }
}
