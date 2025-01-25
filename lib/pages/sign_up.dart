import 'package:flutter/material.dart';
import 'package:vephi/pages/sign_in.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();
    final TextEditingController _confirmPasswordController =
        TextEditingController();

    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          top: 25,
          left: 16,
          right: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Center(
              child: Image.asset(
                'assets/Logo.png',
                height: 200.0,
              ),
            ),
            const SizedBox(height: 6.0),
            const Text(
              'Welcome!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 0),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 16.0),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Confirm Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Handle sign in
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2D82FF),
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: const Text(
                'Sign Up',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: () {
                // Handle sign in
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                backgroundColor: const Color(0xFF2D82FF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: const Text(
                'Sign Up with Google',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 32.0),
            GestureDetector(
              onTap: () {
                // Navigate to sign in page
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return const SignInPage();
                }));
              },
              child: const Text(
                'Already have an account? Sign In',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF2D82FF),
                  decoration: TextDecoration.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
