import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:smartq_workout_tracker_app/home_screen.dart';
import 'package:smartq_workout_tracker_app/provider/workout_provider.dart';
import 'package:smartq_workout_tracker_app/widgets/dropdown_field.dart';

import 'data/model/workout.dart';

class NewExercise extends StatefulWidget {
  const NewExercise({super.key});

  @override
  State<NewExercise> createState() => _NewExerciseState();
}

class _NewExerciseState extends State<NewExercise> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final newExerciseNameController = TextEditingController();
  final durationController = TextEditingController();
  final calorieController = TextEditingController();
  final notesController = TextEditingController();

  String selectedCategory = 'Strength';
  String selectedWorkoutDay = 'Sunday';
  String selectedWorkoutPeriod = 'Morning';

  final List<String> categoryOptions = ['Cardio', 'Strength', 'Flexibility'];
  final List<String> workoutDayOptions = [
    'Sunday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Monday'
  ];

  final List<String> workoutPeriod = ['Morning', 'Evening', 'Night'];

  void submitForm() {
    if (_formKey.currentState!.validate()) {
      String exerciseName = newExerciseNameController.text;
      int duration = int.parse(durationController.text);
      int calorie = int.parse(calorieController.text);
      String notes = notesController.text;

      final newWorkout = Workout(
          exerciseName: exerciseName,
          category: selectedCategory,
          duration: duration,
          calories: calorie,
          workoutDay: selectedWorkoutDay,
          workoutPeriod: selectedWorkoutPeriod,
          notes: notes);

      Provider.of<WorkoutProvider>(context, listen: false)
          .addWorkout(newWorkout);

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Workout details submitted successfully!")));

      newExerciseNameController.clear();
      durationController.clear();
      calorieController.clear();
      notesController.clear();
      setState(() {
        selectedCategory = 'Strength';
        selectedWorkoutDay = 'Sunday';
        selectedWorkoutPeriod = 'Morning';
      });

      Navigator.pop(context, newWorkout);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('New Exercise'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: newExerciseNameController,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Exercise Name'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Exercise Name cannot be empty';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: durationController,
                        decoration: const InputDecoration(
                            labelText: 'Duration',
                            suffixText: 'minutes',
                            border: OutlineInputBorder()),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Duration is required';
                          }
                          if (int.tryParse(value) == null) {
                            return 'Please enter a valid duration.';
                          }
                          if (int.tryParse(value)! <= 0) {
                            return 'Duration must be greater than 0';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: calorieController,
                        decoration: const InputDecoration(
                            labelText: 'Calories',
                            suffixText: 'calories',
                            border: OutlineInputBorder()),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Calories is required';
                          }
                          if (int.tryParse(value) == null) {
                            return 'Please enter a valid calorie.';
                          }
                          if (int.tryParse(value)! <= 0) {
                            return 'Calories must be greater than 0';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextField(
                        controller: notesController,
                        decoration: const InputDecoration(
                          labelText: 'Notes',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                ),
                SizedBox(
                    height: 60,
                    child: DropdownField(
                      label: 'Category',
                      options: categoryOptions,
                      selectedValue: selectedCategory,
                      onChanged: (value) {
                        setState(() {
                          selectedCategory = value!;
                        });
                      },
                    )),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 60,
                  child: DropdownField(
                    label: 'Workout Day',
                    options: workoutDayOptions,
                    selectedValue: selectedWorkoutDay,
                    onChanged: (value) {
                      setState(() {
                        selectedWorkoutDay = value!;
                      });
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 60,
                  child: DropdownField(
                    label: 'Workout Period',
                    options: workoutPeriod,
                    selectedValue: selectedWorkoutPeriod,
                    onChanged: (value) {
                      setState(() {
                        selectedWorkoutPeriod = value!;
                      });
                    },
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                    onPressed: submitForm,
                    child: const Text(
                      'Submit',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
