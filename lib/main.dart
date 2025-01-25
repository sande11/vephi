import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:vephi/pages/account.dart';
import 'package:vephi/pages/sign_in.dart';
import 'package:vephi/pages/tips.dart';
import 'package:vephi/pages/home.dart';
import 'package:vephi/pages/tracker.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );
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
    const Tips(),
    const Tracker(),
    const SignInPage(),
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
      backgroundColor: Colors.grey[300],
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
              GButton(icon: Icons.tips_and_updates_rounded, text: ''),
              GButton(icon: Icons.grading_sharp, text: ''),
              GButton(icon: Icons.person_2_rounded, text: ''),
            ],
          ),
        ),
      ),
    );
  }
}
