import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
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
  runApp(MyApp());
}

// MyApp widget: Represents the root of the application
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Disable the debug banner
      title: 'The Mission', // Set the application title
      home: const HomeScreen(), // Set MyHomePage as the home screen
    );
  }
}

// MyHomePage widget: Represents the main screen of the application
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

/*
_MyHomePageState: This class manages the state of the MyHomePage widget.
It includes:
- _selectedIndex: An integer to keep track of the currently selected drawer item.
- _widgetOptions: A list of widgets corresponding to different screens of the application.
*/
class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    HowItWorksScreen(),
    SendOnMissionScreen(),
    ChooseMissionScreen(),
    LoginScreen(),
    ContactScreen(), // Corrected typo here
  ];

  void _onDrawerItemTapped(int index) {
    if (_selectedIndex == index)
      return; // If the tapped item is already selected, do nothing

    setState(() {
      _selectedIndex = index; // Update the selected index
    });
    Navigator.pop(context); // Close the drawer
  }

  //Build method to create the UI for the main screen
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Add some spacing
            const SizedBox(width: 9),
            const SizedBox(width: 9),
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
          size: 30, // Size of the navigation icon
        ),
      ),
      drawer: Drawer(
        // Drawer for navigation
        backgroundColor: const Color.fromARGB(221, 0, 0, 0),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            //DrawerHeader displays the app logo and name
            DrawerHeader(
              padding: const EdgeInsets.only(
                left: 16.0,
                bottom: 16.0,
                top: 40.0,
              ),
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
            //ListTile for Home
            ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 4,
              ),
              leading: Icon(
                Icons.home,
                color: _selectedIndex == 0 ? Colors.blueGrey[300] : Colors.grey,
              ),
              title: Text(
                'Home',
                style: TextStyle(
                  color:
                      _selectedIndex == 0 ? Colors.blueGrey[300] : Colors.grey,
                ),
              ),
              selected: _selectedIndex == 0,
              selectedTileColor: Colors.black54,
              onTap: () => _onDrawerItemTapped(0),
            ),
            //Divider to separate drawer items
            const Divider(indent: 16.0, endIndent: 16.0, color: Colors.grey),
            // ListTile for How it works
            ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 4,
              ),
              leading: Icon(
                Icons.info_outline,
                color: _selectedIndex == 1 ? Colors.blueGrey[300] : Colors.grey,
              ),
              title: Text(
                'How it works',
                style: TextStyle(
                  color:
                      _selectedIndex == 1 ? Colors.blueGrey[300] : Colors.grey,
                ),
              ),
              selectedTileColor: Colors.black54,
              selected: _selectedIndex == 1,
              onTap: () => _onDrawerItemTapped(1),
            ),
            //Divider to separate drawer items
            const Divider(indent: 16.0, endIndent: 16.0, color: Colors.grey),
            //ListTile for Send on Mission
            ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 4,
              ),
              leading: Icon(
                Icons.send,
                color: _selectedIndex == 2 ? Colors.blueGrey[300] : Colors.grey,
              ),
              title: Text(
                'Send on Mission',
                style: TextStyle(
                  color:
                      _selectedIndex == 2 ? Colors.blueGrey[300] : Colors.grey,
                ),
              ),
              selectedTileColor: Colors.black54,
              selected: _selectedIndex == 2,
              onTap: () => _onDrawerItemTapped(2),
            ),
            //Divider to separate drawer items
            const Divider(indent: 16.0, endIndent: 16.0, color: Colors.grey),
            //ListTile for Choose your mission
            ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 4,
              ),
              leading: Icon(
                Icons.search,
                color: _selectedIndex == 3 ? Colors.blueGrey[300] : Colors.grey,
              ),
              title: Text(
                'Choose your mission',
                style: TextStyle(
                  color:
                      _selectedIndex == 3 ? Colors.blueGrey[300] : Colors.grey,
                ),
              ),
              selectedTileColor: Colors.black54,
              selected: _selectedIndex == 3,
              onTap: () => _onDrawerItemTapped(3),
            ),
            //Divider to separate drawer items
            const Divider(indent: 16.0, endIndent: 16.0, color: Colors.grey),
            //ListTile for Contact
            ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 4,
              ),
              leading: Icon(
                Icons.phone,
                color: _selectedIndex == 4 ? Colors.blueGrey[300] : Colors.grey,
              ),
              title: Text(
                'Contact',
                style: TextStyle(
                  color:
                      _selectedIndex == 4 ? Colors.blueGrey[300] : Colors.grey,
                ),
              ),
              selectedTileColor: Colors.black54,
              selected: _selectedIndex == 4,
              onTap: () => _onDrawerItemTapped(4),
            ),
            //Divider to separate drawer items
            const Divider(indent: 16.0, endIndent: 16.0, color: Colors.grey),
            //ListTile for Login
            ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 4,
              ),
              leading: Icon(
                Icons.account_circle,
                color: _selectedIndex == 5 ? Colors.blueGrey[300] : Colors.grey,
              ),
              title: Text(
                'Login',
                style: TextStyle(
                  color:
                      _selectedIndex == 5 ? Colors.blueGrey[300] : Colors.grey,
                ),
              ),
              selectedTileColor: Colors.black54,
              selected: _selectedIndex == 5,
              onTap: () => _onDrawerItemTapped(5),
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
        ), // Centers the selected widget
        child: Center(child: _widgetOptions.elementAt(_selectedIndex)),
      ),
    );
  }
}
