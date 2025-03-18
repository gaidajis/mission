import 'package:flutter/material.dart';

final Color primaryColor = const Color(0xFF2962FF);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'The Mission App',
      theme: ThemeData(
        primarySwatch: MaterialColor(primaryColor.value, const <int, Color>{
          50: Color(0xFFE3F2FD), 100: Color(0xFFBBDEFB), 200: Color(0xFF90CAF9), 300: Color(0xFF64B5F6), 400: Color(0xFF42A5F5), 500: Color(0xFF2962FF), 600: Color(0xFF1E88E5), 700: Color(0xFF1976D2), 800: Color(0xFF1565C0), 900: Color(0xFF0D47A1),
        }),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      home: const MyHomePage(),
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

  static final List<Widget> _widgetOptions = <Widget>[
    const HomeScreen(),
    const HowItWorksScreen(),
    const SendOnMissionScreen(),
    const ChooseMissionScreen(),
    const ContactScreen(),
    const LoginScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.pop(context); // Close the drawer
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5), // Light background for modern look
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text('The Mission', style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(left: 16.0, bottom: 16.0, top: 40.0), // Adjusted header padding
              decoration: BoxDecoration(
                color: primaryColor,
              ),
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'The Mission',
                  style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold), // More prominent title
                ),
              ),
            ),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              leading: Icon(Icons.home, color: _selectedIndex == 0 ? primaryColor : Colors.grey[600]),
              title: Text('Home', style: TextStyle(color: _selectedIndex == 0 ? primaryColor : Colors.black87)),
              selected: _selectedIndex == 0,
              onTap: () => _onItemTapped(0),
            ),
            const Divider(indent: 16.0, endIndent: 16.0),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              leading: Icon(Icons.info_outline, color: _selectedIndex == 1 ? primaryColor : Colors.grey[600]),
              title: Text('How does it work', style: TextStyle(color: _selectedIndex == 1 ? primaryColor : Colors.black87)),
              selected: _selectedIndex == 1,
              onTap: () => _onItemTapped(1),
            ),
            const Divider(indent: 16.0, endIndent: 16.0),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              leading: Icon(Icons.send, color: _selectedIndex == 2 ? primaryColor : Colors.grey[600]),
              title: Text('Send on Mission', style: TextStyle(color: _selectedIndex == 2 ? primaryColor : Colors.black87)),
              selected: _selectedIndex == 2,
              onTap: () => _onItemTapped(2),
            ),
            const Divider(indent: 16.0, endIndent: 16.0),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              leading: Icon(Icons.search, color: _selectedIndex == 3 ? primaryColor : Colors.grey[600]),
              title: Text('Choose your mission', style: TextStyle(color: _selectedIndex == 3 ? primaryColor : Colors.black87)),
              selected: _selectedIndex == 3,
              onTap: () => _onItemTapped(3),
            ),
            const Divider(indent: 16.0, endIndent: 16.0),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              leading: Icon(Icons.phone, color: _selectedIndex == 4 ? primaryColor : Colors.grey[600]),
              title: Text('Contact', style: TextStyle(color: _selectedIndex == 4 ? primaryColor : Colors.black87)),
              selected: _selectedIndex == 4,
              onTap: () => _onItemTapped(4),
            ),
            const Divider(indent: 16.0, endIndent: 16.0),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              leading: Icon(Icons.account_circle, color: _selectedIndex == 5 ? primaryColor : Colors.grey[600]),
              title: Text('Login', style: TextStyle(color: _selectedIndex == 5 ? primaryColor : Colors.black87)),
              selected: _selectedIndex == 5,
              onTap: () => _onItemTapped(5),
            ),
          ],
        ),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: primaryColor,
        unselectedItemColor: Colors.grey[600],
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info_outline),
            label: 'How it works',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Login',
          ),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              children: [
                Text(
                  'About The Mission',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Qu’est-ce qu’est The Mission ?",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Une plateforme qui permet de donner des mandats en quelques minutes. Elle permet de mettre en contact des gens du monde entier. Elle donne du travail aux personnes rapidement. Il ne faut pas passer par un processus long est compliqué pour donner ou accepter un mandat. Toutes les personnes sur la plateforme sont vérifiées. Une meilleure garantie pour les usagers que les sites d’annonces.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 15),
                const Text(
                  "English:",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  "What is The Mission? It's a platform that allows you to give tasks in minutes. It connects people from all over the world. It provides work for people quickly. You don't need to go through a long and complicated process to give or accept a task. All people on the platform are verified. It's a better guarantee for users than classified ads websites.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HowItWorksScreen extends StatelessWidget {
  const HowItWorksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('How It Works', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: primaryColor)),
          const SizedBox(height: 16),
          const Text('This section will explain how the platform works. You can add details about the process of giving and accepting missions here.', style: TextStyle(fontSize: 16)),
          // Add more detailed steps or information here
        ],
      ),
    );
  }
}

class SendOnMissionScreen extends StatelessWidget {
  const SendOnMissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Send on Mission', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: primaryColor)),
          const SizedBox(height: 16),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              childAspectRatio: 2 / 1,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              children: <String>[
                'Errands',
                'Transportation/Delivery',
                'Food',
                'Social Interactions',
                'Animals',
                'Special Missions',
                'Repairs',
              ].map((category) {
                return Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  child: InkWell(
                    onTap: () {
                      print('$category tapped');
                      // Navigate to a screen for creating a mission in this category
                    },
                    child: Center(
                      child: Text(
                        category,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class ChooseMissionScreen extends StatelessWidget {
  const ChooseMissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Choose Your Mission', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: primaryColor)),
          const SizedBox(height: 16),
          const Text('This section will allow users to browse and choose available missions.', style: TextStyle(fontSize: 16)),
          // Implement mission listing here (e.g., using ListView.builder)
        ],
      ),
    );
  }
}

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Contact Us', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: primaryColor)),
          const SizedBox(height: 16),
          const Text('You can reach us at:', style: TextStyle(fontSize: 16)),
          const SizedBox(height: 8),
          const Text('Email: contact@themissionapp.com', style: TextStyle(fontSize: 16)),
          const SizedBox(height: 8),
          const Text('Phone: +1 555-123-4567', style: TextStyle(fontSize: 16)),
          // Add a contact form or other contact methods here
        ],
      ),
    );
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(24.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              children: <Widget>[
                Text('Login', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: primaryColor)),
                const SizedBox(height: 20),
                const TextField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                const TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: () {
                    // Implement login logic
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ProfileScreen()), // Navigate to profile after login
                    );
                  },
                  child: const Text('Login', style: TextStyle(fontSize: 18)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile', style: TextStyle(color: Colors.white)),
        backgroundColor: primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('My Profile', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: primaryColor)),
            const SizedBox(height: 16),
            const Text('Name: John Doe', style: TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            const Text('Email: john.doe@example.com', style: TextStyle(fontSize: 16)),
            const SizedBox(height: 24),
            Text('My Missions', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: primaryColor)),
            const SizedBox(height: 12),
            const Text('Given: 10', style: TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            const Text('Taken: 5', style: TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            const Text('Total: 15', style: TextStyle(fontSize: 16)),
            const SizedBox(height: 24),
            Text('Total Earnings', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: primaryColor)),
            const SizedBox(height: 12),
            const Text('\$500.00', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 24),
            Text('My Calendar', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: primaryColor)),
            const SizedBox(height: 12),
            const Text('Calendar functionality can be implemented here.', style: TextStyle(fontSize: 16)),
            // Consider using a calendar widget here
          ],
        ),
      ),
    );
  }
}

class MissionDetailsScreen extends StatelessWidget {
  final String category;

  const MissionDetailsScreen({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New $category Mission', style: const TextStyle(color: Colors.white)),
        backgroundColor: primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Create a new $category mission', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: primaryColor)),
            const SizedBox(height: 16),
            const TextField(decoration: InputDecoration(labelText: 'Price')),
            const SizedBox(height: 8),
            const TextField(decoration: InputDecoration(labelText: 'Description')),
            const SizedBox(height: 8),
            const TextField(decoration: InputDecoration(labelText: 'Location')),
            const SizedBox(height: 8),
            const TextField(decoration: InputDecoration(labelText: 'Due Date')),
            const SizedBox(height: 8),
            const TextField(decoration: InputDecoration(labelText: 'Criteria')),
            const SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: () {
                // Implement logic to send the mission
                Navigator.pop(context); // Go back after sending
              },
              child: const Text('Send Mission', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}
