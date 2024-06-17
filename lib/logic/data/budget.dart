enum Budget {
  dailyExpenses("Daily Expenses", priority: 5),
  selfImprovement("Self Improvement", priority: 4),
  recreational("Recreational", priority: 3),
  investments("Investment", priority: 2),
  savings("Savings", priority: 1);

  final String title;
  final int priority;

  const Budget(this.title, {required this.priority});
}
