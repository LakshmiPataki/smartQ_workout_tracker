import 'package:flutter/material.dart';
import 'package:smartq_workout_tracker_app/home_screen.dart';
import 'package:smartq_workout_tracker_app/provider/workout_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => WorkoutProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Workout Tracker',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const HomeScreen(initialWorkouts: []),
      // const NewExercise(title: 'New Exercise'),
    );
  }
}
