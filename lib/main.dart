import 'dart:math';

import 'package:flutter/material.dart';

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
  var menuSelected = 0;
  @override
  Widget build(BuildContext context) {
    Widget menu;

    switch (menuSelected) {
      case 0:
        menu = const Placeholder(
          child: Text("Planning"),
        );
        break;
      case 1:
        menu = const Placeholder(
          child: Text("Workout"),
        );
        break;
      case 2:
        menu = const Placeholder(
          child: Text("Exercise"),
        );
        break;
      case 3:
        menu = const Placeholder(
          child: Text("Overview"),
        );
        break;
      case 4:
        menu = const Placeholder(
          child: Text("Settings"),
        );
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
          } else if (details.primaryVelocity! < speedHisterisis) {
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
