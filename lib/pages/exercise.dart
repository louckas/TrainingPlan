import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import '../data_structure/exercises.dart';
import '../data_structure/folders.dart';

import 'new_edit_exercise.dart';
import 'edit_folder.dart';

class ExercisePage extends StatefulWidget {
  ExercisePage(this.folders, this.exerciseFile, {super.key});

  List<Folders> folders;
  File exerciseFile;

  @override
  State<ExercisePage> createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> {
  void saveFile() {
    if (widget.exerciseFile.existsSync()) {
      widget.exerciseFile.openWrite();
      JsonEncoder encoder = const JsonEncoder.withIndent("  ");

      String json = encoder.convert(widget.folders);
      widget.exerciseFile.writeAsString(json);
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
      body: FolderView(widget.folders, onExerciseChange),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        splashColor: Colors.orange[900],
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => NewExercisePage(widget.folders)),
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
      foldersView.add(
        GestureDetector(
          child: ExpansionTile(
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
          ),
          onLongPress: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EditFolderPage(f),
              ),
            ).then((value) => {onExerciseChange()});
          },
        ),
      );
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
