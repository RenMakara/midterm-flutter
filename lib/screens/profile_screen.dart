import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Cover photo placeholder
            Container(
              height: 140,
              width: double.infinity,
              color: Colors.grey.shade300,
              child: const Center(
                child: Text('Cover Photo Placeholder'),
              ),
            ),

            const SizedBox(height: 8),

            // Profile picture
            Transform.translate(
              offset: const Offset(0, -50), // Moves the profile pic up
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(4), // White border effect
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const CircleAvatar(
                      radius: 48,
                      backgroundColor: Colors.blue,
                      child: Icon(Icons.person, size: 48, color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'User Name',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  // Stats
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _stat('Posts', '10'),
                      const SizedBox(width: 24),
                      _stat('Followers', '120'),
                      const SizedBox(width: 24),
                      _stat('Following', '200'),
                    ],
                  ),
                  const SizedBox(height: 15),
                  // Button
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('Edit Profile'),
                      ),
                    ),
                  ),
                ],
              ),
            ),


            const Divider(), // Separator line

            GridView.builder(
              padding: const EdgeInsets.all(2),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 15,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 2,
                mainAxisSpacing: 2,
              ),
              itemBuilder: (context, index) {
                return Container(
                  color: Colors.grey[200],
                  child: Image.network(
                      'https://picsum.photos/200?random=$index', // Random placeholder images
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.image, color: Colors.grey);
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _stat(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        Text(
          label,
          style: TextStyle(color: Colors.grey[600]),
        ),
      ],
    );
  }
}
