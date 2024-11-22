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
    required this.time,
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
                // Add share functionality her
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
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 300,
                width: double.infinity,
                child: Card(
                  elevation: 4,
                  color: const Color(0xFF2D82FF), // Card color
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
                              child: Image.network(
                                'https://via.placeholder.com/60', // Placeholder for logo
                                height: 60,
                                width: 60,
                                fit: BoxFit.cover,
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
                            style:
                                TextStyle(fontSize: 18, color: Colors.white)),
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
              const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text(
                  'About Job',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
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
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
            ],
          ),
        ));
  }
}
