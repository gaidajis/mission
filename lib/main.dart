import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

final Color primaryColor = const Color(0xFF2962FF);

void main() {
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
        primarySwatch: MaterialColor(0xFF2962FF, <int, Color>{
          50: Color(0xFFE3F2FD), 100: Color(0xFFBBDEFB), 200: Color(0xFF90CAF9), 300: Color(0xFF64B5F6), 400: Color(0xFF42A5F5), 500: Color(0xFF2962FF), 600: Color(0xFF1E88E5), 700: Color(0xFF1976D2), 800: Color(0xFF1565C0), 900: Color(0xFF0D47A1),
        }),
        useMaterial3: true,
        fontFamily: 'Roboto',
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
    Navigator.pop(context); // Close the drawer
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color(0xFFF5F5F5), // Light background for modern look
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
          )),
        titleTextStyle: const TextStyle(fontFamily: 'Roboto', color: Colors.white),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
             DrawerHeader(
              padding: const EdgeInsets.only(
                  left: 16.0, bottom: 16.0, top: 40.0), 
              decoration: const BoxDecoration(
              ),
              child: const Align(
                 alignment: Alignment.bottomLeft,
                 child: Text(
                  'The Mission APP',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold), // More prominent title
                ),
              ),
            ),  
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              leading: Icon(Icons.home, color: _selectedIndex == 0 ? primaryColor : Colors.grey[600]),
              title: Text('Home', style: TextStyle(color: _selectedIndex == 0 ? primaryColor : Colors.black87,)),
              selected: _selectedIndex == 0, // Highlight the selected item
              selectedTileColor:
                  Colors.grey[200], // Color when item is selected

              onTap: () => _onDrawerItemTapped(0),
            ),
            const Divider(indent: 16.0, endIndent: 16.0, height: 0),          ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              leading: Icon(Icons.info_outline, color: _selectedIndex == 1 ? primaryColor : Colors.grey[600]),
              title: Text('How does it work', style: TextStyle(color: _selectedIndex == 1 ? primaryColor : Colors.black87,)),
              selected: _selectedIndex == 1,
              onTap: () => _onDrawerItemTapped(1),
            ),
            const Divider(indent: 16.0, endIndent: 16.0,height: 0),           ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              leading: Icon(Icons.send, color: _selectedIndex == 2 ? primaryColor : Colors.grey[600]),
              title: Text('Send on Mission', style: TextStyle(color: _selectedIndex == 2 ? primaryColor : Colors.black87,)),
              selected: _selectedIndex == 2,
              onTap: () => _onDrawerItemTapped(2),
            ),
            const Divider(indent: 16.0, endIndent: 16.0, height: 0),           ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              leading: Icon(Icons.search, color: _selectedIndex == 3 ? primaryColor : Colors.grey[600]),
              title: Text('Choose your mission', style: TextStyle(color: _selectedIndex == 3 ? primaryColor : Colors.black87,)),
              selected: _selectedIndex == 3,
              onTap: () => _onDrawerItemTapped(3),
            ),
            const Divider(indent: 16.0, endIndent: 16.0, height: 0),           ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              leading: Icon(Icons.phone, color: _selectedIndex == 4 ? Colors.blue : Colors.grey[600]),
              title: Text('Contact', style: TextStyle(color: _selectedIndex == 4 ? Colors.blue : Colors.black87,)),
              selected: _selectedIndex == 4,
              onTap: () => _onDrawerItemTapped(4),
            ),
            const Divider(indent: 16.0, endIndent: 16.0, height: 0),            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              leading: Icon(Icons.account_circle, color: _selectedIndex == 5 ? Colors.blue : Colors.grey[600]),
              title: Text('Login', style: TextStyle(color: _selectedIndex == 5 ? Colors.blue : Colors.black87,)),
              selected: _selectedIndex == 5,
              onTap: () => _onDrawerItemTapped(5),
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
          setState(() {_selectedIndex = index;}); // Update the selected index
        },
        type: BottomNavigationBarType.fixed,

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
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold( // Using Scaffold for a basic page structure
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: const Text(
            'Home',
            style: TextStyle(
              color: Colors.white, // Ensure text color is readable
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(

          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Image Placeholder with rounded corners
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.grey[300], // Placeholder color
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: Icon(Icons.image_outlined, size: 60, color: Colors.grey),
              ),
            ),
            const SizedBox(height: 24), // Increased spacing
            // Introduction Card
             Container(
              padding: const EdgeInsets.all(20), // Increased padding
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withAlpha(76), // Softer shadow
                    spreadRadius: 3,
                    blurRadius: 7,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, // Align text to the start
                children: <Widget>[
                  Text(
                    'About The Mission',
                    textAlign: TextAlign.left, // Align title to the left
                    style: TextStyle(
                      fontSize: 26, // Larger font size
                      fontWeight: FontWeight.bold,
                      color: primaryColor, // Use secondary color
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
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: primaryColor), // Use primary color with slightly lighter weight
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
                      backgroundColor: primaryColor,
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
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
            const SizedBox(height: 24), // Add more spacing at the end
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
        backgroundColor: primaryColor,
        title: const Text('How it works', style: TextStyle(color: Colors.white),),        
      ),
      body:  Padding(
          padding: const EdgeInsets.all(16.0),
           child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
             Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.circular(16), // More rounded corners
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withAlpha(76), // Softer shadow
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
                    'How It Works',
                    textAlign: TextAlign.left, // Align title to the left
                    style: const TextStyle(
                      fontSize: 26, // Larger font size
                     fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'The Mission is simple! Here’s how it works:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ])),                
              const SizedBox(height: 24),
              _buildStepCard(
                  context,
                  'Post a Mission',
                  'Need something done? Just post a mission with a price and description.',
                  'assets/images/post.png'),
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
                  'Once the mission is done, approve the completion and the heper gets paid.',
                  'assets/images/completed.png'),
              const SizedBox(height: 24),
              Center(
                  child: ElevatedButton(
                onPressed: () {
                  // Add your action here
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
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
              )           
            ],
          ),
        ),
        
      
    );
  }

  Widget _buildStepCard(BuildContext context, String title, String description, String imagePath) {
    return Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              // Image on the left
              Image.asset(
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
                  fontSize: 24, fontWeight: FontWeight.bold, color: primaryColor)), const SizedBox(height: 16),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              childAspectRatio: 2 / 1,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              children: <String>[
                'Errands',
                'Transportation Delivery',
                'Food',
                'SocialInteraction',
                'Animals',
                'SpecialMissions',
                'Repairs',
              ].map((category){
                return Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
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
          )
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
                  fontSize: 24, fontWeight: FontWeight.bold, color: primaryColor)),
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
          Text('Contact Us',
              style: TextStyle(
                  fontSize: 24, fontWeight: FontWeight.bold, color: primaryColor)),
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
                const SizedBox(height: 20),                
                TextField(
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
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))
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
        backgroundColor: primaryColor,
        title: const Text(
          'My Profile',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,),          
        ),
        iconTheme: const IconThemeData(color: Colors.white),       
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
         crossAxisAlignment: CrossAxisAlignment.center,
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
      await launchUrlString(emailLaunchUri.toString(),);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Mission details sent via email!')),
      );
      Navigator.pop(context);
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content:  Text('Could not launch email app.')),
      );
    }    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: primaryColor,
          title: Text(
             'New ${widget.category} Mission', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold,),
          ),
          iconTheme: const IconThemeData(color: Colors.white),
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
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))
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
