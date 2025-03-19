import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

// Define the primary color globally for consistent theming
final Color primaryColor = const Color(0xFF2962FF);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Conditional Firebase initialization for IDX previews
  const isPreview = bool.fromEnvironment('preview');
  if (!isPreview) {
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Hide debug banner
      title: 'The Mission App',
      theme: ThemeData(
        primarySwatch: const MaterialColor(0xFF2962FF, <int, Color>{
          50: Color(0xFFE3F2FD), 100: Color(0xFFBBDEFB), 200: Color(0xFF90CAF9), 
          300: Color(0xFF64B5F6), 400: Color(0xFF42A5F5), 500: Color(0xFF2962FF), 
          600: Color(0xFF1E88E5), 700: Color(0xFF1976D2), 800: Color(0xFF1565C0), 
          900: Color(0xFF0D47A1),
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5), // Light background for modern look
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Center(
          child: Image.asset(
            'assets/images/logo.png',
            width: 50,
            errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
              return const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 50,
              );
            },
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(left: 16.0, bottom: 16.0, top: 40.0),
              decoration: BoxDecoration(color: primaryColor),
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'The Mission APP',
                  style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              leading: Icon(Icons.home_outlined, color: _selectedIndex == 0 ? primaryColor : Colors.grey[600]),
              title: Text('Home', style: TextStyle(color: _selectedIndex == 0 ? primaryColor : Colors.black87)),
              selected: _selectedIndex == 0,
              selectedTileColor: Colors.grey[200],
              onTap: () => _onItemTapped(0),
            ),
            const Divider(indent: 16.0, endIndent: 16.0),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              leading: Icon(Icons.info, color: _selectedIndex == 1 ? primaryColor : Colors.grey[600]),
              title: Text('How does it work', style: TextStyle(color: _selectedIndex == 1 ? primaryColor : Colors.black87)),
              selected: _selectedIndex == 1,
              onTap: () => _onItemTapped(1),
            ),
            const Divider(indent: 16.0, endIndent: 16.0),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              leading: Icon(Icons.send_outlined, color: _selectedIndex == 2 ? primaryColor : Colors.grey[600]),
              title: Text('Send on Mission', style: TextStyle(color: _selectedIndex == 2 ? primaryColor : Colors.black87)),
              selected: _selectedIndex == 2,
              onTap: () => _onItemTapped(2),
            ),
            const Divider(indent: 16.0, endIndent: 16.0),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              leading: Icon(Icons.search_outlined, color: _selectedIndex == 3 ? primaryColor : Colors.grey[600]),
              title: Text('Choose your mission', style: TextStyle(color: _selectedIndex == 3 ? primaryColor : Colors.black87)),
              selected: _selectedIndex == 3,
              onTap: () => _onItemTapped(3),
            ),
            const Divider(indent: 16.0, endIndent: 16.0),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              leading: Icon(Icons.phone_outlined, color: _selectedIndex == 4 ? primaryColor : Colors.grey[600]),
              title: Text('Contact', style: TextStyle(color: _selectedIndex == 4 ? primaryColor : Colors.black87)),
              selected: _selectedIndex == 4,
              onTap: () => _onItemTapped(4),
            ),
            const Divider(indent: 16.0, endIndent: 16.0),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              leading: Icon(Icons.account_circle_outlined, color: _selectedIndex == 5 ? primaryColor : Colors.grey[600]),
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
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.info), label: 'How It Works'),
          BottomNavigationBarItem(icon: Icon(Icons.send), label: 'Send Mission'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Choose Mission'),
          BottomNavigationBarItem(icon: Icon(Icons.phone), label: 'Contact'),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: 'Login'),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

// Constants for better readability and maintainability
const Color kPrimaryColor = Color(0xFF2962FF);
const Color kBackgroundColor = Color(0xFFF5F5F5);
const double kDefaultPadding = 16.0;
const double kLargePadding = 24.0;
const double kCardElevation = 4.0;
const double kRoundedBorderRadius = 12.0;
const String kRobotoFontFamily = 'Roboto';
const String kLogoImagePath = 'assets/images/logo.png';
const double kLogoWidth = 50.0;

void main() {
  runApp(const TheMissionApp());
}

// The root of the application
class TheMissionApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Hide debug banner
      title: 'The Mission App',
      theme: ThemeData(
        // Define primary swatch with different shades
        primarySwatch: const MaterialColor(
          0xFF2962FF,
          <int, Color>{
            50: Color(0xFFE3F2FD),
            100: Color(0xFFBBDEFB),
            200: Color(0xFF90CAF9),
            300: Color(0xFF64B5F6),
            400: Color(0xFF42A5F5),
            500: Color(0xFF2962FF),
            600: Color(0xFF1E88E5),
            700: Color(0xFF1976D2),
            800: Color(0xFF1565C0),
            900: Color(0xFF0D47A1),
        }),
        useMaterial3: true,
        fontFamily: kRobotoFontFamily,
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
  int selectedIndex = 0;

  static final List<Widget> widgetOptions = <Widget>[
    const HomeScreen(),
    const HowItWorksScreen(),
    const SendOnMissionScreen(),
    const ChooseMissionScreen(),
    const ContactScreen(),
    const LoginScreen(), // Added LoginScreen
  ];

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Center(
          child: Image.asset(
            'assets/images/logo.png',
            width: 50,
            //fit: BoxFit.cover,
            errorBuilder: (BuildContext context, Object exception,
                StackTrace? stackTrace) {
              return const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 50,
              );
            },
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            // Header for Drawer
            Container(
              padding: const EdgeInsets.only(
                  left: kDefaultPadding,
                  bottom: kDefaultPadding,
                  top: 40.0),
              decoration: BoxDecoration(
                color: kPrimaryColor,
              ),
              child: const Padding(
                padding: EdgeInsets.all(kDefaultPadding),
                child: Text(
                  'The Mission APP',
                  style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            // Menu Item Home
            DrawerMenuItem(
              icon: Icons.home_outlined,
              title: 'Home',
              index: 0,
              selectedIndex: selectedIndex,
              onTap: onItemTapped,
            ),
            const Divider(indent: kDefaultPadding, endIndent: kDefaultPadding),
            // Menu Item How It Works
            DrawerMenuItem(
              icon: Icons.info,
              title: 'How does it work',
              index: 1,
              selectedIndex: selectedIndex,
              onTap: onItemTapped,
            ),
            const Divider(indent: kDefaultPadding, endIndent: kDefaultPadding),
            // Menu Item Send On Mission
            DrawerMenuItem(
              icon: Icons.send_outlined,
              title: 'Send on Mission',
              index: 2,
              selectedIndex: selectedIndex,
              onTap: onItemTapped,
            ),
            const Divider(indent: kDefaultPadding, endIndent: kDefaultPadding),
            // Menu Item Choose Your Mission
            DrawerMenuItem(
              icon: Icons.search_outlined,
              title: 'Choose your mission',
              index: 3,
              selectedIndex: selectedIndex,
              onTap: onItemTapped,
            ),
            const Divider(indent: kDefaultPadding, endIndent: kDefaultPadding),
            // Menu Item Contact
            DrawerMenuItem(
              icon: Icons.phone_outlined,
              title: 'Contact',
              index: 4,
              selectedIndex: selectedIndex,
              onTap: onItemTapped,
            ),
            const Divider(indent: kDefaultPadding, endIndent: kDefaultPadding),
            // Menu Item Login
            DrawerMenuItem(
              icon: Icons.account_circle_outlined,
              title: 'Login',
              index: 5,
              selectedIndex: selectedIndex,
              onTap: onItemTapped,
            ),
            const Divider(indent: kDefaultPadding, endIndent: kDefaultPadding),
          ],
        ),
      ),
      body: Center(
        child: widgetOptions.elementAt(selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: kPrimaryColor,
        unselectedItemColor: Colors.grey[600],
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'How it works',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.send),
            label: 'Send on Mission',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Choose',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.phone),
            label: 'Contact',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Login',
          ),
        ],
      ),
    );
  }
}
// Reusable widget for drawer menu items
class DrawerMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final int index;
  final int selectedIndex;
  final Function(int) onTap;

  const DrawerMenuItem({super.key, required this.icon, required this.title, required this.index, required this.selectedIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: kDefaultPadding, vertical: 8),
      leading: Icon(icon, color: selectedIndex == index ? kPrimaryColor : Colors.grey[600]),
      title: Text(title, style: TextStyle(color: selectedIndex == index ? kPrimaryColor : Colors.black87)),
      selected: selectedIndex == index,
      selectedTileColor: Colors.grey[200],
      onTap: () => onTap(index),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          title: const Text(
            'The Mission App',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      body: SingleChildScrollView(
        child: Column(
          
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start, // Align content to the start for better flow
          children: <Widget>[
            // Image Placeholder with rounded corners
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(kRoundedBorderRadius),
              ),
              child: const Center(
                child: Icon(Icons.image_outlined, size: 60, color: Colors.grey),
              ),
            ),
            const SizedBox(height: kLargePadding),
            // Introduction Card
            Container(
              padding: const EdgeInsets.all(20), // Increased padding
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16), // More rounded corners
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 3,
                    blurRadius: 7,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'About The Mission',
                    textAlign: TextAlign.left, // Align title to the left
                    style: TextStyle(
                      fontSize: 26, // Larger font size
                      fontWeight: FontWeight.bold,
                      color: kPrimaryColor,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "What is The Mission? It's a platform that allows you to give tasks in minutes. It connects people from all over the world. It provides work for people quickly. You don't need to go through a long and complicated process to give or accept a task. All people on the platform are verified. It's a better guarantee for users than classified ads websites.",
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 18, color: Colors.black87), // Slightly larger and darker text
                  ), 
                  
                  const SizedBox(height: 20),
                  Text(
                    'Imagine the Possibilities',
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: Theme.of(context).primaryColor), // Use primary color with slightly lighter weight
                  ),
                  const SizedBox(height: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,                   
                    children: const <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 6.0), // Add vertical padding for list items
                        child: Text("• Need a hand with setting up your new TV? Or perhaps you need someone to pick up a gift while you are working?", style: TextStyle(fontSize: 16, color: Colors.black87)),
                        
                      ),
                      
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 6.0),
                        child: Text("• You could get a personalized menu, or a list of activities, tailored to your family's preferences.", style: TextStyle(fontSize: 16, color: Colors.black87)),
                        
                      ),
                      
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 6.0),
                        child: Text("• Or, how about finding someone to assist with pet care while you're away, or to walk your dog?", style: TextStyle(fontSize: 16, color: Colors.black87)),
                       
                      ),
                      
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 6.0),
                        child: Text("• And, as you browse, you will find profiles with many skills and qualifications, along with ratings and mission history, all in one place.", style: TextStyle(fontSize: 16, color: Colors.black87)),
                        
                      ),
                      
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Example of a button widget
                  ElevatedButton(
                    onPressed: () {
                      // Add your action here
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15), // Button Padding
                      textStyle: const TextStyle(fontSize: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text('Explore Missions', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: kLargePadding),
          ],
        ),
      ),
    );
  }
}

class HowItWorksScreen extends StatelessWidget {
  const HowItWorksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('How it works'),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(           
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const <Widget>[
            // Introduction Text
              const Container(
              padding: const EdgeInsets.all(20), // Increased padding
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                                       spreadRadius: 3,
                    blurRadius: 7,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:  <Widget>[
                  Text(
                    'How It Works',
                    textAlign: TextAlign.left, // Align title to the left
                    style: TextStyle(
                      fontSize: 26, // Larger font size
                     fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'The Mission is simple! Here’s how it works:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ])),
              
                const SizedBox(height: 12),
                
                const SizedBox(height: 24),
              _buildStepCard(
                  context,
                  'Post a Mission',
                  'Need something done? Just post a mission with a price and description.',
                  'assets/images/rocket.png'),
              const SizedBox(height: 16),
              _buildStepCard(
                  context,
                  'Get Applications',
                  'Verified users will apply to your mission.',
                  'assets/images/applications.png'),
              const SizedBox(height: 16),
              _buildStepCard(
                  context,
                  'Choose a Helper',
                  'Review applications and choose the best person for the job.',
                  'assets/images/choose.png'),
              const SizedBox(height: 16),
              _buildStepCard(
                  context,
                  'Mission Completed',
                  'Once the mission is done, approve the completion and the helper gets paid.',
                  'assets/images/completed.png'),
              const SizedBox(height: 24),
              Center(
                child: ElevatedButton(
                onPressed: () {
                  // Add your action here
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  textStyle: const TextStyle(fontSize: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text('Get Started Now',
                    style: TextStyle(color: Colors.white)),
              ),
              ), 
                const SizedBox(height: 24),
              const Text('Give us your suggestions:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              TextField(
                maxLines: 4,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter your suggestion here',
                ),
              ),
                const SizedBox(height: kLargePadding),
              Center(
                child: ElevatedButton(
                onPressed: () {
                  // Add your action here
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text('Send', style: TextStyle(color: Colors.white)),
              )              
              )
            ], // Children
          ),
        
      ),
    );
  }

  Widget _buildStepCard(BuildContext context, String title, String description, String imagePath) {
    return Card(
        elevation: kCardElevation,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(kRoundedBorderRadius)),
        child: Padding(
          padding: const EdgeInsets.all(kDefaultPadding),
          child: Row(
            children: [
                imagePath,
                width: 80,
                height: 80,
              ),
               const SizedBox(width: 16),
              // Text on the right
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text(description, style: const TextStyle(fontSize: 16)),
                  ],
                ),
              ),
            
             ],
          ),
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
          Text('Send on Mission',
              style: TextStyle(
                  fontSize: 24, fontWeight: FontWeight.bold, color: kPrimaryColor)),
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
                      //print('$category tapped');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MissionDetailsScreen(category: category)),
                      );
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
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Choose Your Mission',
              style: TextStyle(
                  fontSize: 24, fontWeight: FontWeight.bold, color: kPrimaryColor)),
          const SizedBox(height: 16),
          const Text(
            'Browse available missions posted by other users. You can filter by category, location, and price.',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 10),
          

          const Text(
            '**Available Missions:**',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text('- Need someone to pick up groceries (Location: Downtown, Price: \$20)', style: TextStyle(fontSize: 16)),
          const SizedBox(height: 8),
          const Text('- Walk my dog for 30 minutes (Location: Parkside, Price: \$15)', style: TextStyle(fontSize: 16)),
          const SizedBox(height: 8),
          const Text('- Help with assembling furniture (Location: Suburbs, Price: \$30)', style: TextStyle(fontSize: 16)),
          // Implement actual mission listing here (e.g., using ListView.builder fetching data)
                ],
      ),
    );
  }}

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Contact Us',
              style: TextStyle(
                  fontSize: 24, fontWeight: FontWeight.bold, color: kPrimaryColor)),
          const SizedBox(height: 16),
          const Text(
              'We are here to help! Feel free to reach out to us through the following methods:',
              style: TextStyle(fontSize: 16)),
          const SizedBox(height: 16),
          const Text('**Email:**',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text('contact@themissionapp.com',
              style: TextStyle(fontSize: 16)),
          const SizedBox(height: 16),
          const Text('**Phone:**',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text('+1 555-123-4567',
              style: TextStyle(fontSize: 16)),
          const SizedBox(height: 16),
          const Text('**Address:**',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text('123 Main Street, Anytown, USA',
              style: TextStyle(fontSize: 16)),
          const SizedBox(height: 16),
          const Text('**Address:**', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text('123 Main Street, Anytown, USA', style: TextStyle(fontSize: 16)),
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
                      color: Colors.grey.withAlpha(51),
                   spreadRadius: 1,
                  blurRadius: 5, 
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              children: <Widget>[
                Text('Login', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: primaryColor)),
                const SizedBox(height: 16),
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
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(kRoundedBorderRadius)),
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
           backgroundColor: kPrimaryColor,
          title: Text(
            'My Profile',
            style: TextStyle(
              color: Colors.white, // Ensure text color is readable
              fontWeight: FontWeight.bold,
            ),
          ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('My Profile', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: kPrimaryColor)),
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
      ),
    );
  }
}

class MissionDetailsScreen extends StatefulWidget {
  final String category;

  const MissionDetailsScreen({super.key, required this.category});

  @override
  State<MissionDetailsScreen> createState() => _MissionDetailsScreenState();
}

class _MissionDetailsScreenState extends State<MissionDetailsScreen> {
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _locationController = TextEditingController();
  final _dueDateController = TextEditingController();
  final _criteriaController = TextEditingController();

  Future<void> _sendEmail() async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'gaidajis@gmail.com',
      queryParameters: {
        'subject': 'New Mission: ${widget.category}',
        'body': 'Category: ${widget.category}\n'
            'Price: ${_priceController.text}\n'
            'Description: ${_descriptionController.text}\n'
            'Location: ${_locationController.text}\n'
            'Due Date: ${_dueDateController.text}\n'
            'Criteria: ${_criteriaController.text}',
      },
    );

    final canLaunch = await canLaunchUrlString(emailLaunchUri.toString());
    if (!mounted) return;
    if (canLaunch) {
      await launchUrlString(emailLaunchUri.toString());
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Mission details sent via email!')),
      );
      Navigator.pop(context);
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not launch email app.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: primaryColor,
          title: Text(
            'New ${widget.category} Mission',
            style: TextStyle(
              color: Colors.white, // Ensure text color is readable
              fontWeight: FontWeight.bold,
            ), // Text Style
          ),
        ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Create a new ${widget.category} mission', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: primaryColor)), // Use primary color
            const SizedBox(height: 16),
            TextField(controller: _priceController, decoration: const InputDecoration(labelText: 'Price')),
            const SizedBox(height: 8),
            TextField(controller: _descriptionController, maxLines: 3, decoration: const InputDecoration(labelText: 'Description')),
            const SizedBox(height: 8),
            TextField(controller: _locationController, decoration: const InputDecoration(labelText: 'Location')),
            const SizedBox(height: 8),
            TextField(controller: _dueDateController, decoration: const InputDecoration(labelText: 'Due Date')),
            const SizedBox(height: 8),
            TextField(controller: _criteriaController, maxLines: 2, decoration: const InputDecoration(labelText: 'Criteria')),
            const SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: _sendEmail,
              child: const Text('Send Mission', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}