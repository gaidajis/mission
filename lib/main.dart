import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // Import Google Fonts
import 'home_screen.dart';
import 'how_it_works_screen.dart';
import 'send_on_mission_screen.dart';
import 'choose_mission_screen.dart';
import 'contact_screen.dart';
import 'login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'The Mission',
      home: const MyHomePage(), // Directly use MyHomePage as the home screen
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    HowItWorksScreen(),
    SendOnMissionScreen(),
    ChooseMissionScreen(),
    ContactScreen(),
    LoginScreen(),
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
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(width: 8),
            const SizedBox(width: 8),
            Text('The Mission',
                style: GoogleFonts.genos(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 24)),
          ],
        ),
        centerTitle: true,
      ),
      drawer: Drawer(
        backgroundColor: Colors.black87,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              padding: const EdgeInsets.only(left: 16.0, bottom: 16.0, top: 40.0),
              decoration: const BoxDecoration(color: Colors.black54),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/m7.jpeg',
                      height: 30,
                      width: 30,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'The Mission',
                      style: GoogleFonts.genos(color: Colors.grey,
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
              leading: Icon(Icons.home, color: _selectedIndex == 0 ? Colors.blueGrey[300] : Colors.grey),
              title: Text('Home', style: TextStyle(color: _selectedIndex == 0 ? Colors.blueGrey[300] : Colors.grey)),
              selected: _selectedIndex==0,
              selectedTileColor: Colors.black54,
              onTap: () => _onDrawerItemTapped(0),
            ),
            const Divider(indent: 16.0, endIndent: 16.0, color: Colors.grey),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              leading: Icon(Icons.info_outline, color: _selectedIndex == 1 ? Colors.blueGrey[300] : Colors.grey),
              title: Text('How it works', style: TextStyle(color: _selectedIndex == 1 ? Colors.blueGrey[300] : Colors.grey)),
              selectedTileColor: Colors.black54,
              selected: _selectedIndex == 1,
              onTap: () => _onDrawerItemTapped(1),
            ),
            const Divider(indent: 16.0, endIndent: 16.0, color: Colors.grey),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              leading: Icon(Icons.send, color: _selectedIndex == 2 ? Colors.blueGrey[300] : Colors.grey),
              title: Text('Send on Mission', style: TextStyle(color: _selectedIndex == 2 ? Colors.blueGrey[300] : Colors.grey)),
              selectedTileColor: Colors.black54,
              selected: _selectedIndex == 2,
              onTap: () => _onDrawerItemTapped(2),
            ),
            const Divider(indent: 16.0, endIndent: 16.0, color: Colors.grey),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              leading: Icon(Icons.search, color: _selectedIndex == 3 ? Colors.blueGrey[300] : Colors.grey),
              title: Text('Choose your mission', style: TextStyle(color: _selectedIndex == 3 ? Colors.blueGrey[300] : Colors.grey)),
              selectedTileColor: Colors.black54,
              selected: _selectedIndex == 3,
              onTap: () => _onDrawerItemTapped(3),
            ),
            const Divider(indent: 16.0, endIndent: 16.0, color: Colors.grey),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              leading: Icon(Icons.phone, color: _selectedIndex == 4 ? Colors.blueGrey[300] : Colors.grey),
              title: Text('Contact', style: TextStyle(color: _selectedIndex == 4 ? Colors.blueGrey[300] : Colors.grey)),
              selectedTileColor: Colors.black54,
              selected: _selectedIndex == 4,
              onTap: () => _onDrawerItemTapped(4),
            ),
            const Divider(indent: 16.0, endIndent: 16.0, color: Colors.grey),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              leading: Icon(Icons.account_circle, color: _selectedIndex == 5 ? Colors.blueGrey[300] : Colors.grey),
              title: Text('Login', style: TextStyle(color: _selectedIndex == 5 ? Colors.blueGrey[300] : Colors.grey)),
              selectedTileColor: Colors.black54,
              selected: _selectedIndex == 5,
              onTap: () => _onDrawerItemTapped(5),
            ),
          ],
        ),
      ),
      body: Container( // Apply gradient to the body
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