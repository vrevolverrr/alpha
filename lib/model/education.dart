enum Education {
  uneducated("Uneducated"),
  diploma("Diploma"),
  bachelors("Bachelors"),
  masters("Masters"),
  phd("PhD");

  const Education(this.title);

  final String title;

  bool greaterThan(Education other) => index > other.index;
  bool greaterThanOrEqualsTo(Education other) => index >= other.index;
  bool lessThan(Education other) => index < other.index;
  bool lessThanOrEqualsTo(Education other) => index <= other.index;
  bool equalsTo(Education other) => index == other.index;
}
