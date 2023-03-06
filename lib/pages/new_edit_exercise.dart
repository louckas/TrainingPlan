import 'package:flutter/material.dart';
import '../data_structure/exercises.dart';
import '../data_structure/folders.dart';

class NewExercisePage extends StatefulWidget {
  final List<Folders> folders;
  Folders dropDownValue = Folders("", "", []);

  NewExercisePage(this.folders, {super.key}) {
    dropDownValue = folders.first;
  }

  @override
  State<NewExercisePage> createState() => _NewExercisePageState();
}

class _NewExercisePageState extends State<NewExercisePage> {
  String folderDescription = "";
  String folderName = "";

  String exerciseName = "";
  String exerciseDescription = "";

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem<Folders>> folderName = [];

    for (Folders f in widget.folders) {
      folderName.add(DropdownMenuItem<Folders>(
        value: f,
        child: Text(f.name),
      ));
    }
    return Scaffold(
      body: Column(
        children: [
          AppBar(),
          Row(
            children: [
              DropdownButton<Folders>(
                value: widget.dropDownValue,
                icon: const Icon(Icons.arrow_drop_down),
                items: folderName,
                onChanged: (value) {
                  setState(() {
                    widget.dropDownValue = value!;
                  });
                },
              ),
              const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 10,
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    _displayAddFolder(context);
                  },
                  child: Row(
                    children: const [
                      Icon(Icons.add),
                      Text("Add"),
                    ],
                  ))
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text("Exercise name:"),
          ),
          TextField(
            onChanged: (value) {
              exerciseName = value;
            },
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text("Exercise description:"),
          ),
          TextField(
            maxLines: 6,
            onChanged: (value) {
              exerciseDescription = value;
            },
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  widget.dropDownValue.exercises
                      .add(Exercises(exerciseName, exerciseDescription));
                  Navigator.pop(context);
                },
                child: Row(
                  children: const [
                    Icon(Icons.save),
                    Text("Save"),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Row(
                  children: const [
                    Icon(Icons.arrow_back),
                    Text("Back"),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _displayAddFolder(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("New folder:"),
            content: Column(
              children: [
                const Text("Folder Name:"),
                TextField(
                  onChanged: (value) {
                    folderName = value;
                  },
                ),
                const Text("Folder Description:"),
                TextField(
                  maxLines: 2,
                  onChanged: (value) {
                    folderDescription = value;
                  },
                ),
              ],
            ),
            actions: <Widget>[
              ElevatedButton(
                style: const ButtonStyle(
                  foregroundColor:
                      MaterialStatePropertyAll<Color>(Colors.white),
                  backgroundColor: MaterialStatePropertyAll<Color>(Colors.red),
                ),
                child: const Text('Cancel'),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
              ),
              ElevatedButton(
                style: const ButtonStyle(
                  foregroundColor:
                      MaterialStatePropertyAll<Color>(Colors.white),
                  backgroundColor:
                      MaterialStatePropertyAll<Color>(Colors.green),
                ),
                child: const Text('Add'),
                onPressed: () {
                  setState(() {
                    widget.folders
                        .add(Folders(folderName, folderDescription, []));
                    Navigator.pop(context);
                  });
                },
              ),
            ],
          );
        });
  }
}

class EditExercisePage extends StatelessWidget {
  final Exercises exercise;

  String editedName = "";
  String editedDescription = "";

  EditExercisePage(this.exercise, {super.key}) {
    editedName = exercise.name;
    editedDescription = exercise.description;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppBar(),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text("Exercise name:"),
          ),
          TextField(
            controller: TextEditingController(
              text: exercise.name,
            ),
            onChanged: (value) {
              editedName = value;
            },
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text("Exercise description:"),
          ),
          TextField(
            maxLines: 6,
            controller: TextEditingController(
              text: exercise.description,
            ),
            onChanged: (value) {
              editedDescription = value;
            },
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  exercise.name = editedName;
                  exercise.description = editedDescription;
                  Navigator.pop(context);
                },
                child: Row(
                  children: const [
                    Icon(Icons.save),
                    Text("Save"),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Row(
                  children: const [
                    Icon(Icons.arrow_back),
                    Text("Back"),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
