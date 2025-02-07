import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:vephi/pages/best_fit.dart';
import 'package:vephi/pages/job_details.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String name = '';
  String email = '';
  String profession = '';
  List<Map<String, dynamic>> jobs = [];

  @override
  void initState() {
    super.initState();
    _loadUserData();
    _fetchJobs();
  }

  // Load user data (name, email, profession) from SharedPreferences
  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('full_name') ?? '';
      email = prefs.getString('email') ?? '';
      profession = prefs.getString('profession') ?? '';
    });
  }

  // Fetch jobs from Supabase 'jobs' table
  Future<void> _fetchJobs() async {
    try {
      final data = await Supabase.instance.client.from('jobs').select('*');
      setState(() {
        jobs = List<Map<String, dynamic>>.from(data);
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching jobs: $e')),
      );
    }
  }

// Helper function to format time difference
  String _formatTimeDifference(DateTime postedOn, DateTime closingDate) {
    final now = DateTime.now();
    if (closingDate.isBefore(now)) {
      return 'Closed';
    }

    final difference = now.difference(postedOn);
    if (difference.inSeconds < 60) {
      return '${difference.inSeconds} seconds ago';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hours ago';
    } else {
      return '${difference.inDays} days ago';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        toolbarHeight: 90,
        elevation: 4,
        backgroundColor: Colors.grey[200],
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text(
              'Hello $name',
              style: const TextStyle(color: Colors.grey, fontSize: 18),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Find your next job',
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
            // Search Field
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF9F9F9),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    hintText: 'Search...',
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.search, color: Color(0xFF2D82FF)),
                    suffixIcon:
                        Icon(Icons.filter_list, color: Color(0xFF2D82FF)),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 0.3),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                  ),
                ),
              ),
            ),
            // Best Fit Section Header
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Best Fit',
                    style: TextStyle(
                      color: Color.fromRGBO(27, 27, 27, 1),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const BestFit()),
                      );
                    },
                    child: const Text(
                      'See All',
                      style: TextStyle(
                        color: Color.fromRGBO(27, 27, 27, 1),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4),
            // Best Fit: Horizontal Job Cards
            Container(
              height: 166, // Match Best Fit height
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
              ), // Consistent padding
              child: jobs.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: jobs.length,
                      itemBuilder: (context, index) {
                        final job = jobs[index];
                        return SizedBox(
                          width: MediaQuery.of(context).size.width *
                              0.95, // Match Best Fit width
                          child: buildJobCard(
                            context,
                            job['position'] ?? 'No Title',
                            job['company_name'] ?? 'Unknown Company',
                            job['job_type'] ?? '',
                            job['level'] ?? '',
                            job['location'] ?? '',
                            job['posted_on'] ?? '',
                            job['company_logo'] ?? '',
                            DateTime.parse(job['closing_date'] ??
                                DateTime.now().toString()),
                          ),
                        );
                      },
                    ),
            ),
            // Divider and All Jobs Section Header
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: Divider(color: Colors.grey),
            ),
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.only(left: 16),
              child: const Text(
                'All Jobs',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Color.fromRGBO(27, 27, 27, 1),
                ),
              ),
            ),
            const SizedBox(height: 4),
            // All Jobs: Vertical Job Cards
            jobs.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: jobs.length,
                    itemBuilder: (context, index) {
                      final job = jobs[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 4.0),
                        child: buildJobCard(
                          context,
                          job['position'] ?? 'No Title',
                          job['company_name'] ?? 'Unknown Company',
                          job['job_type'] ?? '',
                          job['level'] ?? '',
                          job['location'] ?? '',
                          job['posted_on'] ?? '',
                          job['company_logo'] ?? '',
                          DateTime.parse(
                              job['closing_date'] ?? DateTime.now().toString()),
                        ),
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }

  // Build a job card widget with the provided details, including company_logo.
  Widget buildJobCard(
      BuildContext context,
      String title,
      String company,
      String type,
      String level,
      String location,
      String time,
      String companyLogo,
      DateTime closingDate) {
    final postedOn = DateTime.parse(time);
    final formattedTime = _formatTimeDifference(postedOn, closingDate);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => JobDetails(
              title: title,
              company: company,
              type: type,
              level: level,
              location: location,
              time: formattedTime,
              job: const {},
              companyLogo: companyLogo,
            ),
          ),
        );
      },
      child: SizedBox(
        // width: 500,
        child: Card(
          elevation: 5,
          color: const Color(0xFF2D82FF),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: companyLogo.isNotEmpty
                              ? NetworkImage(companyLogo)
                              : const AssetImage('assets/Logo.png')
                                  as ImageProvider,
                          radius: 25,
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              company,
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Icon(
                      Icons.bookmark_border,
                      color: Colors.white,
                      size: 32,
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 10,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.blue[500],
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        type,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.blue[500],
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        level,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      location,
                      style: const TextStyle(color: Colors.white),
                    ),
                    Text(
                      'Posted: $formattedTime',
                      style: const TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
