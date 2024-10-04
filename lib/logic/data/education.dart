enum EducationDegree {
  uneducated("Uneducated", xp: 0),
  diploma("Diploma", xp: 500),
  bachelors("Bachelors", xp: 1000),
  masters("Masters", xp: 2200),
  phd("PhD", xp: 2800);

  const EducationDegree(this.title, {required this.xp});

  /// The title of the degree
  final String title;

  /// The amount of skill XP the player would gain for pursuing this degree
  final int xp;

  bool greaterThan(EducationDegree other) => index > other.index;
  bool greaterThanOrEqualsTo(EducationDegree other) => index >= other.index;
  bool lessThan(EducationDegree other) => index < other.index;
  bool lessThanOrEqualsTo(EducationDegree other) => index <= other.index;
  bool equalsTo(EducationDegree other) => index == other.index;
}
