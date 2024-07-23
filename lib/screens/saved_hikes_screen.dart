import 'package:flutter/material.dart';

class HikingActivitiesScreen extends StatefulWidget {
  const HikingActivitiesScreen({super.key});

  @override
  _HikingActivitiesScreenState createState() => _HikingActivitiesScreenState();
}

class _HikingActivitiesScreenState extends State<HikingActivitiesScreen> {
  ValueNotifier<int?> expandedCardIndex = ValueNotifier<int?>(null);

  @override
  void dispose() {
    expandedCardIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mountain Hiking Activities'),
        backgroundColor: theme.primaryColor,
        elevation: 4,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isDarkMode
                ? [Colors.black87, Colors.black54]
                : [Colors.white, Colors.grey[200]!],
          ),
        ),
        child: ValueListenableBuilder<int?>(
          valueListenable: expandedCardIndex,
          builder: (context, expandedIndex, child) {
            return ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                ActivityCard(
                  images: [
                    'assets/images/marking1.jpeg',
                    'assets/images/marking2.jpeg',
                    'assets/images/marking3.jpeg',
                    'assets/images/marking4.jpeg',
                  ],
                  title: 'Trail Marking',
                  details: [
                    'Learn how to recognize and follow trail markers.',
                    'Understand the different types of markers used in various terrains.',
                    'Practice marking your own trail using environmentally friendly materials.',
                  ],
                  index: 0,
                  expandedCardIndex: expandedCardIndex,
                ),
                ActivityCard(
                  images: [
                    'assets/images/reading1.jpeg',
                    'assets/images/reading2.jpeg',
                    'assets/images/reading3.jpeg',
                    'assets/images/reading4.jpeg',
                  ],
                  title: 'Map Reading',
                  details: [
                    'Study topographic maps to understand the terrain.',
                    'Practice reading contour lines and elevation changes.',
                    'Use a map to plan your route and identify key landmarks.',
                  ],
                  index: 1,
                  expandedCardIndex: expandedCardIndex,
                ),
                ActivityCard(
                  images: [
                    'assets/images/climbing1.jpeg',
                    'assets/images/climbing2.jpeg',
                    'assets/images/climbing3.jpeg',
                    'assets/images/climbing4.jpeg',
                  ],
                  title: 'Rock Climbing',
                  details: [
                    'Learn the basics of rock climbing and safety measures.',
                    'Practice climbing techniques on different types of rocks.',
                    'Understand the importance of using proper climbing gear.',
                  ],
                  index: 2,
                  expandedCardIndex: expandedCardIndex,
                ),
                ActivityCard(
                  images: [
                    'assets/images/camping1.jpeg',
                    'assets/images/camping2.jpeg',
                    'assets/images/camping3.jpeg',
                    'assets/images/camping4.jpeg',
                  ],
                  title: 'Camping',
                  details: [
                    'Find suitable spots for setting up a camp.',
                    'Learn how to pitch a tent and create a comfortable campsite.',
                    'Understand the principles of Leave No Trace to minimize your impact.',
                  ],
                  index: 3,
                  expandedCardIndex: expandedCardIndex,
                ),
                ActivityCard(
                  images: [
                    'assets/images/watching1.jpeg',
                    'assets/images/watching2.jpeg',
                    'assets/images/watching3.jpeg',
                    'assets/images/watching4.jpeg',
                  ],
                  title: 'Wildlife Watching',
                  details: [
                    'Identify local wildlife and understand their behavior.',
                    'Learn how to observe animals without disturbing them.',
                    'Practice using binoculars and cameras to capture wildlife moments.',
                  ],
                  index: 4,
                  expandedCardIndex: expandedCardIndex,
                ),
                ActivityCard(
                  images: [
                    'assets/images/identification1.jpeg',
                    'assets/images/identification2.jpeg',
                    'assets/images/identification3.jpeg',
                    'assets/images/identification4.jpeg',
                  ],
                  title: 'Plant Identification',
                  details: [
                    'Study local flora and learn to identify different plant species.',
                    'Understand the importance of plants in the ecosystem.',
                    'Practice using field guides and apps for plant identification.',
                  ],
                  index: 5,
                  expandedCardIndex: expandedCardIndex,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class ActivityCard extends StatelessWidget {
  final List<String> images;
  final String title;
  final List<String> details;
  final int index;
  final ValueNotifier<int?> expandedCardIndex;

  const ActivityCard({
    Key? key,
    required this.images,
    required this.title,
    required this.details,
    required this.index,
    required this.expandedCardIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return ValueListenableBuilder<int?>(
      valueListenable: expandedCardIndex,
      builder: (context, expandedIndex, child) {
        bool isExpanded = expandedIndex == index;

        return Card(
          elevation: 8,
          margin: const EdgeInsets.symmetric(vertical: 12.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(8.0),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: images.length,
                itemBuilder: (context, index) {
                  return ClipRRect(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                    child: Image.asset(
                      images[index],
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                        color: theme.textTheme.headlineMedium!.color,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    AnimatedCrossFade(
                      duration: const Duration(milliseconds: 300),
                      firstChild: SizedBox.shrink(),
                      secondChild: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: details.map((detail) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Text(
                              detail,
                              style: TextStyle(
                                fontSize: 16.0,
                                color: theme.textTheme.bodyMedium!.color,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      crossFadeState: isExpanded
                          ? CrossFadeState.showSecond
                          : CrossFadeState.showFirst,
                    ),
                    const SizedBox(height: 8.0),
                    Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        icon: Icon(
                          isExpanded ? Icons.expand_less : Icons.expand_more,
                          color: theme.iconTheme.color,
                        ),
                        onPressed: () {
                          if (isExpanded) {
                            expandedCardIndex.value = null;
                          } else {
                            expandedCardIndex.value = index;
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
