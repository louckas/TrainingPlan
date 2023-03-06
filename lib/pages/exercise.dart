import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import '../data_structure/exercises.dart';
import '../data_structure/folders.dart';

import '../functions/filesystem.dart';

import 'new_edit_exercise.dart';

class ExercisePage extends StatefulWidget {
  const ExercisePage({super.key});

  @override
  State<ExercisePage> createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> {
  File exerciseFile = File("");
  List<Folders> folders = [];

  @override
  void initState() {
    super.initState();
    getLocalFile("exercises.json").then(
      (value) => setState(() {
        exerciseFile = value;
        if (!exerciseFile.existsSync()) {
          exerciseFile.createSync();
        } else {
          exerciseFile.openRead();
          String json = exerciseFile.readAsStringSync();
          if (json.isNotEmpty) {
            List jsonMap = jsonDecode(json);
            for (var j in jsonMap) {
              folders.add(Folders.fromJson(j));
            }
          }
        }
      }),
    );
  }

  void saveFile() {
    if (exerciseFile.existsSync()) {
      exerciseFile.openWrite();
      JsonEncoder encoder = const JsonEncoder.withIndent("  ");

      String json = encoder.convert(folders);
      exerciseFile.writeAsString(json);
    }
  }

  void onExerciseChange() {
    setState(() {
      saveFile();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FolderView(folders, onExerciseChange),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        splashColor: Colors.orange[900],
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NewExercisePage(folders)),
          ).then((value) => setState(
                () {},
              ));
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}

class FolderView extends StatelessWidget {
  final List<Folders> folders;
  final Function onExerciseChange;

  const FolderView(this.folders, this.onExerciseChange, {super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> foldersView = [];

    for (Folders f in folders) {
      foldersView.add(ExpansionTile(
        title: Text(f.name),
        initiallyExpanded: foldersView.isEmpty,
        expandedAlignment: Alignment.centerLeft,
        children: [
          Card(
            borderOnForeground: true,
            child: Text(f.description),
          ),
          ExerciseView(f.exercises, onExerciseChange),
        ],
      ));
    }

    return ListView(
      children: foldersView,
    );
  }
}

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
