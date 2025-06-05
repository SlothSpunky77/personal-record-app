import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pr/pages/calendar_page.dart';
import 'package:pr/pages/onboard.dart';
import 'package:pr/pages/pr_page.dart';
import 'package:pr/theme/theme.dart';
import 'package:pr/pages/home_page.dart';
//import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Database().initializeGroup();
  // await Database().initializeWorkout();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _completed = false;

  void onboardCompleted() async {
    //SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      //_completed = prefs.getBool('completed') ?? false;
      _completed = false;
    });
  }

  @override
  void initState() {
    super.initState();
    onboardCompleted();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [],
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/main': (context) => const RootPage(), // Route for main screen
      },
      home: _completed ? const RootPage() : const OnBoard(),
    );
  }
}

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int currentPageIndex = 1;
  List pages = const [
    PRPage(), //this will have the PR listed for every exercise you've created in a listview with the title of the muscle group and the child a horizontal scroll view
    HomePage(), //add all your workouts here, and make the muscle groups color coded
    CalendarPage(), //have all the workouts you've done in a calendar view
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentPageIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: darkMode.colorScheme.primary,
        selectedItemColor: const Color.fromARGB(255, 255, 255, 255),
        unselectedItemColor: const Color.fromARGB(255, 174, 174, 174),
        onTap: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        currentIndex: currentPageIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.workspace_premium),
            label: "PR",
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.local_fire_department_outlined),
              label: "workouts"),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_outlined),
            label: "calendar",
          ),
        ],
      ),
    );
  }
}
