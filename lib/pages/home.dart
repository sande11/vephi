import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:vephi/pages/best_fit.dart';
import 'package:vephi/pages/job_details.dart';
import 'package:vephi/pages/saved_jobs.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String name = '';
  String email = '';
  String profession = '';
  String userId = '';
  List<Map<String, dynamic>> jobs = [];

  @override
  void initState() {
    super.initState();
    _loadUserData();
    _fetchJobs();
  }

  // Load user data
  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('full_name') ?? '';
      email = prefs.getString('email') ?? '';
      profession = prefs.getString('profession') ?? '';
      userId = prefs.getString('id') ?? '';
    });
  }

  // Fetch job
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

  Future<void> toggleSavedJob(String jobId) async {
    final supabase = Supabase.instance.client;

    // Check if job is already saved
    final existingEntry = await supabase
        .from('saved_jobs')
        .select()
        .eq('customer_id', userId)
        .eq('job_id', jobId)
        .single();

    // Unsave job
    await supabase.from('saved_jobs').delete().match({
      'customer_id': userId,
      'job_id': jobId,
    });
  }

  Future<bool> checkIfSaved(String jobId) async {
    final supabase = Supabase.instance.client;

    final savedJob = await supabase
        .from('saved_jobs')
        .select()
        .eq('customer_id', userId)
        .eq('job_id', jobId)
        .single();

    return savedJob != null;
  }

  // time format
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

  // main
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
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    SavedJobsPage(userId: userId),
                              ));
                        })
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
            // Best Fit Cards
            Container(
              height: 166,
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
              ),
              child: jobs.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: jobs.length,
                      itemBuilder: (context, index) {
                        final job = jobs[index];
                        return SizedBox(
                          width: MediaQuery.of(context).size.width * 0.95,
                          child: buildJobCard(
                            context,
                            job['job_id'],
                            job['position'] ?? 'No Title',
                            job['company_name'] ?? 'Unknown Company',
                            job['job_type'] ?? '',
                            job['level'] ?? '',
                            job['location'] ?? '',
                            job['posted_on'] ?? '',
                            job['company_logo'] ?? '',
                            List<String>.from(job['responsibilities'] ?? []),
                            List<String>.from(job['qualifications'] ?? []),
                            job['application'] ?? '',
                            job['about_company'] ?? '',
                            job['about_position'] ?? '',
                            DateTime.parse(job['closing_date'] ??
                                DateTime.now().toString()),
                          ),
                        );
                      },
                    ),
            ),
            // Divider
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
            // All Jobs Cards
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
                          job['job_id'],
                          job['position'] ?? 'No Title',
                          job['company_name'] ?? 'Unknown Company',
                          job['job_type'] ?? '',
                          job['level'] ?? '',
                          job['location'] ?? '',
                          job['posted_on'] ?? '',
                          job['company_logo'] ?? '',
                          List<String>.from(job['responsibilities'] ?? []),
                          List<String>.from(job['qualifications'] ?? []),
                          job['application'] ?? '',
                          job['about_company'] ?? '',
                          job['about_position'] ?? '',
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

  //job card
  Widget buildJobCard(
      BuildContext context,
      String jobId,
      String title,
      String company,
      String type,
      String level,
      String location,
      String time,
      String companyLogo,
      List<String> responsibilities,
      List<String> qualifications,
      String application,
      String aboutCompany,
      String aboutPosition,
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
              aboutCompany: aboutCompany,
              aboutPosition: aboutPosition,
              job: const {},
              companyLogo: companyLogo,
              responsibilities: responsibilities,
              qualifications: qualifications,
              application: '',
            ),
          ),
        );
      },
      child: SizedBox(
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
                    FutureBuilder<bool>(
                      future: checkIfSaved(jobId),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        }
                        final isSaved = snapshot.data ?? false;
                        return IconButton(
                          icon: Icon(
                            isSaved ? Icons.bookmark : Icons.bookmark_border,
                            color: Colors.white,
                            size: 32,
                          ),
                          onPressed: () async {
                            await toggleSavedJob(jobId);
                            setState(() {});
                          },
                        );
                      },
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
