import 'package:alpha/assets.dart';

enum PersonalLifeStatus {
  single(
    title: "Single",
    happinessBonus: 0,
    cost: 0.0,
    description:
        "You’re independent and enjoying life solo. Enjoy the freedom!",
    action: "Start Dating",
    image: AlphaAssets.personalLifeSingle,
  ),

  dating(
      title: "Dating",
      action: "Get Married",
      happinessBonus: 5,
      cost: 1000.0,
      description:
          "Take things slow, learn about each other, and see if this bond could grow.",
      image: AlphaAssets.personalLifeDating),

  marriage(
      title: "Marriage",
      action: "Start Family",
      happinessBonus: 20,
      cost: 8000.0,
      description:
          "You've tied the knot! With love and commitment, you’re building a life together. You can now purchase a HDB.",
      image: AlphaAssets.personalLifeMarried),

  family(
      title: "Family",
      action: "",
      description:
          "Your family has grown! With new responsibilities and joys, navigate the challenges of family life.",
      happinessBonus: 35,
      cost: 15000.0,
      image: AlphaAssets.personalLifeFamily);

  const PersonalLifeStatus({
    required this.title,
    required this.action,
    required this.description,
    required this.cost,
    required this.happinessBonus,
    required this.image,
  });

  final String title;
  final String action;
  final String description;
  final double cost;
  final int happinessBonus;
  final AlphaAssets image;
}
