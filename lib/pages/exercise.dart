import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import '../data_structure/folders.dart';
import 'common/folder_listview.dart';

import 'common/new_edit_exercise.dart';

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
