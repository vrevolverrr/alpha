enum PersonalLife {
  brokeUp(title: "Broke Up", timeConsumed: 0, happiness: -40),
  single(title: "Single", timeConsumed: 0, happiness: 10),
  dating(title: "Dating", timeConsumed: 50, happiness: 20),
  marriage(title: "Marriage", timeConsumed: 120, happiness: 80),
  family(title: "Family", timeConsumed: 150, happiness: 120);

  const PersonalLife(
      {required this.title,
      required this.timeConsumed,
      required this.happiness});

  final String title;
  final int happiness;
  final int timeConsumed;
}
