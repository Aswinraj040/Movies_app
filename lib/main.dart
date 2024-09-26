import 'package:flutter/material.dart';
import 'package:movies_app/pages/home_screen.dart';
import 'package:movies_app/pages/search_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Set this property to false to hide the debug banner
      debugShowCheckedModeBanner: false,

      // Light theme (optional, if you want to support light mode)
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      // Dark theme with black background
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black, // Black background for all screens
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.black, // Black background for the app bar
        ),
        colorScheme: ColorScheme.dark(
          primary: Colors.red, // Customize colors as needed
          secondary: Colors.redAccent,
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.white), // White text color
          headlineMedium: TextStyle(color: Colors.white),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.red, // Customize button color
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.black, // Black background for the bottom nav
          selectedItemColor: Colors.red, // Selected item color
          unselectedItemColor: Colors.white60, // Unselected item color
        ),
      ),
      // Use system theme (dark mode or light mode) or force dark mode by setting darkTheme as themeMode
      themeMode: ThemeMode.dark, // Force dark mode (or use ThemeMode.system for system theme)
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  // List of screens for bottom navigation
  static const List<Widget> _screens = <Widget>[
    HomeScreen(),
    SearchScreen(),
  ];

  // When a bottom nav item is tapped, update the index
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_selectedIndex == 0 ? "Home" : "Search"),
      ),
      body: Center(
        child: _screens[_selectedIndex], // Show the current screen based on the selected index
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.white60,
        onTap: _onItemTapped, // Handle tap on bottom nav items
      ),
    );
  }
}
