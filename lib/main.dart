import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:vephi/pages/account.dart';
import 'package:vephi/pages/onboarding/complete_profile.dart';
import 'package:vephi/pages/onboarding/sign_in.dart';
import 'package:vephi/pages/tips.dart';
import 'package:vephi/pages/home.dart';
import 'package:vephi/pages/tracker.dart';
import 'package:vephi/pages/splash_screen.dart';


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
      home: SplashScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  final int? initialTab;
  final bool isLoggedIn;

  const MainScreen({super.key, this.initialTab = 0, this.isLoggedIn = false});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late int _selectedIndex;
  late bool _isLoggedIn;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialTab ?? 0;
    _isLoggedIn = widget.isLoggedIn;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 4) {
        _isLoggedIn = true; // Keep account active until logout
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      const HomePage(),
      const Tips(),
      const Tracker(),
      const SignInPage(),
      _isLoggedIn ? const Account() : const SignInPage(), // Show Account if logged in
    ];

    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: pages[_selectedIndex],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          decoration: BoxDecoration(
            color: const Color.fromRGBO(27, 27, 27, 1),
            borderRadius: BorderRadius.circular(30),
          ),
          child: GNav(
            selectedIndex: _selectedIndex,
            onTabChange: _onItemTapped,
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

Future<Widget> _getInitialRoute() async {
  final user = Supabase.instance.client.auth.currentUser;
  if (user == null) {
    return const SignInPage();
  }

  try {
    final response = await Supabase.instance.client
        .from('customers')
        .select('is_completed')
        .eq('customer_id', user.id)
        .single();

    final isCompleted = response['is_completed'] as bool? ?? false;
    
    if (!isCompleted) {
      return const CompleteProfile();
    }
    
    return const MainScreen(initialTab: 4, isLoggedIn: true);
  } catch (e) {
    // If there's an error, assume profile is not completed
    return const CompleteProfile();
  }
}
