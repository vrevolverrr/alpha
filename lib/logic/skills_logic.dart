class Skill {
  static const kBaseSkillLevel = 20.0;
  static const kMinSkillLevel = 0.0;
  static const kMaxSkillLevel = 100.0;

  final String name;

  Skill({required this.name});

  double _stat = kBaseSkillLevel;
  double get stat => _stat;

  void upskill(double delta) => _stat += delta;
}
