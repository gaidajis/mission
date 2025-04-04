// lib/home_screen.dart
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'login_screen.dart';
import 'send_on_mission_screen.dart';
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

/*
MainAppScreen: This widget represents the main screen after potentially logging in,
containing the Scaffold, AppBar, Drawer, and main content area.
*/
class MainAppScreen extends StatefulWidget {
  const MainAppScreen({super.key});

  @override
  MainAppScreenState createState() => MainAppScreenState();
}

/*
MainAppScreenState: Manages the state for MainAppScreen.
It includes:
- _selectedIndex: Tracks the currently selected drawer item index.
- _widgetOptions: A list of Widgets corresponding to each screen accessible from the drawer.
*/
class MainAppScreenState extends State<MainAppScreen> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    // Replace this with the actual content of your "Home" screen
    Center(
      child: Text(
        'Home Screen Content',
        style: TextStyle(fontSize: 24),
      ),
    ),
    const HowItWorksScreen(),
    const SendOnMissionScreen(),
    const ChooseMissionScreen(),
    const ContactScreen(),
    const LoginScreen(), // Consider if Login should be here for logged-in users
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
                    Image.asset('assets/images/m7.jpeg', height: 30, width: 30),
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
                  color: _selectedIndex == 0 ? Colors.blueGrey[300] : Colors.grey,
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
                  color: _selectedIndex == 1 ? Colors.blueGrey[300] : Colors.grey,
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
                  color: _selectedIndex == 2 ? Colors.blueGrey[300] : Colors.grey,
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
                  color: _selectedIndex == 3 ? Colors.blueGrey[300] : Colors.grey,
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
                  color: _selectedIndex == 4 ? Colors.blueGrey[300] : Colors.grey,
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
                'Login',
                style: TextStyle(
                  color: _selectedIndex == 5 ? Colors.blueGrey[300] : Colors.grey,
                ),
              ),
              selected: _selectedIndex == 5,
              selectedTileColor: Colors.black54,
              onTap: () => _onItemTapped(5),
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