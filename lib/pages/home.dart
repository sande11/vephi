import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.white,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Hello Kelvin',
              style: TextStyle(color: Colors.grey, fontSize: 18),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Find your next job',
                  style: TextStyle(
                      color: Color.fromRGBO(27, 27, 27, 1),
                      fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.notifications,
                    color: Colors.black,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF9F9F9),
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  // BoxShadow(
                  //   color: Colors.grey,
                  //   offset: Offset(1, 2),
                  // ),
                ],
              ),
              child: const TextField(
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  hintText: 'Search...',
                  border: InputBorder.none,
                  prefixIcon: Icon(
                    Icons.search,
                    color: Color(0xFF2D82FF),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                ),
              ),
            ),
          ),
          Column(
            children: [
              Container(
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.only(left: 25),
                child: const Text(
                  'Best Fit',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Color.fromRGBO(27, 27, 27, 1)),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 4,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8),
            child: SizedBox(
              height: 162,
              width: double.infinity,
              child: Card(
                elevation: 5,
                color: const Color(0xFF2D82FF),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/company_logo.png'),
                            radius: 20,
                          ),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Software Engineer',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                'Microsoft',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          // Save Icon
                          Icon(Icons.bookmark_border, color: Colors.white),
                        ],
                      ),
                      const SizedBox(height: 12),

                      // Second row with job type and seniority level
                      Wrap(
                        spacing: 10,
                        children: [
                          // Full Time
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 10),
                            decoration: BoxDecoration(
                              color: Colors.blue[500],
                              borderRadius: BorderRadius.circular(2),
                            ),
                            child: const Text(
                              'Full Time',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          // Senior Level
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 10),
                            decoration: BoxDecoration(
                              color: Colors.blue[500],
                              borderRadius: BorderRadius.circular(2),
                            ),
                            child: const Text(
                              'Senior Level',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),

                      // Third row with location and time
                      const SizedBox(height: 8),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'New York',
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            '20 hours ago',
                            style: TextStyle(color: Colors.white70),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Column(
            children: [
              Container(
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.only(left: 25),
                child: const Text(
                  'All Jobs',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Color.fromRGBO(27, 27, 27, 1)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
