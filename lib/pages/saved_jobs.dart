import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:vephi/pages/job_details.dart';

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
    try {
      final response = await Supabase.instance.client
          .from('saved_jobs')
          .select('jobs(*)')
          .eq('user_id', widget.userId);

      setState(() {
        savedJobs = List<Map<String, dynamic>>.from(response);
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching saved jobs: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Jobs'),
        backgroundColor: const Color(0xFF2D82FF),
      ),
      body: savedJobs.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: savedJobs.length,
              itemBuilder: (context, index) {
                final job = savedJobs[index]['jobs'];
                return ListTile(
                  title: Text(job['position'] ?? 'No Title'),
                  subtitle: Text(job['company_name'] ?? 'Unknown Company'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => JobDetails(
                          title: job['position'] ?? 'No Title',
                          company: job['company_name'] ?? 'Unknown Company',
                          type: job['job_type'] ?? '',
                          level: job['level'] ?? '',
                          location: job['location'] ?? '',
                          time: job['posted_on'] ?? '',
                          companyLogo: job['company_logo'] ?? '',
                          responsibilities: List<String>.from(job['responsibilities'] ?? []),
                          qualifications: List<String>.from(job['qualifications'] ?? []),
                          application: job['application'] ?? '',
                          aboutCompany: job['about_company'] ?? '',
                          aboutPosition: job['about_position'] ?? '', job: const {},
                        ),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
