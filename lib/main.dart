import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; // Make sure this file exists and is configured
import 'package:google_fonts/google_fonts.dart';
import 'auth_wrapper.dart';
import 'home_screen.dart';
import 'how_it_works_screen.dart';
import 'send_on_mission_screen.dart';
import 'choose_mission_screen.dart';
import 'contact_screen.dart';
import 'login_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

// MyApp widget: Represents the root of the application
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Disable the debug banner
      title: 'The Mission', // Set the application title
      home: const AuthWrapper(), // Set AuthWrapper as the home screen
      // Consider adding routes here if you navigate to MainAppScreen from AuthWrapper
      // routes: {
      //   '/main': (context) => const MainAppScreen(),
      // },
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
  int _selectedIndex = 0; // Default to the first item (HomeScreen)

  // List of widgets to display based on drawer selection
  static final List<Widget> _widgetOptions = <Widget>[
    const HomeScreen(),         // Index 0
    const HowItWorksScreen(),   // Index 1
    const SendOnMissionScreen(),// Index 2
    const ChooseMissionScreen(),// Index 3
    const ContactScreen(),      // Index 4
    const LoginScreen(),        // Index 5 - Note: Often login is handled before this screen
  ];

  // Method called when a drawer item is tapped
  void _onItemTapped(int index) {
    // Optional: Prevent navigating to the same screen again
    // if (_selectedIndex == index) {
    //   Navigator.pop(context); // Close the drawer even if it's the same index
    //   return;
    // }

    setState(() {
      _selectedIndex = index; // Update the state with the new index
    });
    Navigator.pop(context); // Close the drawer after selection
  }

  // Build method to create the UI for the main screen
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Row(
          mainAxisSize: MainAxisSize.min, // Keep Row tight around children
          children: [
            // Consider adding an icon here if desired, e.g., Image.asset('assets/images/m7.jpeg', height: 30)
            const SizedBox(width: 8), // Adjust spacing as needed
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
          color: Colors.amber, // Drawer icon color
          size: 30,           // Size of the drawer icon
        ),
      ),
      drawer: Drawer(
        backgroundColor: const Color.fromARGB(221, 0, 0, 0),
        child: ListView(
          padding: EdgeInsets.zero, // Remove default padding from ListView
          children: [
            // DrawerHeader displays the app logo and name
            DrawerHeader(
              padding: const EdgeInsets.only(
                left: 16.0,
                bottom: 16.0,
                top: 40.0, // Adjust top padding if needed below status bar
              ),
              decoration: const BoxDecoration(
                color: Color.fromARGB(133, 0, 0, 0), // Semi-transparent black
              ),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Row(
                  children: [
                    // Ensure the asset path is correct and included in pubspec.yaml
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
            // ListTile for Home
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
              selectedTileColor: Colors.black54, // Background color when selected
              onTap: () => _onItemTapped(0),
            ),
            const Divider(indent: 16.0, endIndent: 16.0, color: Colors.grey),
            // ListTile for How it works
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
            // ListTile for Send on Mission
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
            // ListTile for Choose your mission
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
            // ListTile for Contact
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
              // *** FIXED: Changed index from 5 to 4 ***
              onTap: () => _onItemTapped(4),
            ),
            const Divider(indent: 16.0, endIndent: 16.0, color: Colors.grey),
            // ListTile for Login
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
              // *** FIXED: Changed index from 4 to 5 ***
              onTap: () => _onItemTapped(5),
            ),
          ],
        ),
      ),
      body: Container(
        // Apply background gradient to the body
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.black87, Colors.black], // Gradient from dark grey to black
          ),
        ),
        // Display the widget selected via the drawer
        child: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
      ),
    );
  }
}