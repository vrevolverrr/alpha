enum OnlineCourse {
  basic("Basic", xp: 200, cost: 500);

  const OnlineCourse(this.title, {required this.xp, required this.cost});

  /// The title of the degree
  final String title;

  /// The amount of skill XP the player would gain for pursuing this degree
  final int xp;

  /// The cost of the degree
  final double cost;
}

enum EducationDegree {
  uneducated("Uneducated", xp: 0, cost: 0.0),
  diploma("Diploma", xp: 500, cost: 1200),
  bachelors("Bachelors", xp: 1000, cost: 3400),
  masters("Masters", xp: 2200, cost: 5500),
  phd("PhD", xp: 2800, cost: 8000);

  const EducationDegree(this.title, {required this.xp, required this.cost});

  /// The title of the degree
  final String title;

  /// The amount of skill XP the player would gain for pursuing this degree
  final int xp;

  /// The cost of the degree
  final double cost;

  bool greaterThan(EducationDegree other) => index > other.index;
  bool greaterThanOrEqualsTo(EducationDegree other) => index >= other.index;
  bool lessThan(EducationDegree other) => index < other.index;
  bool lessThanOrEqualsTo(EducationDegree other) => index <= other.index;
  bool equalsTo(EducationDegree other) => index == other.index;
}
