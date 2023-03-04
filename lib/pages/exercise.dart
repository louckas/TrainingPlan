import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';

import '../data_structure/exercises.dart';
import '../data_structure/folders.dart';

import '../functions/filesystem.dart';

class ExercisePage extends StatefulWidget {
  ExercisePage({super.key});

  @override
  State<ExercisePage> createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> {
  File exerciseFile = File("");

  @override
  void initState() {
    getLocalFile("exercises.json").then(
      (value) => setState(() {
        exerciseFile = value;
        if (!exerciseFile.existsSync()) {
          exerciseFile.createSync();
        }
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Folders> folders = [];

    if (exerciseFile.existsSync()) {
      exerciseFile.openRead();
      String json = exerciseFile.readAsStringSync();
      if (json.isNotEmpty) {
        List jsonMap = jsonDecode(json);
        for (var j in jsonMap) {
          folders.add(Folders.fromJson(j));
        }
      }
    }
    return Scaffold(
      body: FolderView(folders),
    );
  }
}

class FolderView extends StatelessWidget {
  final List<Folders> folders;

  const FolderView(this.folders, {super.key});

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
          ExerciseView(f.exercises),
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

  const ExerciseView(this.exercise, {super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> exercisesView = [];
    for (Exercises e in exercise) {
      exercisesView.add(Text("    " + e.name));
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: exercisesView,
    );
  }
}
