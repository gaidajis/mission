import 'package:flutter/material.dart';
//import 'package:url_launcher/url_launcher_string.dart';
import 'package:google_fonts/google_fonts.dart'; // Import Google Fonts

import 'home_screen.dart';
import 'how_it_works_screen.dart';
import 'send_on_mission_screen.dart';
import 'choose_mission_screen.dart';
import 'contact_screen.dart';
import 'login_screen.dart';
//import 'profile_screen.dart';
//import 'mission_details_screen.dart';

final Color primaryColor = const Color(0xFF2962FF);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {   final darkGrey = Color(0xFF333333);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'The Mission',
      theme: ThemeData(
        primarySwatch: MaterialColor(0xFF2962FF, <int, Color>{
          50: const Color(0xFFE3F2FD),
          100: const Color(0xFFBBDEFB),
          200: const Color(0xFF90CAF9),
          300: const Color(0xFF64B5F6),
          400: const Color(0xFF42A5F5),
          500: const Color(0xFF2962FF),
          600: const Color(0xFF1E88E5),
          700: const Color(0xFF1976D2),
          800: const Color(0xFF1565C0),
          900: const Color(0xFF0D47A1),
        }),
        useMaterial3: true,
        fontFamily: GoogleFonts.playfairDisplay().fontFamily, // Elegant font
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(seedColor: primaryColor, brightness: Brightness.dark),
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});
  @override
  Widget build(BuildContext context) => const MyHomePage();
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    const HomeScreen(),
    const HowItWorksScreen(),
    const SendOnMissionScreen(),
    const ChooseMissionScreen(),
    const ContactScreen(),
    const LoginScreen(),
  ];

  void _onDrawerItemTapped(int index) {
    if (_selectedIndex == index) return;

    setState(() {
      _selectedIndex = index;
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF222222),
      appBar: AppBar(
        backgroundColor: const Color(0xFF333333),
        title: Text(
          'The Mission',
          style: GoogleFonts.playfairDisplay(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              padding: const EdgeInsets.only(left: 16.0, bottom: 16.0, top: 40.0),
              decoration:  BoxDecoration(color: const Color(0xFF333333)),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  'The Mission',
                  style: GoogleFonts.playfairDisplay(
                    color: Colors.white,  
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              leading: Icon(Icons.home, color: _selectedIndex == 0 ? primaryColor : Colors.grey[600]),
              title: Text('Home', style: TextStyle(color: _selectedIndex == 0 ? primaryColor : Colors.white)),
              selected: _selectedIndex==0,
              selectedTileColor: Colors.grey[800],
              onTap: () => _onDrawerItemTapped(0),
            ),
            const Divider(indent: 16.0, endIndent: 16.0, height: 0),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              leading: Icon(Icons.info_outline, color: _selectedIndex == 1 ? primaryColor : Colors.grey[600]),
              title: Text('How it works', style: TextStyle(color: _selectedIndex == 1 ? primaryColor : Colors.white)),
              selectedTileColor: Colors.grey[800],
              selected: _selectedIndex == 1,
              onTap: () => _onDrawerItemTapped(1),
            ),
            const Divider(indent: 16.0, endIndent: 16.0, height: 0),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              leading: Icon(Icons.send, color: _selectedIndex == 2 ? primaryColor : Colors.grey[600]),
              title: Text('Send on Mission', style: TextStyle(color: _selectedIndex == 2 ? primaryColor : Colors.white)),
              selectedTileColor: Colors.grey[800],
              selected: _selectedIndex == 2,
              onTap: () => _onDrawerItemTapped(2),
            ),
            const Divider(indent: 16.0, endIndent: 16.0, height: 0),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              leading: Icon(Icons.search, color: _selectedIndex == 3 ? primaryColor : Colors.grey[600]),
              title: Text('Choose your mission', style: TextStyle(color: _selectedIndex == 3 ? primaryColor : Colors.white)),
              selectedTileColor: Colors.grey[800],
              selected: _selectedIndex == 3,
              onTap: () => _onDrawerItemTapped(3),
            ),
            const Divider(indent: 16.0, endIndent: 16.0, height: 0),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              leading: Icon(Icons.phone, color: _selectedIndex == 4 ? primaryColor : Colors.grey[600]),
              title: Text('Contact', style: TextStyle(color: _selectedIndex == 4 ? primaryColor : Colors.white)),
              selectedTileColor: Colors.grey[800],
              selected: _selectedIndex == 4,
              onTap: () => _onDrawerItemTapped(4),
            ),
            const Divider(indent: 16.0, endIndent: 16.0, height: 0),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              leading: Icon(Icons.account_circle, color: _selectedIndex == 5 ? primaryColor : Colors.grey[600]),
              title: Text('Login', style: TextStyle(color: _selectedIndex == 5 ? primaryColor : Colors.white)),
              selectedTileColor: Colors.grey[800],
              selected: _selectedIndex == 5,
              onTap: () => _onDrawerItemTapped(5),
            ),
          ],
        ),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
  );
 }
}
