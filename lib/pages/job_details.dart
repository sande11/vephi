import 'package:flutter/material.dart';

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
              // Add share functionality here
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.bookmark_border,
              color: Colors.white,
            ),
            onPressed: () {
              // Add save functionality here
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 80),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 190,
                    width: double.infinity,
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
                              children: [
                                ClipRRect(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                Column(
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
                                Column(
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
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Divider and other content
                  const Padding(
                    padding: EdgeInsets.only(top: 0, left: 10, right: 10),
                    child: Divider(
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      'About $company',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(27, 27, 27, 1),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10),
                    child: Text(
                      aboutCompany,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: Color.fromRGBO(27, 27, 27, 1),
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),

                  const SizedBox(height: 10),
                  // Divider and other content
                  const Padding(
                    padding: EdgeInsets.only(top: 0, left: 10, right: 10),
                    child: Divider(
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(
                      'About Job',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(27, 27, 27, 1),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10),
                    child: Text(
                      aboutPosition,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: Color.fromRGBO(27, 27, 27, 1),
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),

                  const SizedBox(height: 10),
                  // divider
                  const Padding(
                    padding: EdgeInsets.only(top: 0, left: 10, right: 10),
                    child: Divider(
                      color: Colors.grey,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(
                      'Job Responsibilities',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(27, 27, 27, 1),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: responsibilities
                          .map((responsibility) => BulletPoint(responsibility))
                          .toList(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // divider
                  const Padding(
                    padding: EdgeInsets.only(top: 0, left: 10, right: 10),
                    child: Divider(
                      color: Colors.grey,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(
                      'Qualifications Required',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(27, 27, 27, 1),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: qualifications
                          .map((qualification) => BulletPoint(qualification))
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 3,
            left: 20,
            right: 20,
            child: Container(
              height: 60,
              width: double.infinity,
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
                      fontWeight: FontWeight.bold),
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
