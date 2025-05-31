import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:vephi/main.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class CompleteProfile extends StatelessWidget {
  const CompleteProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return const CompleteProfileForm();  // Just return the form widget
  }
}

class CompleteProfileForm extends StatefulWidget {
  const CompleteProfileForm({super.key});

  @override
  _CompleteProfileFormState createState() => _CompleteProfileFormState();
}

class _CompleteProfileFormState extends State<CompleteProfileForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  int _currentStep = 0;
  final PageController _pageController = PageController();

  // Personal Details Controllers
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  // Work & Education
  final List<Map<String, TextEditingController>> _workHistory = [];
  final List<TextEditingController> _profession = [];
  final List<TextEditingController> _education = [];
  final List<TextEditingController> _skills = [];
  final List<TextEditingController> _jobPreferences = [];

  // Links & Resume Controllers
  final TextEditingController _resumePathController = TextEditingController();
  final TextEditingController _linkedinUrlController = TextEditingController();
  final TextEditingController _portfolioUrlController = TextEditingController();

  // Add these variables to your state class
  final List<String> _certificates = [];
  String? _resumePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        elevation: 0,
        title: const Text(
          "Complete Your Profile",
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          _buildProgressIndicator(),
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildPersonalInfoPage(),
                _buildWorkEducationPage(),
                _buildLinksBioPage(),
              ],
            ),
          ),
          _buildNavigationButtons(isLastPage: _currentStep == 2),
        ],
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          for (int i = 0; i < 3; i++)
            Expanded(
              child: Container(
                height: 4,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  color: i <= _currentStep ? Colors.blueAccent : Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildPersonalInfoPage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            _buildProfilePicture(),
            const SizedBox(height: 24),
            _buildSection(
              title: 'Personal Information',
              subtitle: 'Tell us about yourself',
              children: [
                _buildTextField(
                  _fullNameController,
                  'Full Name',
                  Icons.person,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter your full name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  _emailController,
                  'Email',
                  Icons.email,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter your email';
                    }
                    if (!value!.contains('@')) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  _phoneController,
                  'Phone',
                  Icons.phone,
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter your phone number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  _locationController,
                  'Location',
                  Icons.location_on,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter your location';
                    }
                    return null;
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),

          ],
        ),
      ),
    );
  }

  Widget _buildWorkEducationPage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Column(
            children: [
              _buildSection(
                title: 'Work & Education',
                subtitle: 'Share your professional background',
                children: [
                  _buildWorkHistory(),
                  const SizedBox(height: 24),
                  _buildDynamicField("Profession", _profession, "Add Profession"),
                  const SizedBox(height: 24),
                  _buildDynamicField("Education", _education, "Add Education"),
                  const SizedBox(height: 24),
                  _buildDynamicField("Skills", _skills, "Add Skill"),
                  const SizedBox(height: 24),
                  _buildDynamicField("Job Preferences", _jobPreferences, "Add Preference"),
                  const SizedBox(height: 24),
                  _buildFileUpload("Certificates", _certificates, "Add Certificate"),
                  const SizedBox(height: 24),
                  _buildResumeUpload(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLinksBioPage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildSection(
            title: 'Links & Bio',
            subtitle: 'Add your professional links',
            children: [
              _buildResumeUpload(),
              const SizedBox(height: 16),
              _buildTextField(
                _linkedinUrlController,
                'LinkedIn URL',
                Icons.link,
                keyboardType: TextInputType.url,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                _portfolioUrlController,
                'Portfolio URL',
                Icons.link,
                keyboardType: TextInputType.url,
              ),
            ],
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildProfilePicture() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: const CircleAvatar(
            radius: 60,
            backgroundColor: Colors.grey,
            child: Icon(Icons.person, size: 60, color: Colors.white),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.blueAccent,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.blueAccent.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: IconButton(
              icon: const Icon(Icons.camera_alt, color: Colors.white),
              onPressed: () {
                // Implement image picker
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSection({
    required String title,
    required String subtitle,
    required List<Widget> children,
  }) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(
        maxWidth: 600,
      ),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 20),
              ...children,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label,
    IconData icon, {
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.blueAccent),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.blueAccent),
        ),
        filled: true,
        fillColor: Colors.grey[50],
      ),
      keyboardType: keyboardType,
      validator: validator,
    );
  }

  Widget _buildNavigationButtons({bool isLastPage = false}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, -1),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (_currentStep > 0)
            TextButton.icon(
              onPressed: () {
                setState(() {
                  _currentStep--;
                  _pageController.previousPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                });
              },
              icon: const Icon(Icons.arrow_back),
              label: const Text('Back'),
            )
          else
            const SizedBox.shrink(),
          ElevatedButton(
            onPressed: _isLoading
                ? null
                : () async {
                    setState(() {
                      _isLoading = true;
                    });
                    _submitForm(context);
                    setState(() {
                      _isLoading = false;
                    });
                  },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2D82FF),
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            child: _isLoading
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      strokeWidth: 2.5,
                    ),
                  )
                : const Text(
                    'Complete Profile',
                    style: TextStyle(color: Colors.white),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildWorkHistory() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Work History",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8),
        ..._workHistory.asMap().entries.map((entry) {
          int index = entry.key;
          var data = entry.value;
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildTextField(
                    data['Company']!,
                    'Company Name',
                    Icons.business,
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter company name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    data['Position']!,
                    'Position',
                    Icons.work,
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter position';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    data['Years']!,
                    'Years Worked',
                    Icons.calendar_today,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter years worked';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton.icon(
                      onPressed: () => setState(() => _workHistory.removeAt(index)),
                      icon: const Icon(Icons.delete, color: Colors.red, size: 20),
                      label: const Text(
                        'Remove',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          icon: const Icon(Icons.add, color: Colors.white),
          label: Text(
            _workHistory.isEmpty ? "Add Work History" : "Add More Work History",
            style: const TextStyle(color: Colors.white),
          ),
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
    String label,
    List<TextEditingController> controllers,
    String addButtonText,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8),
        ...controllers.asMap().entries.map((entry) {
          int index = entry.key;
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildTextField(
                    entry.value,
                    label,
                    Icons.edit,
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter $label';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton.icon(
                      onPressed: () => setState(() => controllers.removeAt(index)),
                      icon: const Icon(Icons.delete, color: Colors.red, size: 20),
                      label: const Text(
                        'Remove',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          icon: const Icon(Icons.add, color: Colors.white),
          label: Text(
            controllers.isEmpty ? "Add $label" : "Add More $label",
            style: const TextStyle(color: Colors.white),
          ),
          onPressed: () => setState(() => controllers.add(TextEditingController())),
        ),
      ],
    );
  }

  Future<String> _saveFileLocally(File file) async {
    final directory = await getApplicationDocumentsDirectory();
    final fileName = '${DateTime.now().millisecondsSinceEpoch}_${file.path.split('/').last}';
    final savedFile = await file.copy('${directory.path}/$fileName');
    return savedFile.path;
  }

  Widget _buildFileUpload(String label, List<String> files, String addButtonText) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8),
        ...files.asMap().entries.map((entry) {
          int index = entry.key;
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: const Icon(Icons.description),
              title: Text(entry.value.split('/').last),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () => setState(() => files.removeAt(index)),
              ),
            ),
          );
        }),
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          icon: const Icon(Icons.upload_file, color: Colors.white),
          label: Text(
            files.isEmpty ? addButtonText : "Add More $label",
            style: const TextStyle(color: Colors.white),
          ),
          onPressed: () async {
            final result = await FilePicker.platform.pickFiles(
              type: FileType.custom,
              allowedExtensions: ['pdf', 'doc', 'docx'],
            );
            
            if (result != null) {
              final file = File(result.files.single.path!);
              final savedPath = await _saveFileLocally(file);
              setState(() {
                files.add(savedPath);
              });
            }
          },
        ),
      ],
    );
  }

  Widget _buildResumeUpload() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Resume/CV",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8),
        if (_resumePath != null)
          Card(
            margin: const EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: const Icon(Icons.description),
              title: Text(_resumePath!.split('/').last),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () => setState(() => _resumePath = null),
              ),
            ),
          ),
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          icon: const Icon(Icons.upload_file, color: Colors.white),
          label: Text(
            _resumePath == null ? "Upload Resume/CV" : "Change Resume/CV",
            style: const TextStyle(color: Colors.white),
          ),
          onPressed: () async {
            final result = await FilePicker.platform.pickFiles(
              type: FileType.custom,
              allowedExtensions: ['pdf', 'doc', 'docx'],
            );
            
            if (result != null) {
              final file = File(result.files.single.path!);
              final savedPath = await _saveFileLocally(file);
              setState(() {
                _resumePath = savedPath;
              });
            }
          },
        ),
      ],
    );
  }

  void _submitForm(BuildContext context) {
    try {
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
      List<String> profession = _profession.map((controller) => controller.text).toList();
      List<String> education = _education.map((controller) => controller.text).toList();
      List<String> skills = _skills.map((controller) => controller.text).toList();
      List<String> jobPreferences = _jobPreferences.map((controller) => controller.text).toList();

      // Collect links & resume
      String resumePath = _resumePathController.text;
      String linkedinUrl = _linkedinUrlController.text;
      String portfolioUrl = _portfolioUrlController.text;

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
        'is_completed': true,
        'updated_at': DateTime.now().toIso8601String(),
      };

      // Call the function to update the profile data
      _updateProfile(context, profileData);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _updateProfile(BuildContext context, Map<String, dynamic> profileData) async {
    final user = Supabase.instance.client.auth.currentUser;

    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("User is not authenticated."),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      // First, update the auth user's metadata
      await Supabase.instance.client.auth.updateUser(
        UserAttributes(
          data: {
            'full_name': profileData['full_name'],
            'phone': profileData['phone'],
          },
        ),
      );

      // Then update the customer profile
      final response = await Supabase.instance.client
          .from('customers')
          .upsert({
            'customer_id': user.id,
            'full_name': profileData['full_name'],
            'email': profileData['email'],
            'phone': profileData['phone'],
            'location': profileData['location'],
            'work_history': profileData['work_history'],
            'profession': profileData['profession'],
            'education': profileData['education'],
            'skills': profileData['skills'],
            'job_preferences': profileData['job_preferences'],
            'certificates': _certificates,
            'resume_path': _resumePath,
            'linkedin_url': profileData['linkedin_url'],
            'portfolio_url': profileData['portfolio_url'],
            'is_completed': true,
            'updated_at': DateTime.now().toIso8601String(),
          })
          .eq('customer_id', user.id)
          .select();

      if (response.error != null) {
        throw response.error!;
      }

      // Navigate to HomePage and clear navigation stack
      if (mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (_) => const MainScreen(initialTab: 0, isLoggedIn: true),
          ),
          (route) => false,
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error updating profile: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}

extension on PostgrestList {
  get error => null;
}
