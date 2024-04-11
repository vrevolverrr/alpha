import 'package:alpha/model/education.dart';

enum PlayerFields {
  savings,
  happiness,
  education,
}

class Player {
  final String name;

  Education education = Education.bachelors;
  double savings = 2000.0;
  double salary = 2400.0;
  double commitments = 671.0;
  int happiness = 100;

  final Map<String, double> _budgets = {
    "Savings": 0.3,
    "Daily Expenses": 0.3,
    "Investment": 0.23,
    "Recreational": 0.1,
    "Self Improvement": 0.1
  };

  Player(this.name);

  double updateSavings(double delta) {
    savings += delta;
    return savings;
  }

  int updateHappiness(int delta) {
    happiness += delta;
    return happiness;
  }

  void incrementEducation() {
    int newIndex = education.index + 1;
    if (newIndex > Education.values.length - 1) {
      newIndex = Education.values.length - 1;
    }
    education = Education.values[education.index + 1];
  }

  Map<String, double> getBudgets() {
    return _budgets;
  }

  void updateBudgets(String field, double percentage) {
    _budgets[field] = percentage;
  }
}
