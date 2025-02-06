import 'package:flutter/material.dart';

class JobDetails extends StatelessWidget {
  final String title;
  final String company;
  final String type;
  final String level;
  final String location;
  final String time;

  const JobDetails({
    super.key,
    required this.title,
    required this.company,
    required this.type,
    required this.level,
    required this.location,
    required this.time, required Map<String, dynamic> job,
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
                    height: 300,
                    width: double.infinity,
                    child: Card(
                      elevation: 4,
                      color: const Color(0xFF2D82FF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.white, width: 1),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Image.asset(
                                      'lib/assets/logo.png',
                                      height: 60,
                                      width: 60,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                const Expanded(
                                  child: Text(
                                    'Lilongwe Waterboard',
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            const Text('Position: ',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white)),
                            const SizedBox(height: 10),
                            Text('Level: $level',
                                style: const TextStyle(
                                    fontSize: 18, color: Colors.white)),
                            const SizedBox(height: 10),
                            Text('Location: $location',
                                style: const TextStyle(
                                    fontSize: 18, color: Colors.white)),
                            const SizedBox(height: 10),
                            Text('Posted: $time',
                                style: const TextStyle(
                                    fontSize: 18, color: Colors.white)),
                            const SizedBox(height: 10),
                            Text('Deadline: $type',
                                style: const TextStyle(
                                    fontSize: 18, color: Colors.white)),
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
                  const Padding(
                    padding: EdgeInsets.only(left: 10.0, right: 10),
                    child: Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam gravida quam quis consequat vulputate. Morbi ultrices in sem pretium sagittis. Suspendisse vestibulum orci et felis cursus, at dignissim justo fringilla. Vivamus ipsum sapien, semper quis vestibulum at, faucibus eu lacus. Vestibulum nulla eros, commodo eu scelerisque at, viverra nec nisl. In euismod ac enim sit amet scelerisque. Nullam bibendum vitae augue id facilisis. Nam fermentum ornare rutrum. Praesent quis nulla tortor. Curabitur ut ante risus. Maecenas eget odio id nisi sagittis lacinia at a ex. Mauris malesuada pharetra leo, quis finibus nisl. Praesent lobortis dapibus condimentum',
                      style: TextStyle(
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
                  const Padding(
                    padding: EdgeInsets.only(left: 10.0, right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BulletPoint(
                            'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'),
                        BulletPoint(
                            'Etiam gravida quam quis consequat vulputate.'),
                        BulletPoint('Morbi ultrices in sem pretium sagittis.'),
                        BulletPoint(
                            'Suspendisse vestibulum orci et felis cursus.'),
                        BulletPoint(
                            'Vivamus ipsum sapien, semper quis vestibulum at.'),
                        BulletPoint(
                            'Vestibulum nulla eros, commodo eu scelerisque at, viverra nec nisl.'),
                        BulletPoint('In euismod ac enim sit amet scelerisque.'),
                        BulletPoint(
                            'Nullam bibendum vitae augue id facilisis.'),
                      ],
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
                  const Padding(
                    padding: EdgeInsets.only(left: 10.0, right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BulletPoint(
                            'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'),
                        BulletPoint(
                            'Etiam gravida quam quis consequat vulputate.'),
                        BulletPoint('Morbi ultrices in sem pretium sagittis.'),
                        BulletPoint(
                            'Suspendisse vestibulum orci et felis cursus.'),
                        BulletPoint(
                            'Vivamus ipsum sapien, semper quis vestibulum at.'),
                        BulletPoint(
                            'Vestibulum nulla eros, commodo eu scelerisque at, viverra nec nisl.'),
                        BulletPoint('In euismod ac enim sit amet scelerisque.'),
                        BulletPoint(
                            'Nullam bibendum vitae augue id facilisis.'),
                      ],
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
