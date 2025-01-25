import 'package:flutter/material.dart';
import 'sign_in.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.grey[300],
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
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.bookmark_border,
                          color: Colors.black),
                      padding: EdgeInsets.zero,
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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header section (Blue)
                Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFF2D82FF),
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(10)),
                  ),
                  padding: const EdgeInsets.all(16.0),
                  child: const Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage('assets/profile_pic.png'),
                        radius: 40,
                      ),
                      SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Kelvin Sande',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'kelvinsande9@gmail.com',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Software Engineer',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Body section (White)
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(10)),
                  ),
                  child: Column(
                    children: [
                      buildClickableOption(
                        context,
                        icon: Icons.bookmark_border,
                        label: 'Saved Jobs',
                        onTap: () {},
                      ),
                      const Divider(color: Colors.grey),
                      buildClickableOption(
                        context,
                        icon: Icons.description_outlined,
                        label: 'Curriculum Vitae',
                        onTap: () {},
                      ),
                      const Divider(color: Colors.grey),
                      buildClickableOption(
                        context,
                        icon: Icons.notifications_none,
                        label: 'Notifications',
                        onTap: () {},
                      ),
                      const Divider(color: Colors.grey),
                      buildClickableOption(
                        context,
                        icon: Icons.settings_outlined,
                        label: 'Preferences',
                        onTap: () {},
                      ),
                      const Divider(color: Colors.grey),
                      buildClickableOption(
                        context,
                        icon: Icons.logout,
                        label: 'Logout',
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const SignInPage()),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
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
