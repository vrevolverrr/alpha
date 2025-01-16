import 'package:alpha/logic/common/interfaces.dart';
import 'package:alpha/logic/data/business.dart';
import 'package:logging/logging.dart';

enum WorldEvent {
  pandemic(
      title: "Global Health Crisis",
      description:
          "Healthcare systems worldwide are strained, but pharma research accelerates.",
      isPositiveEffect: false,
      sectorsAffected: [...BusinessSector.values]),

  regulatoryBacklash(
      title: "Drug Pricing Regulation",
      description:
          "New government policies force pharmaceutical companies to slash prices.",
      isPositiveEffect: false,
      sectorsAffected: [BusinessSector.pharmaceutical]),

  vaccineBreakthrough(
      title: "Medical Breakthrough",
      description:
          "Revolutionary vaccine technology boosts pharmaceutical sector.",
      isPositiveEffect: true,
      sectorsAffected: [BusinessSector.pharmaceutical]),

  aiBubbleBurst(
      title: "AI Bubble Burst",
      description:
          "The AI hype has crashed, causing tech companies to lose significant value.",
      isPositiveEffect: false,
      sectorsAffected: [BusinessSector.technology, BusinessSector.eCommerce]),

  aiBubble(
      title: "AI Revolution",
      description:
          "Artificial Intelligence breakthroughs drive massive tech sector growth.",
      isPositiveEffect: true,
      sectorsAffected: [BusinessSector.technology, BusinessSector.eCommerce]),

  foodDeliveryBoom(
      title: "Delivery Revolution",
      description:
          "Changing consumer habits drive food delivery demand sky-high.",
      isPositiveEffect: true,
      sectorsAffected: [
        BusinessSector.foodAndBeverage,
        BusinessSector.eCommerce
      ]),

  restaurantCrisis(
      title: "Dining Downturn",
      description: "Restaurant industry faces unprecedented challenges.",
      isPositiveEffect: false,
      sectorsAffected: [BusinessSector.foodAndBeverage]),

  influencerScandal(
      title: "Influencer Exodus",
      description: "Major scandal rocks social media platforms and creators.",
      isPositiveEffect: false,
      sectorsAffected: [BusinessSector.socialMedia]),

  viralTrend(
      title: "Viral Sensation",
      description:
          "New social media trend creates massive marketing opportunities.",
      isPositiveEffect: true,
      sectorsAffected: [BusinessSector.socialMedia, BusinessSector.eCommerce]),

  none(title: "", description: "", isPositiveEffect: true, sectorsAffected: []);

  final String title;
  final String description;
  final bool isPositiveEffect;
  final List<BusinessSector> sectorsAffected;

  const WorldEvent(
      {required this.title,
      required this.description,
      required this.isPositiveEffect,
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
}
