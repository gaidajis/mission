// lib/home_screen.dart
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'send_on_mission_screen.dart';
import 'choose_mission_screen.dart';
import 'contact_screen.dart';
import 'how_it_works_screen.dart';
import 'profile_screen.dart'; // Assuming you have this file

class MainAppScreen extends StatefulWidget {
  const MainAppScreen({super.key});

  @override
  MainAppScreenState createState() => MainAppScreenState();
}

class MainAppScreenState extends State<MainAppScreen> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    // Replace this with the actual content of your "Home" screen
    const Center(
      child: Text(
        'Your Actual Home Screen Content Here',
        style: TextStyle(fontSize: 24),
      ),
    ),
    const HowItWorksScreen(),
    const SendOnMissionScreen(),
    const ChooseMissionScreen(),
    const ContactScreen(),
    // const LoginScreen(), // Removed LoginScreen from drawer options
    const ProfileScreen(), // Profile is now in the drawer (and potentially AppBar)
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(width: 8),
            Text(
              'The Mission',
              style: GoogleFonts.genos(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
          ],
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.amber,
          size: 30,
        ),
        actions: const <Widget>[],
      ),
      drawer: Drawer(
        backgroundColor: const Color.fromARGB(221, 0, 0, 0),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              padding: const EdgeInsets.only(left: 16.0, bottom: 16.0, top: 40.0),
              decoration: const BoxDecoration(
                color: Color.fromARGB(133, 0, 0, 0),
              ),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Row(
                  children: [
                    //Image.asset('assets/images/m7.jpeg', height: 60, width: 60),
                    const SizedBox(width: 8),
                    Text(
                      'The Mission',
                      style: GoogleFonts.genos(
                        color: Colors.grey,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              leading: const Icon(Icons.home, color: Colors.grey),
              title: Text(
                'Home',
                style: TextStyle(
                  color: _selectedIndex == 0 ? const Color(0xFF819ca9) : Colors.grey,
                ),
              ),
              selected: _selectedIndex == 0,
              selectedTileColor: Colors.black54,
              onTap: () => _onItemTapped(0),
            ),
            const Divider(indent: 16.0, endIndent: 16.0, color: Colors.grey),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              leading: const Icon(Icons.info_outline, color: Colors.grey),
              title: Text(
                'How it works',
                style: TextStyle(
                  color: _selectedIndex == 1 ? const Color(0xFF819ca9) : Colors.grey,
                ),
              ),
              selected: _selectedIndex == 1,
              selectedTileColor: Colors.black54,
              onTap: () => _onItemTapped(1),
            ),
            const Divider(indent: 16.0, endIndent: 16.0, color: Colors.grey),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              leading: const Icon(Icons.send, color: Colors.grey),
              title: Text(
                'Send on Mission',
                style: TextStyle(
                  color: _selectedIndex == 2 ? const Color(0xFF819ca9) : Colors.grey,
                ),
              ),
              selected: _selectedIndex == 2,
              selectedTileColor: Colors.black54,
              onTap: () => _onItemTapped(2),
            ),
            const Divider(indent: 16.0, endIndent: 16.0, color: Colors.grey),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              leading: const Icon(Icons.search, color: Colors.grey),
              title: Text(
                'Choose your mission',
                style: TextStyle(
                  color: _selectedIndex == 3 ? const Color(0xFF819ca9) : Colors.grey,
                ),
              ),
              selected: _selectedIndex == 3,
              selectedTileColor: Colors.black54,
              onTap: () => _onItemTapped(3),
            ),
            const Divider(indent: 16.0, endIndent: 16.0, color: Colors.grey),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              leading: const Icon(Icons.phone, color: Colors.grey),
              title: Text(
                'Contact',
                style: TextStyle(
                  color: _selectedIndex == 4 ? const Color(0xFF819ca9) : Colors.grey,
                ),
              ),
              selected: _selectedIndex == 4,
              selectedTileColor: Colors.black54,
              onTap: () => _onItemTapped(4),
            ),
            const Divider(indent: 16.0, endIndent: 16.0, color: Colors.grey),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              leading: const Icon(Icons.account_circle, color: Colors.grey),
              title: Text(
                'Profile',
                style: TextStyle(
                  color: _selectedIndex == 5 ? const Color(0xFF819ca9) : Colors.grey, // Profile is now at index 5
                ),
              ),
              selected: _selectedIndex == 5, // Profile is now at index 5
              selectedTileColor: Colors.black54,
              onTap: () => _onItemTapped(5), // Profile is now at index 5
            ),
            const Divider(indent: 16.0, endIndent: 16.0, color: Colors.grey),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              leading: const Icon(Icons.logout, color: Colors.grey),
              title: Text(
                'Logout',
                style: TextStyle(
                  color: _selectedIndex == 6 ? const Color(0xFF819ca9) : Colors.grey, // Logout is now at index 6
                ),
              ),
              selected: _selectedIndex == 6, // Logout is now at index 6
              selectedTileColor: Colors.black54,
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                if (context.mounted) {
                  Navigator.pushReplacementNamed(context, '/login');
                }
              },
            ),
          ],
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.black87, Colors.black],
          ),
        ),
        child: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
      ),
    );
  }
}