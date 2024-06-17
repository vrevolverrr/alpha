enum EducationDegree {
  uneducated("Uneducated"),
  diploma("Diploma"),
  bachelors("Bachelors"),
  masters("Masters"),
  phd("PhD");

  const EducationDegree(this.title);

  final String title;

  bool greaterThan(EducationDegree other) => index > other.index;
  bool greaterThanOrEqualsTo(EducationDegree other) => index >= other.index;
  bool lessThan(EducationDegree other) => index < other.index;
  bool lessThanOrEqualsTo(EducationDegree other) => index <= other.index;
  bool equalsTo(EducationDegree other) => index == other.index;
}
