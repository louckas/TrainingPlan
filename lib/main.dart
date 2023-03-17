import 'dart:math';

import 'package:flutter/material.dart';
import 'package:training_plan_flutter/data_structure/exercises.dart';
import 'package:training_plan_flutter/data_structure/workout_reps.dart';

import 'pages/planning.dart';
import 'pages/workout.dart';
import 'pages/exercise.dart';
import 'pages/overview.dart';
import 'pages/settings.dart';

import '../data_structure/folders.dart';
import '../data_structure/workout.dart';

import '../functions/filesystem.dart';
import 'dart:io';
import 'dart:convert';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.from(
        colorScheme: const ColorScheme.light(),
      ),
      darkTheme: ThemeData.from(
        colorScheme: const ColorScheme.dark(),
      ),
      home: const MainBody(),
    );
  }
}

class MainBody extends StatefulWidget {
  const MainBody({super.key});

  @override
  State<MainBody> createState() => _MainBodyState();
}

class _MainBodyState extends State<MainBody> {
  File exerciseFile = File("");
  File workoutFile = File("");

  var menuSelected = 0;

  List<Folders> folders = [];
  List<Workout> workouts = [];

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

    getLocalFile("workout.json").then(
      (value) => setState(() {
        workoutFile = value;
        if (!workoutFile.existsSync()) {
          workoutFile.createSync();
        } else {
          workoutFile.openRead();
          String json = workoutFile.readAsStringSync();
          if (json.isNotEmpty) {
            List jsonMap = jsonDecode(json);
            for (var j in jsonMap) {
              workouts.add(Workout.fromJson(j));
            }
          }
        }
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget menu;

    switch (menuSelected) {
      case 0:
        menu = const PlanningPage();
        break;
      case 1:
        menu = WorkoutPage(workouts);
        break;
      case 2:
        menu = ExercisePage(folders, exerciseFile);
        break;
      case 3:
        menu = const OverviewPage();
        break;
      case 4:
        menu = const SettingsPage();
        break;
      default:
        throw UnimplementedError('No widget for $menuSelected');
    }

    return GestureDetector(
      onHorizontalDragEnd: (details) {
        setState(() {
          const speedHisterisis = 20.0;
          if (details.primaryVelocity! > speedHisterisis) {
            menuSelected = max((menuSelected - 1), 0);
          } else if (details.primaryVelocity! < -speedHisterisis) {
            menuSelected = min((menuSelected + 1), 4);
          }
        });
      },
      child: Scaffold(
        body: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: menu,
            ),
            BottomNavigationBar(
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.calendar_month_outlined),
                  label: "Planning",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.assignment_outlined),
                  label: "Workout",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.fitness_center),
                  label: "Exercise",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.auto_graph),
                  label: "Overview",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: "Settings",
                ),
              ],
              type: BottomNavigationBarType.fixed,
              currentIndex: menuSelected,
              selectedItemColor: Colors.amber,
              onTap: (value) {
                setState(() {
                  menuSelected = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
