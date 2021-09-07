class Goal {
  Goal(
      {required this.name,
      required this.description,
      required this.goalAmount,
      required this.duration,
      required this.inflation});

  final String name;
  final String description;
  final double goalAmount;
  final int duration;
  final double inflation;
}
