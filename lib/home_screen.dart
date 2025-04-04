// lib/home_screen.dart
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_screen.dart';
import 'profile_screen.dart';
import 'send_on_mission_screen.dart';
import 'mission_details_screen.dart';
import 'choose_mission_screen.dart';
import 'contact_screen.dart';
import 'how_it_works_screen.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final User? user = snapshot.data;
          if (user == null) {
            // User is not logged in, navigate to the login screen
            return const LoginScreen();
          } else {
            // User is logged in, navigate to the home screen
            return const MainAppScreen(); // Replace with your actual home screen
          }
        }

        // While checking the authentication state, you might want to show a loading indicator
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}

class MainAppScreen extends StatefulWidget {
  const MainAppScreen({super.key});

  @override
  MainAppScreenState createState() => MainAppScreenState();
}

class MainAppScreenState extends State<MainAppScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _screens = [
    ProfileScreen(), // Removed const
    SendOnMissionScreen(), // Removed const
    MissionDetailsScreen(category: 'dummy'), // Removed const and added required parameter
    ChooseMissionScreen(), // Removed const
    ContactScreen(), // Removed const
    HowItWorksScreen() // Removed const
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mission App'),
        backgroundColor: const Color(0xFF607D8B), // Custom app bar color
      ),
      body: Center(
        child: _screens.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.person), // Profile icon
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.send),
            label: 'Send on Mission',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: 'Mission Details',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.rocket_launch),
            label: 'Choose Mission',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mail),
            label: 'Contact',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.help_outline),
            label: 'How it works',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFF607D8B), // Custom selected color
        unselectedItemColor: Colors.grey[600],
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}