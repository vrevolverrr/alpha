import 'package:alpha/assets.dart';

enum PersonalLifeStatus {
  single(
    title: "Single",
    pursueTimeConsumed: 0,
    pursueHappinessPR: 5,
    pursueCostRatio: 0,
    revertTimeGain: 50,
    revertHappinessCost: 50,
    revertCostRatio: 0,
    statusDescription:
        "You’re independent and enjoying life solo! Explore your interests, build friendships, and keep an eye out for that special someone.",
    revertDescription:
        "Things didn’t work out. It’s time to part ways and focus on self-care and growth, opening doors to new connections and experiences.",
    pursuedAction: "",
    revertAction: "Break Up",
    image: AlphaAssets.personalLifeSingle,
  ),
  dating(
      title: "Dating",
      pursueTimeConsumed: 50,
      pursueHappinessPR: 20,
      pursueCostRatio: 0.2,
      revertTimeGain: 0,
      revertHappinessCost: 0,
      revertCostRatio: 0,
      statusDescription:
          "You’ve found someone who sparks your interest! Take things slow, learn about each other, and see if this bond could grow.",
      revertDescription: "",
      pursuedAction: "Enter A Relationship",
      revertAction: "",
      image: AlphaAssets.personalLifeDating),

  divorced(
      title: "Divorced",
      pursueTimeConsumed: 0,
      pursueHappinessPR: 0,
      pursueCostRatio: 0,
      revertTimeGain: 120,
      revertHappinessCost: 100,
      revertCostRatio: 0.5,
      statusDescription:
          "You’re starting fresh with newfound strength and wisdom! Focus on rediscovering yourself, nurturing meaningful connections, and embracing the possibilities of a brighter future ahead.",
      revertDescription:
          "You’re ending a chapter. Although difficult, this phase brings fresh starts, self-discovery, and a chance to rebuild your life in new ways.",
      pursuedAction: "",
      revertAction: "Divorce",
      image: AlphaAssets.personalLifeSingle),

  marriage(
      title: "Marriage",
      pursueTimeConsumed: 150,
      pursueHappinessPR: 50,
      pursueCostRatio: 0.5,
      revertTimeGain: 0,
      revertHappinessCost: 0,
      revertCostRatio: 0,
      statusDescription:
          "You've tied the knot! With love and commitment, you’re building a life together. Now, it’s all about trust, teamwork, and dreaming of the future.",
      revertDescription: "",
      pursuedAction: "Marry Your Partner",
      revertAction: "",
      image: AlphaAssets.personalLifeMarried),

  family(
      title: "Family",
      pursueTimeConsumed: 150,
      pursueHappinessPR: 120,
      pursueCostRatio: 0.8,
      revertTimeGain: 0,
      revertHappinessCost: 0,
      revertCostRatio: 0,
      statusDescription:
          "Your family has grown! With new responsibilities and joys, you’re navigating the challenges of family life while building lasting memories.",
      revertDescription: "",
      pursuedAction: "Start A Family",
      revertAction: "",
      image: AlphaAssets.personalLifeFamily);

  const PersonalLifeStatus({
    required this.title,
    required this.pursueTimeConsumed,
    required this.pursueHappinessPR,
    required this.pursueCostRatio,
    required this.revertTimeGain,
    required this.revertHappinessCost,
    required this.revertCostRatio,
    required this.statusDescription,
    required this.revertDescription,
    required this.pursuedAction,
    required this.revertAction,
    required this.image,
  });

  final String title;
  final int pursueHappinessPR;
  final int pursueTimeConsumed;
  final double pursueCostRatio;
  final String statusDescription;
  final String revertDescription;
  final String pursuedAction;
  final String revertAction;
  final int revertHappinessCost;
  final int revertTimeGain;
  final double revertCostRatio;
  final AlphaAssets image;
}
