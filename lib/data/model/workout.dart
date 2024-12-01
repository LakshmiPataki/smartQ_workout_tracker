class Workout {
  final String exerciseName;
  final String category;
  final int duration;
  final int calories;
  final String workoutDay;
  final String workoutPeriod;
  final String notes;

  Workout({
    required this.exerciseName,
    required this.category,
    required this.duration,
    required this.calories,
    required this.workoutDay,
    required this.workoutPeriod,
    required this.notes,
  });

  @override
  String toString() {
    return 'Workout{exerciseName: $exerciseName, category: $category, duration: $duration, calories: $calories, workoutDay: $workoutDay, workoutPeriod: $workoutPeriod, notes: $notes}';
  }
}
