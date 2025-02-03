import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:vephi/main.dart';

class CompleteProfile extends StatelessWidget {
  const CompleteProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        elevation: 3,
        title: const Text(
          "Complete Profile",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: const CompleteProfileForm(),
    );
  }
}

class CompleteProfileForm extends StatefulWidget {
  const CompleteProfileForm({super.key});

  @override
  _CompleteProfileFormState createState() => _CompleteProfileFormState();
}

class _CompleteProfileFormState extends State<CompleteProfileForm> {
  final _formKey = GlobalKey<FormState>();

  // Personal Details Controllers
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  // Work & Education
  List<Map<String, TextEditingController>> _workHistory = [];
  List<TextEditingController> _profession = [];
  List<TextEditingController> _education = [];
  List<TextEditingController> _skills = [];
  List<TextEditingController> _jobPreferences = [];

  // Links & Resume Controllers
  final TextEditingController _resumePathController = TextEditingController();
  final TextEditingController _linkedinUrlController = TextEditingController();
  final TextEditingController _portfolioUrlController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildProfilePicture(),
              const SizedBox(height: 15),
              _buildSection(title: 'Personal Information', children: [
                _buildTextField(_fullNameController, 'Full Name', Icons.person),
                const SizedBox(
                  height: 10,
                ),
                _buildTextField(_emailController, 'Email', Icons.email,
                    keyboardType: TextInputType.emailAddress),
                const SizedBox(
                  height: 10,
                ),
                _buildTextField(_phoneController, 'Phone', Icons.phone,
                    keyboardType: TextInputType.phone),
                const SizedBox(
                  height: 10,
                ),
                _buildTextField(
                    _locationController, 'Address', Icons.location_on),
              ]),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: _buildSection(title: 'Work & Education', children: [
                  _buildWorkHistory(),
                  _buildDynamicField("Profession", _profession),
                  _buildDynamicField("Education", _education),
                  _buildDynamicField("Skills", _skills),
                  _buildDynamicField("Job Preferences", _jobPreferences),
                ]),
              ),
              _buildSection(title: 'Links & Resume', children: [
                _buildTextField(_resumePathController, 'Resume Path (Upload)',
                    Icons.upload_file),
                const SizedBox(
                  height: 10,
                ),
                _buildTextField(
                    _linkedinUrlController, 'LinkedIn URL', Icons.link),
                const SizedBox(
                  height: 10,
                ),
                _buildTextField(
                    _portfolioUrlController, 'Portfolio URL', Icons.link),
              ]),
              _buildSection(title: 'Bio', children: [
                TextFormField(
                  controller: _bioController,
                  decoration: InputDecoration(
                    labelText: 'Short Bio',
                    prefixIcon: const Icon(Icons.description),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  maxLines: 3,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Short Bio';
                    }
                    return null;
                  },
                ),
              ]),
              const SizedBox(height: 25),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 40),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  elevation: 3,
                ),
                onPressed: () => _submitForm(context),
                child: const Text(
                  'Submit Profile',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(
      {required String title, required List<Widget> children}) {
    return Container(
      constraints: const BoxConstraints(
        maxWidth: 600, // Adjust width for larger screens
      ),
      child: Card(
        margin: const EdgeInsets.only(bottom: 15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent)),
              const SizedBox(height: 10),
              ...children,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfilePicture() {
    return Stack(
      alignment: Alignment.center,
      children: [
        const CircleAvatar(
            radius: 55,
            backgroundColor: Colors.grey,
            child: Icon(Icons.person, size: 60, color: Colors.white)),
        Positioned(
          bottom: 0,
          right: 0,
          child: CircleAvatar(
            backgroundColor: Colors.blueAccent,
            radius: 18,
            child: IconButton(
              icon: const Icon(Icons.camera_alt, size: 16, color: Colors.white),
              onPressed: () {},
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildWorkHistory() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Work History",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black)),
        const SizedBox(height: 8),
        ..._workHistory.asMap().entries.map((entry) {
          int index = entry.key;
          var data = entry.value;
          return Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Column(
                children: [
                  _buildTextField(
                      data['Company']!, 'Company Name', Icons.business),
                  _buildTextField(data['Position']!, 'Position', Icons.work),
                  _buildTextField(
                      data['Years']!, 'Years Worked', Icons.calendar_today,
                      keyboardType: TextInputType.number),
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () =>
                          setState(() => _workHistory.removeAt(index)),
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          icon: const Icon(Icons.add, color: Colors.white),
          label: const Text("Add Work History",
              style: TextStyle(color: Colors.white)),
          onPressed: () {
            setState(() {
              _workHistory.add({
                'Company': TextEditingController(),
                'Position': TextEditingController(),
                'Years': TextEditingController(),
              });
            });
          },
        ),
      ],
    );
  }

  Widget _buildDynamicField(
      String label, List<TextEditingController> controllers) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black)),
        const SizedBox(height: 8),
        ...controllers.asMap().entries.map((entry) {
          int index = entry.key;
          return Row(
            children: [
              Expanded(child: _buildTextField(entry.value, label, Icons.edit)),
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () => setState(() => controllers.removeAt(index)),
              ),
            ],
          );
        }).toList(),
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          icon: const Icon(Icons.add, color: Colors.white),
          label:
              Text("Add $label", style: const TextStyle(color: Colors.white)),
          onPressed: () =>
              setState(() => controllers.add(TextEditingController())),
        ),
      ],
    );
  }

  Widget _buildTextField(
      TextEditingController controller, String label, IconData icon,
      {TextInputType keyboardType = TextInputType.text,
      InputDecoration? decoration}) {
    return TextFormField(
      controller: controller,
      decoration: decoration ??
          InputDecoration(
            labelText: label,
            prefixIcon: Icon(icon),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
      keyboardType: keyboardType,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $label';
        }
        return null;
      },
    );
  }

  void _submitForm(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      // Collect personal information
      String fullName = _fullNameController.text;
      String email = _emailController.text;
      String phone = _phoneController.text;
      String location = _locationController.text;

      // Collect work history
      List<Map<String, String>> workHistory = _workHistory.map((work) {
        return {
          'Company': work['Company']!.text,
          'Position': work['Position']!.text,
          'Years': work['Years']!.text
        };
      }).toList();

      // Collect dynamic fields
      List<String> profession =
          _profession.map((controller) => controller.text).toList();
      List<String> education =
          _education.map((controller) => controller.text).toList();
      List<String> skills =
          _skills.map((controller) => controller.text).toList();
      List<String> jobPreferences =
          _jobPreferences.map((controller) => controller.text).toList();

      // Collect links & resume
      String resumePath = _resumePathController.text;
      String linkedinUrl = _linkedinUrlController.text;
      String portfolioUrl = _portfolioUrlController.text;

      // Collect bio
      String bio = _bioController.text;

      // Package all data into a map to send to the backend
      Map<String, dynamic> profileData = {
        'full_name': fullName,
        'email': email,
        'phone': phone,
        'location': location,
        'work_history': workHistory,
        'profession': profession,
        'education': education,
        'skills': skills,
        'job_preferences': jobPreferences,
        'resume_path': resumePath,
        'linkedin_url': linkedinUrl,
        'portfolio_url': portfolioUrl,
        'bio': bio,
      };

      // Call the function to update the profile data
      _updateProfile(context, profileData);

      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Updating Your Profile......")));
    }
  }
}

Future<void> _updateProfile(
    BuildContext context, Map<String, dynamic> profileData) async {
  final user = Supabase.instance.client.auth.currentUser;

  if (user == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("User is not authenticated.")),
    );
    return;
  }

  try {
    // Define the table in Supabase (e.g., 'customers')
    final response = await Supabase.instance.client
        .from('customers')
        .upsert({
          'id': user.id, // Assuming 'id' is the user's identifier in Supabase
          'full_name': profileData['full_name'],
          'email': profileData['email'],
          'phone': profileData['phone'],
          'location': profileData['location'],
          'work_history': profileData['work_history'],
          'profession': profileData['profession'],
          'education': profileData['education'],
          'skills': profileData['skills'],
          'job_preferences': profileData['job_preferences'],
          'resume_path': profileData['resume_path'],
          'linkedin_url': profileData['linkedin_url'],
          'portfolio_url': profileData['portfolio_url'],
          'bio': profileData['bio'],
          'is_completed': true,
        })
        .eq('id', user.id)
        .select();

    // Check if the response is successful (there might not be an error property directly in PostgrestList)
    if (response.error != null) {
      // Handle any errors that occur during the operation
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${response.error!.message}')),
      );
      return;
    }

    // If the update was successful, show a success message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Profile Updated Successfully! 🎉")),
    );

    // Redirect the user to the Account page

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const MainScreen(initialTab: 4, isLoggedIn: true),
      ),
    );
  } catch (e) {
    // Handle unexpected errors
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('An unexpected error occurred: $e')),
    );
  }
}

extension on PostgrestList {
  get error => null;
}
