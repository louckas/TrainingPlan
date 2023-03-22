import 'package:flutter/material.dart';
import '../data_structure/workout.dart';

class WorkoutPage extends StatelessWidget {
  WorkoutPage(this.workouts, {super.key});

  List<Workout> workouts;

  @override
  Widget build(BuildContext context) {
    return const Placeholder(
      child: Text("Workout"),
    );
  }
}
