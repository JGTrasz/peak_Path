import 'package:flutter/material.dart';

class HomeMountainScreen extends StatelessWidget {
  const HomeMountainScreen({super.key});

  void _navigateToPulag(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const MountainDetailScreen(
          mountainName: 'Mount Pulag',
          mountainImages: [
            'assets/images/pulag.jpeg',
            'assets/images/pulag2.jpeg'
          ],
          equipment:
              'Standard hiking gear, water, food, and camping equipment if staying overnight.',
          tracks:
              'Multiple tracks available ranging from beginner to expert levels.',
          height: '2,922 m',
          description: 'The third highest mountain in the Philippines, known for its sea of clouds.',
        ),
      ),
    );
  }

  void _navigateToApo(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const MountainDetailScreen(
          mountainName: 'Mount Apo',
          mountainImages: [
            'assets/images/mount_apo.jpeg',
            'assets/images/mount_apo2.jpeg'
          ],
          equipment:
              'Standard hiking gear, water, food, and camping equipment if staying overnight.',
          tracks:
              'Multiple tracks available ranging from beginner to expert levels.',
          height: '2,954 m',
          description: 'The highest mountain in the Philippines, offering challenging trails and breathtaking views.',
        ),
      ),
    );
  }

  void _navigateToMayon(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const MountainDetailScreen(
          mountainName: 'Mount Mayon',
          mountainImages: [
            'assets/images/mount_mayon.jpeg',
            'assets/images/mount_mayon2.jpeg'
          ],
          equipment:
              'Standard hiking gear, water, food, and camping equipment if staying overnight.',
          tracks:
              'Multiple tracks available ranging from beginner to expert levels.',
          height: '2,463 m',
          description: 'An active stratovolcano known for its perfect cone shape.',
        ),
      ),
    );
  }

  void _navigateToPinatubo(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const MountainDetailScreen(
          mountainName: 'Mount Pinatubo',
          mountainImages: [
            'assets/images/mount_pinatubo.jpeg',
            'assets/images/mount_pinatubo2.jpeg'
          ],
          equipment:
              'Standard hiking gear, water, food, and camping equipment if staying overnight.',
          tracks:
              'Multiple tracks available ranging from beginner to expert levels.',
          height: '1,486 m',
          description: 'Famous for its crater lake formed after the 1991 eruption.',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Homepage'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header text
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Where do you like to go?',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // Horizontal categories
            SizedBox(
              height: 150, // Adjust height as needed
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  GestureDetector(
                    onTap: () => _navigateToPulag(context),
                    child: _buildCategory('Most Popular', 'assets/images/pulag2.jpeg'),
                  ),
                  GestureDetector(
                    onTap: () => _navigateToApo(context),
                    child: _buildCategory('Top Viewed', 'assets/images/mount_mayon.jpeg'),
                  ),
                  GestureDetector(
                    onTap: () => _navigateToMayon(context),
                    child: _buildCategory('Mount', 'assets/images/mount_apo.jpeg'),
                  ),
                  GestureDetector(
                    onTap: () => _navigateToPinatubo(context),
                    child: _buildCategory('Nature', 'assets/images/mount_pinatubo2.jpeg'),
                  ),
                ],
              ),
            ),
            // Grid view for mountains
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Explore Mountains',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0), // Add margin here
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: 12, // Adjust item count as needed
                itemBuilder: (context, index) {
                  return _buildMountainImage(
                      'assets/pictures/mount_${index + 1}.jpeg');
                },
              ),
            ),
            const SizedBox(height: 16), // Add minimal margin here
          ],
        ),
      ),
    );
  }

  Widget _buildCategory(String title, String imagePath) {
    return Container(
      width: 120, // Adjust width as needed
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          Expanded(
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
            ),
          ),
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildMountainImage(String imagePath) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class MountainDetailScreen extends StatelessWidget {
  final String mountainName;
  final List<String> mountainImages;
  final String equipment;
  final String tracks;
  final String height;
  final String description;

  const MountainDetailScreen({
    super.key,
    required this.mountainName,
    required this.mountainImages,
    required this.equipment,
    required this.tracks,
    required this.height,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(mountainName),
              background: Image.asset(
                mountainImages[0],
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.description, size: 24),
                        SizedBox(width: 8),
                        Text(
                          'Description',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      description,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 16),
                    const Row(
                      children: [
                        Icon(Icons.height, size: 24),
                        SizedBox(width: 8),
                        Text(
                          'Height',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      height,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 16),
                    const Row(
                      children: [
                        Icon(Icons.terrain, size: 24),
                        SizedBox(width: 8),
                        Text(
                          'Tracks',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      tracks,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 16),
                    const Row(
                      children: [
                        Icon(Icons.backpack, size: 24),
                        SizedBox(width: 8),
                        Text(
                          'Equipment',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      equipment,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
