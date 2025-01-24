import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:vephi/pages/sign_up.dart';
import 'dart:convert';
import 'sign_in.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  bool isLoggedIn = true;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    try {
      final url = Uri.parse('http://172.26.96.1/vephi/api/check-login-status');
      final response = await http.get(url, headers: {
        'Authorization': 'Bearer USER_TOKEN',
      });

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          isLoggedIn = data['logged_in'] ?? false;
        });

        if (!isLoggedIn) {
          // Redirect to SignInPage if not logged in
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const SignInPage()),
          );
        }
      } else {
        // Handle other status codes if necessary
        print('Failed to check login status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error checking login status: $e');
      // Optionally redirect to SignInPage on error
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SignUpPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // If not logged in, return an empty container or a loading indicator
    if (!isLoggedIn) {
      return Container(); // or a loading indicator
    }

    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.grey[200],
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text(
              'Hello Kelvin',
              style: TextStyle(color: Colors.grey, fontSize: 18),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Your profile',
                  style: TextStyle(
                    color: Color.fromRGBO(27, 27, 27, 1),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      icon:
                          const Icon(Icons.notifications, color: Colors.black),
                      padding: const EdgeInsets.all(0),
                      constraints: const BoxConstraints(),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.bookmark_border,
                          color: Colors.black),
                      padding: const EdgeInsets.all(0),
                      constraints: const BoxConstraints(),
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildProfileCard(
              context,
              'assets/profile_pic.png',
              'Kelvin Sande',
              'kelvinsande9@gmail.com',
              'Software Engineer',
            ),
            buildOptionsCard(context),
          ],
        ),
      ),
    );
  }

  // Profile Card widget
  Widget buildProfileCard(BuildContext context, String profilePic, String name,
      String email, String profession) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
      child: Card(
        elevation: 5,
        color: const Color(0xFF2D82FF),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage(profilePic),
                radius: 40,
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    email,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    profession,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildOptionsCard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
        elevation: 2,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              buildClickableOption(
                context,
                icon: Icons.bookmark_border,
                label: 'Saved Jobs',
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return const Placeholder(); // Replace with your Saved Jobs screen
                  }));
                },
              ),
              const Divider(color: Colors.grey),
              buildClickableOption(
                context,
                icon: Icons.description_outlined,
                label: 'Curriculum Vitae',
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return const Placeholder();
                  }));
                },
              ),
              const Divider(color: Colors.grey),
              buildClickableOption(
                context,
                icon: Icons.notifications_none,
                label: 'Notifications',
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return const Placeholder();
                  }));
                },
              ),
              const Divider(color: Colors.grey),
              buildClickableOption(
                context,
                icon: Icons.settings_outlined,
                label: 'Preferences',
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return const Placeholder();
                  }));
                },
              ),
              const Divider(color: Colors.grey),
              buildClickableOption(
                context,
                icon: Icons.logout,
                label: 'Logout',
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (_) {
                    return const SignInPage();
                  }));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildClickableOption(BuildContext context,
      {required IconData icon,
      required String label,
      required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon, color: Colors.black54),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.black54),
        ],
      ),
    );
  }
}
