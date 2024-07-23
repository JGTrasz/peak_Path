import 'package:flutter/material.dart';

class HikingTipsScreen extends StatefulWidget {
  const HikingTipsScreen({super.key});

  @override
  _HikingTipsScreenState createState() => _HikingTipsScreenState();
}

class _HikingTipsScreenState extends State<HikingTipsScreen> {
  // This notifier will hold the index of the expanded card
  ValueNotifier<int?> expandedCardIndex = ValueNotifier<int?>(null);

  @override
  void dispose() {
    expandedCardIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hiking Tips'),
      ),
      body: ValueListenableBuilder<int?>(
        valueListenable: expandedCardIndex,
        builder: (context, expandedIndex, child) {
          return ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              TipCard(
                image: 'assets/images/water_bottle.jpeg',
                title: 'Start Slow and Stay Hydrated',
                tips: [
                  'Begin at a comfortable pace and drink water regularly.',
                  'Avoid sugary drinks and stick to water or electrolyte solutions.',
                  'Carry a reusable water bottle to stay eco-friendly.',
                ],
                index: 0,
                expandedCardIndex: expandedCardIndex,
              ),
              TipCard(
                image: 'assets/images/route.jpeg',
                title: 'Know Your Route',
                tips: [
                  'Study the trail map and be aware of landmarks.',
                  'Plan your route ahead of time and share it with someone.',
                  'Check for any trail closures or alerts before you go.',
                ],
                index: 1,
                expandedCardIndex: expandedCardIndex,
              ),
              TipCard(
                image: 'assets/images/weather.jpeg',
                title: 'Check Weather Conditions',
                tips: [
                  'Be prepared for changing weather; pack accordingly.',
                  'Wear layers that you can add or remove as needed.',
                  'Check the weather forecast before you head out.',
                ],
                index: 2,
                expandedCardIndex: expandedCardIndex,
              ),
              TipCard(
                image: 'assets/images/first_aid.jpeg',
                title: 'Carry First Aid Kit',
                tips: [
                  'Include essentials like bandages, antiseptic, and medications.',
                  'Familiarize yourself with basic first aid procedures.',
                  'Ensure your first aid kit is easily accessible in your pack.',
                ],
                index: 3,
                expandedCardIndex: expandedCardIndex,
              ),
              TipCard(
                image: 'assets/images/gear.jpeg',
                title: 'Pack Your Gear',
                tips: [
                  'Ensure you have all necessary gear, including navigation tools and extra layers.',
                  'Pack light but carry all essentials such as a map, compass, and flashlight.',
                  'Check your gear before you leave to make sure everything is in working order.',
                ],
                index: 4,
                expandedCardIndex: expandedCardIndex,
              ),
              TipCard(
                image: 'assets/images/shoes.jpeg',
                title: 'Wear Proper Shoes',
                tips: [
                  'Choose sturdy, comfortable hiking shoes that provide good support.',
                  'Break in new shoes before your hike to avoid blisters.',
                  'Wear moisture-wicking socks to keep your feet dry.',
                ],
                index: 5,
                expandedCardIndex: expandedCardIndex,
              ),
            ],
          );
        },
      ),
    );
  }
}

class TipCard extends StatelessWidget {
  final String image;
  final String title;
  final List<String> tips;
  final int index;
  final ValueNotifier<int?> expandedCardIndex;

  const TipCard({
    Key? key,
    required this.image,
    required this.title,
    required this.tips,
    required this.index,
    required this.expandedCardIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int?>(
      valueListenable: expandedCardIndex,
      builder: (context, expandedIndex, child) {
        bool _isExpanded = expandedIndex == index;

        return Card(
          elevation: 4,
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: AnimatedCrossFade(
            duration: const Duration(milliseconds: 300),
            firstChild: ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: SizedBox(
                  width: 70.0,
                  height: 70.0,
                  child: Image.asset(image, fit: BoxFit.cover),
                ),
              ),
              title: Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
              onTap: () {
                if (_isExpanded) {
                  expandedCardIndex.value = null;
                } else {
                  expandedCardIndex.value = index;
                }
              },
            ),
            secondChild: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.asset(image),
                  ),
                  ...tips.map((tip) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Text(
                          tip,
                          style: const TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                      )),
                ],
              ),
            ),
            crossFadeState: _isExpanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
          ),
        );
      },
    );
  }
}
