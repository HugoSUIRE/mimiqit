import 'package:flutter/material.dart';
import 'package:mimiqit/screens/map_page.dart';
import 'package:mimiqit/screens/studio_list_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mimiqit Dance Studio',
      theme: ThemeData(
        primaryColor: const Color(0xFFE91E63), // Rose magenta
        scaffoldBackgroundColor: const Color(0xFFF8BBD0), // Rose clair
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF9C27B0), // Violet
          titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.black87), // Nouveau nom pour bodyText1
          bodyMedium: TextStyle(color: Colors.black54), // Nouveau nom pour bodyText2
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor: Color(0xFF00BCD4), // Cyan
          unselectedItemColor: Colors.grey,
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color(0xFFE91E63), // Rose magenta
        scaffoldBackgroundColor: const Color(0xFF121212), // Noir profond
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF9C27B0), // Violet
          titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white), // Nouveau nom pour bodyText1
          bodyMedium: TextStyle(color: Colors.grey), // Nouveau nom pour bodyText2
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor: Color(0xFF00BCD4), // Cyan
          unselectedItemColor: Colors.grey,
        ),
      ),
      themeMode: ThemeMode.system,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const StudioListPage(),
    const MapPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mimiqit Dance Studio')),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Studios',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Map',
          ),
        ],
      ),
    );
  }
}
