import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:vephi/pages/account.dart';
import 'package:vephi/pages/folder.dart';
import 'package:vephi/pages/home.dart';
import 'package:vephi/pages/tracker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
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

  // List of pages to navigate between
  final List<Widget> _pages = [
    const HomePage(),
    const Folder(),
    const Tracker(),
    const Account(),
  ];

  // Function to handle tab change
  void _onTabChange(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex], // Display the selected page
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          decoration: BoxDecoration(
            color: const Color.fromRGBO(27, 27, 27, 1),
            borderRadius: BorderRadius.circular(30),
          ),
          child: GNav(
            selectedIndex: _selectedIndex,
            onTabChange: _onTabChange,
            color: Colors.white,
            activeColor: Colors.white,
            tabBackgroundColor: const Color(0xFF2D82FF),
            gap: 8,
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            tabs: const [
              GButton(icon: Icons.home_filled, text: ''),
              GButton(icon: Icons.folder_copy_rounded, text: ''),
              GButton(icon: Icons.list_alt_rounded, text: ''),
              GButton(icon: Icons.person_2_rounded, text: ''),
            ],
          ),
        ),
      ),
    );
  }
}
