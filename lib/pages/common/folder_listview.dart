import 'package:flutter/material.dart';

import '../../data_structure/folders.dart';
import 'exercise_listview.dart';
import 'edit_folder.dart';

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
