import 'package:flutter/material.dart';

import '../../data_structure/folders.dart';

class EditFolderPage extends StatelessWidget {
  final Folders folder;

  String editedName = "";
  String editedDescription = "";

  EditFolderPage(this.folder, {super.key}) {
    editedName = folder.name;
    editedDescription = folder.description;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppBar(),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text("Folder name:"),
          ),
          TextField(
            controller: TextEditingController(
              text: folder.name,
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
            child: Text("Folder description:"),
          ),
          TextField(
            maxLines: 6,
            controller: TextEditingController(
              text: folder.description,
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
                  folder.name = editedName;
                  folder.description = editedDescription;
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
