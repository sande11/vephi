import 'package:flutter/material.dart';

class CompleteProfile extends StatelessWidget {
  const CompleteProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        elevation: 2,
        title: const Text(
          "Complete Profile",
          style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromRGBO(27, 27, 27, 1)),
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
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _professionController = TextEditingController();
  final TextEditingController _experienceController = TextEditingController();
  final TextEditingController _resumePathController = TextEditingController();
  final TextEditingController _skillsController = TextEditingController();
  final TextEditingController _linkedinUrlController = TextEditingController();
  final TextEditingController _portfolioUrlController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _jobPreferencesController =
      TextEditingController();
  final TextEditingController _educationController = TextEditingController();
  final TextEditingController _workHistoryController = TextEditingController();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(
        top: 25,
        left: 16,
        right: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            // Profile Picture Upload
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey[400],
                    backgroundImage:
                        const AssetImage('assets/profile_placeholder.png'),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () {
                        // Add image upload logic here
                      },
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: const BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.camera_alt,
                            color: Colors.white, size: 20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            _buildTextField(_fullNameController, 'Full Name'),
            _buildTextField(_emailController, 'Email',
                keyboardType: TextInputType.emailAddress),
            _buildTextField(_phoneController, 'Phone',
                keyboardType: TextInputType.phone),
            _buildTextField(_locationController, 'Location'),
            _buildTextField(_professionController, 'Profession'),
            _buildTextField(_experienceController, 'Experience (Years)',
                keyboardType: TextInputType.number),
            _buildTextField(_resumePathController, 'Resume Path'),
            _buildTextField(_skillsController, 'Skills'),
            _buildTextField(_linkedinUrlController, 'LinkedIn URL'),
            _buildTextField(_portfolioUrlController, 'Portfolio URL'),
            _buildTextField(_bioController, 'Bio'),
            _buildTextField(_jobPreferencesController, 'Job Preferences'),
            _buildTextField(_educationController, 'Education'),
            _buildTextField(_workHistoryController, 'Work History'),

            const SizedBox(height: 20),

            // Submit Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: _isLoading ? null : _submitForm,
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        'Submit',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Common text field builder
  Widget _buildTextField(TextEditingController controller, String labelText,
      {TextInputType keyboardType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(),
          filled: true,
          fillColor: Colors.white,
        ),
        keyboardType: keyboardType,
        validator: (value) =>
            value == null || value.isEmpty ? 'Please enter $labelText' : null,
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      // TODO: Handle form submission

      Future.delayed(const Duration(seconds: 2), () {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Profile updated successfully!")),
        );
      });
    }
  }
}
