import 'package:flutter/material.dart';

class Account extends StatelessWidget {
  const Account({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.white,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
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
                      icon: const Icon(
                        Icons.notifications,
                        color: Colors.black,
                      ),
                      padding: const EdgeInsets.all(0),
                      constraints: const BoxConstraints(),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.bookmark_border,
                        color: Colors.black,
                      ),
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
            // Profile Card
            buildProfileCard(
              context,
              'assets/profile_pic.png',
              'Kelvin Sande',
              'kelvinsande9@gmail.com',
              'Software Engineer',
            ),

            // Add other sections or widgets below
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
        color: Colors.grey[300], // Light grey background
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
                  // Navigate to Saved Jobs
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
                  // Navigate to CV section
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
                  // Navigate to Notifications
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
                  // Navigate to Preferences
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
                  // Navigate to Preferences
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return const Placeholder();
                  }));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

// Helper Widget for Clickable Option
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
