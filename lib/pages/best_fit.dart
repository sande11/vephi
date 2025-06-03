import 'package:flutter/material.dart';
import 'package:vephi/pages/job_details.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BestFit extends StatelessWidget {
  const BestFit({super.key});

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: const Text(
            'Job That Suit You',
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
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 16.0, right: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      // children: [
                      //   Text(
                      //     'Best Fit',
                      //     style: TextStyle(
                      //       color: Color.fromRGBO(27, 27, 27, 1),
                      //       fontSize: 20,
                      //       fontWeight: FontWeight.bold,
                      //     ),
                      //   ),
                      // ],
                    ),
                  ),
                  const SizedBox(height: 4),

                  // First Job Card
                  buildJobCard(context, 'Software Engineer', 'Microsoft',
                      'Full Time', 'Senior Level', 'New York', '20 hours ago'),
                  const SizedBox(height: 10),

                  // Third Job Card (under "All Jobs")
                  buildJobCard(context, 'Data Analyst', 'Amazon', 'Full Time',
                      'Entry Level', 'Seattle', '3 days ago'),
                  const SizedBox(height: 10),

                  // Fourth Job Card (under "All Jobs")
                  buildJobCard(context, 'Marketing Specialist', 'Facebook',
                      'Part Time', 'Senior Level', 'Remote', '1 week ago'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildJobCard(BuildContext context, String title, String company,
      String type, String level, String location, String time) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const JobDetails(
              title: '',
              company: '',
              type: '',
              level: '',
              location: '',
              time: '',
              job: {},
              companyLogo: '',
              aboutCompany: '',
              aboutPosition: '',
              responsibilities: [],
              qualifications: [],
              application: '',
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8),
        child: SizedBox(
          height: 166,
          width: double.infinity,
          child: Card(
            elevation: 5,
            color: const Color(0xFF2D82FF),
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
                          const CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/company_logo.png'),
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
                        'Posted: $time',
                        style: const TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
