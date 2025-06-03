import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:vephi/services/deepseek_service.dart';

class JobDetails extends StatelessWidget {
  final String title;
  final String company;
  final String type;
  final String level;
  final String location;
  final String time;
  final String aboutCompany;
  final String aboutPosition;
  final String companyLogo;
  final List<String> responsibilities;
  final List<String> qualifications;
  final String application;

  const JobDetails({
    super.key,
    required this.title,
    required this.company,
    required this.type,
    required this.level,
    required this.location,
    required this.time,
    required this.aboutCompany,
    required Map<String, dynamic> job,
    required this.companyLogo,
    required this.application,
    required this.qualifications,
    required this.responsibilities,
    required this.aboutPosition,
  });

  Future<void> _showCoverLetterModal(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => CoverLetterModal(
        jobTitle: title,
        company: company,
        jobDescription: aboutPosition,
        requirements: qualifications,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Job Details',
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
        actions: [
          IconButton(
            icon: const Icon(
              Icons.share,
              color: Colors.white,
            ),
            onPressed: () {
              
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.bookmark_border,
              color: Colors.white,
            ),
            onPressed: () {
          
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 80),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 190,
                    child: Card(
                      elevation: 2,
                      color: const Color(0xFF2D82FF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Container(
                                    height: 60,
                                    width: 60,
                                    child: companyLogo.isNotEmpty
                                        ? ClipOval(
                                            child: Image.network(
                                              companyLogo,
                                              height: 60,
                                              width: 60,
                                              fit: BoxFit.cover,
                                            ),
                                          )
                                        : ClipOval(
                                            child: Image.asset(
                                              'assets/Logo.png',
                                              height: 60,
                                              width: 60,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        company,
                                        style: const TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        title,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      IconText(
                                        icon: Icons.business_center,
                                        text: level,
                                        iconColor: Colors.white,
                                        textColor: Colors.white,
                                      ),
                                      const SizedBox(height: 10),
                                      IconText(
                                        icon: Icons.access_time,
                                        text: time,
                                        iconColor: Colors.white,
                                        textColor: Colors.white,
                                      ),
                                    ],
                                  ),
                                ),
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      IconText(
                                        icon: Icons.location_on,
                                        text: location,
                                        iconColor: Colors.white,
                                        textColor: Colors.white,
                                      ),
                                      const SizedBox(height: 10),
                                      IconText(
                                        icon: Icons.calendar_today,
                                        text: type,
                                        iconColor: Colors.white,
                                        textColor: Colors.white,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Rest of the content
                  const SizedBox(height: 16),
                  const Divider(color: Colors.grey),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'About $company',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(27, 27, 27, 1),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          aboutCompany,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: Color.fromRGBO(27, 27, 27, 1),
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        const SizedBox(height: 16),
                        const Divider(color: Colors.grey),
                        const SizedBox(height: 16),
                        const Text(
                          'About Job',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(27, 27, 27, 1),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          aboutPosition,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: Color.fromRGBO(27, 27, 27, 1),
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        const SizedBox(height: 16),
                        const Divider(color: Colors.grey),
                        const SizedBox(height: 16),
                        const Text(
                          'Job Responsibilities',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(27, 27, 27, 1),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: responsibilities
                              .map((responsibility) => BulletPoint(responsibility))
                              .toList(),
                        ),
                        const SizedBox(height: 16),
                        const Divider(color: Colors.grey),
                        const SizedBox(height: 16),
                        const Text(
                          'Qualifications Required',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(27, 27, 27, 1),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: qualifications
                              .map((qualification) => BulletPoint(qualification))
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 16,
            left: 20,
            right: 20,
            child: GestureDetector(
              onTap: () => _showCoverLetterModal(context),
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                  color: const Color(0xFF2D82FF),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Text(
                    'Apply Now',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class IconText extends StatelessWidget {
  final IconData icon;
  final String text;

  final Color iconColor;

  const IconText(
      {super.key,
      required this.icon,
      required this.text,
      required this.iconColor,
      required Color textColor});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: iconColor),
        const SizedBox(width: 5),
        Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white70,
          ),
        ),
      ],
    );
  }
}

class BulletPoint extends StatelessWidget {
  final String text;

  const BulletPoint(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '• ',
            style: TextStyle(fontSize: 18, color: Colors.black),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: Color.fromRGBO(27, 27, 27, 1),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CoverLetterModal extends StatefulWidget {
  final String jobTitle;
  final String company;
  final String jobDescription;
  final List<String> requirements;

  const CoverLetterModal({
    super.key,
    required this.jobTitle,
    required this.company,
    required this.jobDescription,
    required this.requirements,
  });

  @override
  State<CoverLetterModal> createState() => _CoverLetterModalState();
}

class _CoverLetterModalState extends State<CoverLetterModal> {
  final TextEditingController _coverLetterController = TextEditingController();
  bool _isGenerating = false;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _generateCoverLetter();
  }

  Future<void> _generateCoverLetter() async {
    setState(() {
      _isGenerating = true;
    });

    try {
      // Get user profile data from Supabase
      final user = Supabase.instance.client.auth.currentUser;
      if (user == null) {
        throw Exception('User not authenticated');
      }

      print('Fetching user profile data...');
      final response = await Supabase.instance.client
          .from('customers')
          .select()
          .eq('customer_id', user.id)
          .single();

      if (response == null) {
        throw Exception('User profile not found');
      }

      print('User profile data fetched successfully');

      // Prepare the prompt for DeepSeek
      final prompt = '''
Generate a professional cover letter for the following job:

Job Title: ${widget.jobTitle}
Company: ${widget.company}
Job Description: ${widget.jobDescription}
Requirements: ${widget.requirements.join(', ')}

Candidate Information:
Name: ${response['full_name']}
Experience: ${response['work_history']}
Skills: ${response['skills'].join(', ')}
Education: ${response['education'].join(', ')}

Please write a compelling cover letter that highlights the candidate's relevant experience and skills for this position.
''';

      print('Sending prompt to DeepSeek...');
      // Call DeepSeek API
      final coverLetter = await DeepSeekService.generateCoverLetter(prompt);
      print('Cover letter generated successfully');
      
      setState(() {
        _coverLetterController.text = coverLetter;
        _isGenerating = false;
      });
    } catch (e) {
      print('Error generating cover letter: $e');
      setState(() {
        _isGenerating = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${e.toString()}'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 5),
            action: SnackBarAction(
              label: 'Retry',
              onPressed: _generateCoverLetter,
              textColor: Colors.white,
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: const Offset(0, -1),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Cover Letter',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    if (!_isEditing)
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          setState(() {
                            _isEditing = true;
                          });
                        },
                      ),
                    IconButton(
                      icon: const Icon(Icons.refresh),
                      onPressed: _isGenerating ? null : _generateCoverLetter,
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: _isGenerating
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 16),
                        Text('Generating your cover letter...'),
                      ],
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(16),
                    child: TextField(
                      controller: _coverLetterController,
                      maxLines: null,
                      expands: true,
                      readOnly: !_isEditing,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        hintText: 'Your cover letter will appear here...',
                      ),
                    ),
                  ),
          ),
          if (_isEditing)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: const Offset(0, -1),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _isEditing = false;
                      });
                    },
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () {
                      // TODO: Save the edited cover letter
                      setState(() {
                        _isEditing = false;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2D82FF),
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    ),
                    child: const Text(
                      'Save Changes',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _coverLetterController.dispose();
    super.dispose();
  }
}
