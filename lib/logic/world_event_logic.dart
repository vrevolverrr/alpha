import 'package:alpha/logic/common/interfaces.dart';
import 'package:alpha/logic/data/business.dart';
import 'package:logging/logging.dart';

enum WorldEvent {
  pandemic(
      title: "Global Health Crisis",
      description:
          "Healthcare systems worldwide are strained, but pharma research accelerates.",
      multiplier: 0.7,
      sectorsAffected: [...BusinessSector.values]),

  regulatoryBacklash(
      title: "Drug Pricing Regulation",
      description:
          "New government policies force pharmaceutical companies to slash prices.",
      multiplier: 0.65,
      sectorsAffected: [BusinessSector.pharmaceutical]),

  vaccineBreakthrough(
      title: "Medical Breakthrough",
      description:
          "Revolutionary vaccine technology boosts pharmaceutical sector.",
      multiplier: 1.3,
      sectorsAffected: [BusinessSector.pharmaceutical]),

  aiBubbleBurst(
      title: "AI Bubble Burst",
      description:
          "The AI hype has crashed, causing tech companies to lose significant value.",
      multiplier: 0.7,
      sectorsAffected: [BusinessSector.technology, BusinessSector.eCommerce]),

  aiBubble(
      title: "AI Revolution",
      description:
          "Artificial Intelligence breakthroughs drive massive tech sector growth.",
      multiplier: 1.2,
      sectorsAffected: [BusinessSector.technology, BusinessSector.eCommerce]),

  foodDeliveryBoom(
      title: "Delivery Revolution",
      description:
          "Changing consumer habits drive food delivery demand sky-high.",
      multiplier: 1.3,
      sectorsAffected: [
        BusinessSector.foodAndBeverage,
        BusinessSector.eCommerce
      ]),

  restaurantCrisis(
      title: "Dining Downturn",
      description: "Restaurant industry faces unprecedented challenges.",
      multiplier: 0.6,
      sectorsAffected: [BusinessSector.foodAndBeverage]),

  influencerScandal(
      title: "Influencer Exodus",
      description: "Major scandal rocks social media platforms and creators.",
      multiplier: 0.7,
      sectorsAffected: [BusinessSector.influencer]),

  viralTrend(
      title: "Viral Sensation",
      description:
          "New social media trend creates massive marketing opportunities.",
      multiplier: 1.4,
      sectorsAffected: [BusinessSector.influencer, BusinessSector.eCommerce]),

  none(title: "", description: "", multiplier: 1.0, sectorsAffected: []);

  final String title;
  final String description;
  final List<BusinessSector> sectorsAffected;
  final double multiplier;

  const WorldEvent(
      {required this.title,
      required this.description,
      required this.multiplier,
      required this.sectorsAffected});
}

class WorldEventManager implements IManager {
  static const kWorldEventDuration = 3;

  @override
  Logger log = Logger("WorldEventManager");

  WorldEvent _currentEvent = WorldEvent.none;
  int _roundsRemaining = 0;

  WorldEvent get currentEvent => _currentEvent;
  int get roundsRemaining => _roundsRemaining;

  void incrementWorldEvent() {
    if (_roundsRemaining > 0) {
      _roundsRemaining--;
    }

    if (_roundsRemaining == 0) {
      _currentEvent = WorldEvent.none;
    }
  }

  WorldEvent triggerEvent() {
    _currentEvent = WorldEvent.values[DateTime.now().second % 6];
    log.info("Triggered world event: $_currentEvent");

    _roundsRemaining = kWorldEventDuration;

    return _currentEvent;
  }

  double getSectorMultiplier(BusinessSector sector) {
    if (_currentEvent.sectorsAffected.contains(sector)) {
      return _currentEvent.multiplier;
    }

    return 1.0;
  }
}
