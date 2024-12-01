import 'package:flutter/material.dart';
import 'package:smartq_workout_tracker_app/new_exercise.dart';

import 'data/model/workout.dart';

class HomeScreen extends StatefulWidget {
  final List<Workout> initialWorkouts;

  const HomeScreen({super.key, required this.initialWorkouts});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<Workout> workouts;

  @override
  void initState() {
    super.initState();
    workouts = List.from(widget.initialWorkouts);
  }

  int getTotalCalories() {
    return workouts.fold(0, (total, workout) => total + workout.calories);
  }

  void deleteWorkout(int index) {
    setState(() {
      workouts.removeAt(index);
    });
  }

  void deleteAllWorkouts() {
    setState(() {
      workouts.clear();
    });
  }

  void navigateToAddWorkout() async {
    final newWorkout = await Navigator.push<Workout>(
        context, MaterialPageRoute(builder: (context) => const NewExercise()));

    if (newWorkout != null) {
      setState(() {
        workouts.add(newWorkout);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Workout Tracker'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
              onPressed: workouts.isEmpty
                  ? null
                  : () {
                      deleteAllWorkouts();
                    },
              icon: const Icon(Icons.delete_forever)),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              const Text(
                'Total Calories Burned',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 50,
                width: 100,
                color: Theme.of(context).colorScheme.onSecondary,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                      child: Text(
                    '${getTotalCalories()} ',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  )),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Expanded(
                child: workouts.isEmpty
                    ? const Center(
                        child: Text(
                          'No Workouts added yet',
                          style: TextStyle(fontSize: 16),
                        ),
                      )
                    : ListView.builder(
                        itemCount: workouts.length,
                        itemBuilder: (context, index) {
                          final workout = workouts[index];
                          return Card(
                            child: ListTile(
                                title: Text(
                                  workout.exerciseName,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 2.0),
                                    Text(
                                      'Calories:${workout.calories} kcal',
                                    ),
                                    Text(
                                      'Duration:${workout.duration} min',
                                    ),
                                    const SizedBox(height: 2.0),
                                    Text(
                                      'Category: ${workout.category}',
                                    ),
                                  ],
                                ),
                                trailing: IconButton(
                                    onPressed: () => deleteWorkout(index),
                                    icon: const Icon(Icons.delete))),
                          );
                        }),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: navigateToAddWorkout,
        child: const Icon(Icons.add),
      ),
    );
  }
}
