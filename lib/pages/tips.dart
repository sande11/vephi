import 'package:flutter/material.dart';

class ExpandableText extends StatefulWidget {
  final String text;
  const ExpandableText({super.key, required this.text});

  @override
  _ExpandableTextState createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.text,
          style: const TextStyle(fontSize: 14, color: Colors.white),
          maxLines: isExpanded ? null : 4, // Show all lines if expanded
          overflow: isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              isExpanded = !isExpanded;
            });
          },
          child: Text(
            isExpanded ? 'See Less' : 'See More',
            style: const TextStyle(
              fontSize: 18,
              color: Colors.white70,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

class Tips extends StatelessWidget {
  const Tips({super.key});

  @override
  Widget build(BuildContext context) {
    // Placeholder variables
    String profileImage = 'https://via.placeholder.com/150';
    String name = 'John Doe';
    String jobTitle = 'Software Engineer';
    String companyName = 'Tech Company';
    String timePosted = '2 hours ago';
    String postContent =
        'Cras sed urna sed leo elementum tempus in vitae nisi. Sed ut dui a libero dictum pulvinar quis lobortis enim. Phasellus eu semper enim. Fusce hendrerit diam sit amet risus bibendum mollis. Proin posuere pharetra nibh, ac tristique sem fermentum iaculis. Nulla venenatis, metus eget vulputate rutrum, augue mauris dignissim odio, at interdum augue odio vitae sapien';
    String likes = '10';
    String comments = '5';

    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        toolbarHeight: 90,
        elevation: 4,
        backgroundColor: Colors.grey[200],
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
                  'A few tips for you',
                  style: TextStyle(
                    color: Color.fromRGBO(27, 27, 27, 1),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.notifications,
                        color: Colors.black,
                      ),
                      padding: const EdgeInsets.all(0),
                      constraints: const BoxConstraints(),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.bookmark_border,
                        color: Colors.black,
                      ),
                      padding: const EdgeInsets.all(0),
                      constraints: const BoxConstraints(),
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      body: Column(children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFF9F9F9),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const TextField(
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                        hintText: 'Search...',
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.search,
                          color: Color(0xFF2D82FF),
                        ),
                        suffixIcon: Icon(
                          Icons.filter_list,
                          color: Color(0xFF2D82FF),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 0.3),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 2.0),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8, top: 0),
                  child: Card(
                    elevation: 5,
                    color: const Color(0xFF2D82FF),
                    margin:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Header: Profile Picture, Name, Job Title, and Timestamp
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Profile Image
                              CircleAvatar(
                                radius: 25,
                                backgroundImage: NetworkImage(profileImage),
                              ),
                              const SizedBox(width: 12),
                              // Name and Job Details
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      name,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      '$jobTitle at $companyName',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      timePosted,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          // Post Content
                          ExpandableText(
                            text: postContent,
                          ),
                          const SizedBox(height: 12),
                          // Footer: Likes and Comments
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Likes
                              // Row(
                              //   children: [
                              //     const Icon(
                              //       Icons.thumb_up_alt_outlined,
                              //       size: 20,
                              //       color: Colors.white,
                              //     ),
                              //     const SizedBox(width: 4),
                              //     Text(
                              //       likes,
                              //       style: const TextStyle(
                              //         fontSize: 14,
                              //         color: Colors.white,
                              //       ),
                              //     ),
                              //   ],
                              // ),
                              // // Comments
                              // Row(
                              //   children: [
                              //     const Icon(
                              //       Icons.comment_outlined,
                              //       size: 20,
                              //       color: Colors.white,
                              //     ),
                              //     const SizedBox(width: 4),
                              //     Text(
                              //       comments,
                              //       style: const TextStyle(
                              //         fontSize: 14,
                              //         color: Colors.white,
                              //       ),
                              //     ),
                              //   ],
                              // ),
                              // Share Button
                              const SizedBox(
                                width: 30,
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.share_outlined,
                                  size: 20,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  // Add share functionality here
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // card
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8, top: 8),
                  child: Card(
                    elevation: 5,
                    color: const Color(0xFF2D82FF),
                    margin:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Header: Profile Picture, Name, Job Title, and Timestamp
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Profile Image
                              CircleAvatar(
                                radius: 25,
                                backgroundImage: NetworkImage(profileImage),
                              ),
                              const SizedBox(width: 12),
                              // Name and Job Details
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      name,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      '$jobTitle at $companyName',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      timePosted,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          // Post Content
                          ExpandableText(
                            text: postContent,
                          ),
                          const SizedBox(height: 12),
                          // Footer: Likes and Comments
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Likes
                              // Row(
                              //   children: [
                              //     const Icon(
                              //       Icons.thumb_up_alt_outlined,
                              //       size: 20,
                              //       color: Colors.white,
                              //     ),
                              //     const SizedBox(width: 4),
                              //     Text(
                              //       likes,
                              //       style: const TextStyle(
                              //         fontSize: 14,
                              //         color: Colors.white,
                              //       ),
                              //     ),
                              //   ],
                              // ),
                              // // Comments
                              // Row(
                              //   children: [
                              //     const Icon(
                              //       Icons.comment_outlined,
                              //       size: 20,
                              //       color: Colors.white,
                              //     ),
                              //     const SizedBox(width: 4),
                              //     Text(
                              //       comments,
                              //       style: const TextStyle(
                              //         fontSize: 14,
                              //         color: Colors.white,
                              //       ),
                              //     ),
                              //   ],
                              // ),
                              // Share Button
                              const SizedBox(
                                width: 30,
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.share_outlined,
                                  size: 20,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  // Add share functionality here
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
