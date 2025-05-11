import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:vephi/pages/onboarding/intro.dart';
import 'package:vephi/main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuthAndNavigate();
  }

  Future<void> _checkAuthAndNavigate() async {
    // Wait for 2 seconds to show splash screen
    await Future.delayed(const Duration(seconds: 2));
    
    if (!mounted) return;

    // Check if user is already signed in
    final session = Supabase.instance.client.auth.currentSession;
    
    if (session != null) {
      // User is signed in, navigate to MainScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const MainScreen(isLoggedIn: true),
        ),
      );
    } else {
      // User is not signed in, navigate to Intro screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const IntroScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          'assets/Logo.png',
          width: 200,
          height: 200,
        ),
      ),
    );
  }
}