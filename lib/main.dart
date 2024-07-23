import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'splashScreen.dart';
import 'screens/form.dart';
import 'screens/display.dart';
import 'screens/home_screen.dart';
import 'screens/hiking_tips_screen.dart';
import 'screens/gear_list_screen.dart';
import 'screens/saved_hikes_screen.dart';

void main() {
  runApp(PeakPathApp());
}

class PeakPathApp extends StatefulWidget {
  @override
  _PeakPathAppState createState() => _PeakPathAppState();
}

class _PeakPathAppState extends State<PeakPathApp> {
  bool _isDarkMode = false;

  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
      print('Dark Mode: $_isDarkMode'); // Debug print
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PeakPath: Your Personal Mountain Hiking App',
      theme: ThemeData.light().copyWith(
        textTheme: GoogleFonts.dmSansTextTheme(),
        colorScheme: ColorScheme(
          primary: Color(0xFF264653),
          primaryContainer: Color(0xFF264653),
          secondary: Color(0xFF2A9D8F),
          secondaryContainer: Color(0xFF2A9D8F),
          surface: Colors.white,
          background: Color.fromARGB(255, 253, 253, 253),
          error: Colors.red,
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onSurface: Colors.black,
          onBackground: Colors.black,
          onError: Colors.white,
          brightness: Brightness.light,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFFE9C46A),
            foregroundColor: Colors.white,
            textStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        appBarTheme: AppBarTheme(
          color: Color(0xFF264653),
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        tabBarTheme: TabBarTheme(
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Color(0xFF2A9D8F),
          ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Color(0xFF264653),
          selectedItemColor: Color.fromARGB(255, 219, 216, 149),
          unselectedItemColor: Colors.white70,
          selectedIconTheme: IconThemeData(size: 30),
          unselectedIconTheme: IconThemeData(size: 25),
        ),
      ),
      darkTheme: ThemeData.dark().copyWith(
        textTheme: GoogleFonts.dmSansTextTheme(ThemeData.dark().textTheme),
        colorScheme: ColorScheme(
          primary: Color(0xFF7289DA),
          primaryContainer: Color(0xFF7289DA),
          secondary: Color(0xFF99AAB5),
          secondaryContainer: Color(0xFF99AAB5),
          surface: Color(0xFF2C2F33),
          background: Color(0xFF23272A),
          error: Colors.red,
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onSurface: Colors.white,
          onBackground: Colors.white,
          onError: Colors.white,
          brightness: Brightness.dark,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF7289DA),
            foregroundColor: Colors.white,
            textStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        appBarTheme: AppBarTheme(
          color: Color(0xFF2C2F33),
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        tabBarTheme: TabBarTheme(
          labelColor: Colors.white,
          unselectedLabelColor: Color(0xFF99AAB5),
          indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Color(0xFF7289DA),
          ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Color(0xFF2C2F33),
          selectedItemColor: Color(0xFF7289DA),
          unselectedItemColor: Color(0xFF99AAB5),
          selectedIconTheme: IconThemeData(size: 30),
          unselectedIconTheme: IconThemeData(size: 25),
        ),
      ),
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: Splashscreen(toggleTheme: _toggleTheme),
    );
  }
}

class HomePage extends StatefulWidget {
  final Function toggleTheme;
  final String name;
  final String age;
  final String contactNumber;
  final String emergencyNumber;

  HomePage({
    required this.toggleTheme,
    required this.name,
    required this.age,
    required this.contactNumber,
    required this.emergencyNumber,
  });

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  late List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = <Widget>[
      HomeMountainScreen(),
      HikingTipsScreen(),
      MountainListScreen(),
      HikingActivitiesScreen(),
      DisplayScreen(
        name: widget.name,
        age: widget.age,
        contactNumber: widget.contactNumber,
        emergencyNumber: widget.emergencyNumber,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    var bottomNavigationBar = BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.directions_walk),
          label: 'Safety Tips',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.landscape),
          label: 'Mountains',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.hiking),
          label: 'Activities',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Personal Info',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: const Color(0xFF7289DA),
      onTap: (index) {
        setState(() {
          _selectedIndex = index;
        });
      },
      type: BottomNavigationBarType.fixed,
      backgroundColor:
          Theme.of(context).bottomNavigationBarTheme.backgroundColor,
      unselectedItemColor: Color(0xFF99AAB5),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('PeakPath'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.brightness_6),
            onPressed: () {
              widget.toggleTheme();
            },
          ),
        ],
      ),
      body: _screens[_selectedIndex], // Access the selected screen
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
