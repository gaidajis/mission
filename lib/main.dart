import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mission App',
      theme: ThemeData(
        primarySwatch: Colors.teal, // Modernized primary color
        hintColor: Colors.grey[600], // Improved hint color
        textTheme: const TextTheme(
          bodyMedium: TextStyle(fontSize: 16.0, color: Colors.black87), // Better default body text
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const AppSkeleton(),
    );
  }
}

class AppSkeleton extends StatefulWidget {
  const AppSkeleton({super.key});

  @override
  _AppSkeletonState createState() => _AppSkeletonState();
}

class _AppSkeletonState extends State<AppSkeleton> {
  int _selectedIndex = 0;
  final List<Widget> _widgetOptions = <Widget>[
    const HomeScreen(),
    const HowItWorksScreen(),
    const SendOnMissionScreen(),
    const ChooseYourMissionScreen(),
    const ContactScreen(),
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
        title: const Text('Mission App', style: TextStyle(fontWeight: FontWeight.bold)), // Bold app title
        backgroundColor: Colors.teal, // Modernized app bar color
        elevation: 1.0, // Subtle shadow
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.teal, // Modernized drawer header color
              ),
              child: Text(
                'Mission App',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold, // Bold drawer title
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.login, color: Colors.teal), // Themed icon
              title: const Text('Login', style: TextStyle(fontWeight: FontWeight.w500)), // Slightly bolder text
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.question_mark),
            label: 'How it works',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.send),
            label: 'Send Mission',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: 'Choose Mission',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.phone),
            label: 'Contact',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.teal, // Modernized selected color
        unselectedItemColor: Colors.grey[600], // Improved unselected color
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white, // White background for bottom bar
        elevation: 2.0, // Subtle shadow
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Our Services',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.teal[700]), // More prominent title
          ),
          const SizedBox(height: 16),
          Text(
            'We connect people who need tasks done with reliable individuals willing to help, globally. Get the help you need or earn by completing missions!',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 18), // Improved description
          ),
          const SizedBox(height: 24),
          _buildServiceItem(
            context,
            'Errands',
            'Need someone to pick up groceries or run a quick errand? We\'ve got you covered.',
            Icons.shopping_cart, // Example icon
          ),
          const SizedBox(height: 16),
          _buildServiceItem(
            context,
            'Transportation & Delivery',
            'From delivering packages to providing a ride, find reliable transportation solutions.',
            Icons.local_shipping, // Example icon
          ),
          const SizedBox(height: 16),
          _buildServiceItem(
            context,
            'Food',
            'Craving something specific? Find someone to get it for you.',
            Icons.restaurant, // Example icon
          ),
          const SizedBox(height: 16),
          _buildServiceItem(
            context,
            'Social Interaction',
            'Looking for companionship or someone to hang out with? Connect with others in your area.',
            Icons.people, // Example icon
          ),
          const SizedBox(height: 16),
          _buildServiceItem(
            context,
            'Special Missions',
            'Have a unique task? Describe it and find someone who can help.',
            Icons.star, // Example icon
          ),
          const SizedBox(height: 16),
          _buildServiceItem(
            context,
            'Repairs',
            'Need a quick fix around the house? Find skilled individuals for minor repairs.',
            Icons.build, // Example icon
          ),
        ],
      ),
    );
  }

  Widget _buildServiceItem(BuildContext context, String title, String description, IconData icon) {
    return Row(
      children: <Widget>[
        Icon(icon, size: 50, color: Colors.teal), // Themed icon
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(title, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.teal)), // Themed title
              const SizedBox(height: 8),
              Text(description, style: Theme.of(context).textTheme.bodyMedium), // Improved description
            ],
          ),
        ),
      ],
    );
  }
}

class HowItWorksScreen extends StatelessWidget {
  const HowItWorksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'How It Works',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.teal), // More prominent title
          ),
          SizedBox(height: 16),
          Text(
            'Welcome to our global task network! Here\'s a simple guide to get you started:',
            style: TextStyle(fontSize: 18), // Improved introductory text
          ),
          SizedBox(height: 20),
          _StepItem(
            title: '1. Request a Mission',
            description: 'If you need a task done, simply post a "mission" with a clear description, relevant category, and an optional price you\'re willing to offer.',
          ),
          SizedBox(height: 16),
          _StepItem(
            title: '2. Browse Missions',
            description: 'If you\'re looking to help others, browse the available missions in your area or across the globe based on different categories.',
          ),
          SizedBox(height: 16),
          _StepItem(
            title: '3. Connect and Agree',
            description: 'Once a task taker shows interest in your mission, or you find a mission you want to take, connect with the other party to discuss the specifics and agree on the terms.',
          ),
          SizedBox(height: 16),
          _StepItem(
            title: '4. Complete the Mission',
            description: 'The task taker performs the agreed-upon task diligently and ensures it meets the requester\'s needs.',
          ),
          SizedBox(height: 16),
          _StepItem(
            title: '5. Confirmation and Feedback',
            description: 'After the mission is completed, the requester confirms the completion, and both parties can provide feedback to build trust within the community.',
          ),
          SizedBox(height: 24),
          Text(
            'Our platform facilitates a seamless connection between those who need help and those who are ready to lend a hand, making tasks easier to manage globally.',
            style: TextStyle(fontSize: 18), // Improved concluding text
          ),
        ],
      ),
    );
  }
}

class _StepItem extends StatelessWidget {
  final String title;
  final String description;

  const _StepItem({required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.teal)), // Themed step title
        const SizedBox(height: 8),
        Text(description, style: Theme.of(context).textTheme.bodyMedium), // Improved step description
      ],
    );
  }
}

class SendOnMissionScreen extends StatefulWidget {
  const SendOnMissionScreen({super.key});

  @override
  State<SendOnMissionScreen> createState() => _SendOnMissionScreenState();
}

class _SendOnMissionScreenState extends State<SendOnMissionScreen> {
  DateTime? _selectedDate;
  final TextEditingController _dateController = TextEditingController();

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            DropdownButtonFormField<String>(
              items: <String>[
                'Errands',
                'Transportation & Delivery',
                'Food',
                'Social Interaction',
                'Special Missions',
                'Repairs'
              ].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                // Handle dropdown value change
              },
              decoration: InputDecoration(
                labelText: 'Mission Category',
                border: const OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.teal)), // Themed focus border
              ),
            ),
            const SizedBox(height: 16),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.teal)), // Themed focus border
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            const TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Price (Optional)',
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.teal)), // Themed focus border
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _dateController,
              decoration: InputDecoration(
                labelText: 'Due Date (Optional)',
                border: const OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.teal)), // Themed focus border
                suffixIcon: const Icon(Icons.calendar_today, color: Colors.teal), // Themed icon
              ),
              readOnly: true,
              onTap: () async {
                _selectedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2023),
                  lastDate: DateTime(2030),
                  builder: (BuildContext context, Widget? child) {
                    return Theme(
                      data: ThemeData.light().copyWith(
                        primaryColor: Colors.teal,
                        hintColor: Colors.teal,
                        colorScheme: const ColorScheme.light(primary: Colors.teal).copyWith(secondary: Colors.teal),
                        buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.primary),
                      ),
                      child: child!,
                    );
                  },
                );
                if (_selectedDate != null) {
                  _dateController.text = _selectedDate.toString().split(' ')[0];
                }
              },
            ),
            const SizedBox(height: 16),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Criteria (Optional)',
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.teal)), // Themed focus border
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // Implement submit mission logic
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal, // Themed button color
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                textStyle: const TextStyle(fontSize: 18),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text('Submit Mission', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}

class ChooseYourMissionScreen extends StatelessWidget {
  const ChooseYourMissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Available Missions',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.teal[700]), // More prominent title
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: _missionCategories.length,
              itemBuilder: (context, index) {
                final category = _missionCategories[index];
                return Card(
                  elevation: 2.0,
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  child: InkWell(
                    onTap: () {
                      // Implement navigation or filtering for this category
                      print('Tapped on $category');
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        category,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.teal), // Themed category text
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

const List<String> _missionCategories = [
  'Errands',
  'Transportation & Delivery',
  'Food',
  'Social Interaction',
  'Special Missions',
  'Repairs',
];

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Contact Us',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.teal),
          ),
          SizedBox(height: 16),
          Text(
            'Need assistance? Reach out to Alice!',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 20),
          ListTile(
            leading: Icon(Icons.person, color: Colors.teal),
            title: Text('Alice Kha', style: TextStyle(fontWeight: FontWeight.w500)),
          ),
          ListTile(
            leading: Icon(Icons.email, color: Colors.teal),
            title: Text('a.alice.kha@gmail.com', style: TextStyle(fontWeight: FontWeight.w500)),
          ),
          ListTile(
            leading: Icon(Icons.phone, color: Colors.teal),
            title: Text('+41 79 889 61 28', style: TextStyle(fontWeight: FontWeight.w500)),
          ),
          SizedBox(height: 24),
          Text(
            'I am here to help!',
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login', style: TextStyle(fontWeight: FontWeight.bold)), // Bold title
        backgroundColor: Colors.teal, // Themed app bar color
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const TextField(
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.teal)), // Themed focus border
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.teal)), // Themed focus border
              ),
              obscureText: true,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                // Implement login logic
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal, // Themed button color
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                textStyle: const TextStyle(fontSize: 18),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text('Login', style: TextStyle(color: Colors.white)),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                // Implement forgot password or sign up navigation
              },
              style: TextButton.styleFrom(foregroundColor: Colors.teal), // Themed text button color
              child: const Text('Forgot Password? / Sign Up', style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}