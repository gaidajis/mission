// lib/home_screen.dart
import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'send_on_mission_screen.dart';
import 'choose_mission_screen.dart';
import 'contact_screen.dart';
import 'how_it_works_screen.dart';
import 'profile_screen.dart'; // Assuming you have this file

import 'package:video_player/video_player.dart'; // Import video_player
import 'package:chewie/chewie.dart'; // Import chewie

class MainAppScreen extends StatefulWidget {
  const MainAppScreen({super.key});

  @override
  MainAppScreenState createState() => MainAppScreenState();
}

class MainAppScreenState extends State<MainAppScreen> {
  int _selectedIndex = 0;
  late List<Widget> _widgetOptions;

  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    _widgetOptions = <Widget>[
      _buildHomeScreen(),
      const HowItWorksScreen(),
      const SendOnMissionScreen(),
      const ChooseMissionScreen(),
      const ContactScreen(),
      const ProfileScreen(), // Profile is now in the drawer
    ];

    _videoPlayerController = VideoPlayerController.asset(
      'assets/images/invideo-ai-720 How The Mission App Connects You Globall 2025-04-06.mp4',
    );

    _initializeVideoPlayer();
  }

  Future<void> _initializeVideoPlayer() async {
    await _videoPlayerController.initialize();
    setState(() {
      _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController,
        autoPlay: false,
        looping: false,
        // Add more configuration options as needed
      );
    });
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  Widget _buildHomeScreen() {
    final String missionSummary =
        "The Mission: Connecting global needs with local action. Request assistance for anything, anywhere, and tap into a global network ready to help online and offline. From virtual tasks to real-world support, we're breaking down geographical barriers to make your requests a reality.";

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.black87, Colors.black],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Image.asset(
                        'assets/images/Gemini_Generated_Image_ehb5lnehb5lnehb5.jpeg',
                        height: 150,
                        width: 150,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Welcome!',
                      style: GoogleFonts.genos(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'The Mission',
                      style: GoogleFonts.genos(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.amber,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      missionSummary,
                      style: GoogleFonts.roboto(
                        fontSize: 14,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: _chewieController != null
                    ? Chewie(controller: _chewieController!)
                    : const CircularProgressIndicator(),
              ),
            ],
          ),
        ),
      ),
     );
    }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Set the background color of the Scaffold to black
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
            const DrawerHeader( // Removed the Image.asset here
              padding: EdgeInsets.only(left: 16.0, bottom: 16.0, top: 40.0),
              decoration: BoxDecoration(
                color: Color.fromARGB(133, 0, 0, 0),
              ),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: SizedBox(height: 60, width: 60), // Placeholder for the removed image
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
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
    );
  }
}