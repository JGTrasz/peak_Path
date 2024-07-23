import 'package:flutter/material.dart';
import 'dart:async';
import 'package:weather/weather.dart';
import 'package:intl/intl.dart';

const OPENWEATHER_API_KEY = '5515465843e35312f977256f82472568';

void main() {
  runApp(MaterialApp(
    home: const MountainListScreen(),
    theme: ThemeData.dark().copyWith(
      scaffoldBackgroundColor: const Color(0xFF36393F),
      cardColor: const Color(0xFF2C2F33),
      primaryColor: const Color(0xFF7289DA),
      textTheme: const TextTheme(),
    ),
  ));
}

class MountainListScreen extends StatelessWidget {
  const MountainListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mountains of the Philippines'),
      ),
      body: ListView(
        children: const [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: MountainItemCard(
              mountainName: 'Mount Pulag',
              mountainDescription:
                  'The third highest mountain in the Philippines, known for its sea of clouds.',
              mountainImages: [
                'assets/images/pulag.jpeg',
                'assets/images/pulag2.jpeg'
              ],
              cityName: 'Baguio',
              difficultyLevel: 'Moderate',
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: MountainItemCard(
              mountainName: 'Mount Apo',
              mountainDescription:
                  'The highest mountain in the Philippines, offering challenging trails and breathtaking views.',
              mountainImages: [
                'assets/images/mount_apo.jpeg',
                'assets/images/mount_apo2.jpeg'
              ],
              cityName: 'Davao',
              difficultyLevel: 'Hard',
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: MountainItemCard(
              mountainName: 'Mount Mayon',
              mountainDescription:
                  'An active stratovolcano known for its perfect cone shape.',
              mountainImages: [
                'assets/images/mount_mayon.jpeg',
                'assets/images/mount_mayon2.jpeg'
              ],
              cityName: 'Legazpi',
              difficultyLevel: 'Moderate',
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: MountainItemCard(
              mountainName: 'Mount Pinatubo',
              mountainDescription:
                  'Famous for its crater lake formed after the 1991 eruption.',
              mountainImages: [
                'assets/images/mount_pinatubo.jpeg',
                'assets/images/mount_pinatubo2.jpeg'
              ],
              cityName: 'Capas',
              difficultyLevel: 'Easy',
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: MountainItemCard(
              mountainName: 'Mount Kanlaon',
              mountainDescription:
                  'An active stratovolcano on the island of Negros, known for its challenging hikes and stunning vistas.',
              mountainImages: [
                'assets/images/mount_kanlaon.jpeg',
                'assets/images/mount_kanlaon2.jpeg'
              ],
              cityName: 'Negros, Philippines',
              difficultyLevel: 'Hard',
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: MountainItemCard(
              mountainName: 'Mount Guiting-Guiting',
              mountainDescription:
                  'A mountain on Sibuyan Island, known for its jagged peaks and rich biodiversity.',
              mountainImages: [
                'assets/images/mount_guiting.jpeg',
                'assets/images/mount_guiting2.jpeg'
              ],
              cityName: 'Romblon, Philippines',
              difficultyLevel: 'Hard',
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: MountainItemCard(
              mountainName: 'Mount Halcon',
              mountainDescription:
                  'One of the toughest climbs in the Philippines, offering dense forests and diverse wildlife.',
              mountainImages: [
                'assets/images/mount_halcon.jpeg',
                'assets/images/mount_halcon2.jpeg'
              ],
              cityName: 'Mindoro',
              difficultyLevel: 'Very Hard',
            ),
          ),
        ],
      ),
    );
  }
}

class MountainItemCard extends StatefulWidget {
  final String mountainName;
  final String mountainDescription;
  final List<String> mountainImages;
  final String cityName;
  final String difficultyLevel;

  const MountainItemCard({
    super.key,
    required this.mountainName,
    required this.mountainDescription,
    required this.mountainImages,
    required this.cityName,
    required this.difficultyLevel,
  });

  @override
  _MountainItemCardState createState() => _MountainItemCardState();
}

class _MountainItemCardState extends State<MountainItemCard> {
  late PageController _pageController;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_pageController.hasClients) {
        if (_pageController.page == widget.mountainImages.length - 1) {
          _pageController.animateToPage(0,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeIn);
        } else {
          _pageController.nextPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeIn);
        }
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  IconData _getDifficultyIcon(String difficultyLevel) {
    switch (difficultyLevel) {
      case 'Easy':
        return Icons.directions_walk;
      case 'Moderate':
        return Icons.hiking;
      case 'Hard':
        return Icons.landscape;
      case 'Very Hard':
        return Icons.terrain;
      default:
        return Icons.help;
    }
  }

  Future<void> _navigateToDetailScreen(BuildContext context) async {
    WeatherFactory wf = WeatherFactory(OPENWEATHER_API_KEY);
    List<Weather> weatherForecast =
        await wf.fiveDayForecastByCityName(widget.cityName);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MountainDetailScreen(
          mountainName: widget.mountainName,
          mountainImages: widget.mountainImages,
          equipment:
              'Standard hiking gear, water, food, and camping equipment if staying overnight.',
          tracks:
              'Multiple tracks available ranging from beginner to expert levels.',
          weather: weatherForecast,
          height:
              '2,922 m', // Example height, this should be dynamically fetched
          description: widget.mountainDescription,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _navigateToDetailScreen(context),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        color: Theme.of(context).cardColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(15)),
              child: SizedBox(
                height: 200,
                width: double.infinity,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: widget.mountainImages.length,
                  itemBuilder: (context, index) {
                    return Image.asset(
                      widget.mountainImages[index],
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.mountainName,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.mountainDescription,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        _getDifficultyIcon(widget.difficultyLevel),
                        size: 24,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        widget.difficultyLevel,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
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
  final List<Weather> weather;
  final String height;
  final String description;

  const MountainDetailScreen({
    super.key,
    required this.mountainName,
    required this.mountainImages,
    required this.equipment,
    required this.tracks,
    required this.weather,
    required this.height,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    // Only keep one weather entry per day
    final uniqueWeather = weather.where((w) {
      final date = DateFormat('yyyy-MM-dd').format(w.date!);
      return weather.indexWhere((element) =>
              DateFormat('yyyy-MM-dd').format(element.date!) == date) ==
          weather.indexOf(w);
    }).toList();

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
                        Icon(Icons.cloud, size: 24),
                        SizedBox(width: 8),
                        Text(
                          'Weather Forecast',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 140, // Increased height to avoid overflow
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: uniqueWeather.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(width: 16),
                        itemBuilder: (context, index) {
                          var dayWeather = uniqueWeather[index];
                          return Container(
                            width: 120, // Increased width for better layout
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  DateFormat('EEE').format(dayWeather.date!),
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${dayWeather.temperature!.celsius!.toStringAsFixed(1)}° C',
                                  style: const TextStyle(fontSize: 16),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  dayWeather.weatherDescription!,
                                  style: const TextStyle(
                                      fontSize:
                                          14), // Reduced font size for better fit
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
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
