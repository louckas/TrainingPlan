import 'package:flutter/material.dart';

import '../../data_structure/exercises.dart';
import 'new_edit_exercise.dart';

class ExerciseView extends StatelessWidget {
  final List<Exercises> exercise;
  final Function onExerciseChange;

  const ExerciseView(this.exercise, this.onExerciseChange, {super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> exercisesView = [];
    for (Exercises e in exercise) {
      exercisesView.add(GestureDetector(
        child: Text(("    ${e.name}")),
        onLongPress: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditExercisePage(e),
            ),
          ).then((value) => {onExerciseChange()});
        },
      ));
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: exercisesView,
    );
  }
}
