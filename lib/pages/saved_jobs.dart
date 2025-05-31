import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:vephi/pages/job_details.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SavedJobsPage extends StatefulWidget {
  final String userId;

  const SavedJobsPage({super.key, required this.userId});

  @override
  _SavedJobsPageState createState() => _SavedJobsPageState();
}

class _SavedJobsPageState extends State<SavedJobsPage> {
  List<Map<String, dynamic>> savedJobs = [];

  @override
  void initState() {
    super.initState();
    _fetchSavedJobs();
  }

  Future<void> _fetchSavedJobs() async {
    String? currentUserId = Supabase.instance.client.auth.currentUser?.id;
    if (currentUserId == null) {
      final prefs = await SharedPreferences.getInstance();
      currentUserId = prefs.getString('id');
    }
    if (currentUserId == null) return;
    try {
      final response = await Supabase.instance.client
          .from('saved_jobs')
          .select('jobs(*)')
          .eq('customer_id', currentUserId);
      setState(() {
        savedJobs = List<Map<String, dynamic>>.from(response);
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching saved jobs: $e')),
      );
    }
  }

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
          title: const Text(
            'Saved Job Posts',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: const Color(0xFF2D82FF),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),

        ),
      body: savedJobs.isEmpty
          ? const Center(child: Text('No saved job posts yet'))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: savedJobs.length,
              itemBuilder: (context, index) {
                final job = savedJobs[index]['jobs'];
                final postedOn = DateTime.parse(job['posted_on'] ?? DateTime.now().toString());
                final closingDate = DateTime.parse(job['closing_date'] ?? DateTime.now().toString());
                final formattedTime = _formatTimeDifference(postedOn, closingDate);

                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
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
                                    backgroundImage: job['company_logo'] != null && job['company_logo'].toString().isNotEmpty
                                        ? NetworkImage(job['company_logo'])
                                        : const AssetImage('assets/Logo.png') as ImageProvider,
                                    radius: 25,
                                  ),
                                  const SizedBox(width: 12),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        job['position'] ?? 'No Title',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        job['company_name'] ?? 'Unknown Company',
                                        style: const TextStyle(
                                          color: Colors.white70,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.bookmark,
                                  color: Colors.white,
                                  size: 32,
                                ),
                                onPressed: () async {
                                  await _removeSavedJob(job['job_id']);
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
                                  job['job_type'] ?? '',
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
                                  job['level'] ?? '',
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
                                job['location'] ?? '',
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
                );
              },
            ),
    );
  }

  Future<void> _removeSavedJob(String jobId) async {
    String? currentUserId = Supabase.instance.client.auth.currentUser?.id;
    if (currentUserId == null) {
      final prefs = await SharedPreferences.getInstance();
      currentUserId = prefs.getString('id');
    }
    if (currentUserId == null) return;
    
    try {
      await Supabase.instance.client
          .from('saved_jobs')
          .delete()
          .match({
        'customer_id': currentUserId,
        'job_id': jobId,
      });
      _fetchSavedJobs(); // Refresh the list
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error removing saved job: $e')),
      );
    }
  }

  Future<String> _getUserName() async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString('full_name') ?? '';
    }
    final response = await Supabase.instance.client
        .from('customers')
        .select('full_name')
        .eq('customer_id', user.id)
        .single();
    return response['full_name'] ?? '';
  }
}
