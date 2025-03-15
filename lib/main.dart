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
        primarySwatch: Colors.blue,
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
        title: const Text('Mission App'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Mission App',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.login),
              title: const Text('Login'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
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
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
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
          const Text(
            'Our Services',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          const Text(
            'We connect people who need tasks done with reliable individuals willing to help, globally.',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 20),
          // Example Service 1
          Row(
            children: <Widget>[
              const SizedBox(
                width: 100,
                height: 100,
                child: Placeholder(), // Replace with your image
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const <Widget>[
                    Text('Errands', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    Text('Need someone to pick up groceries or run a quick errand? We\'ve got you covered.'),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Example Service 2
          Row(
            children: <Widget>[
              const SizedBox(
                width: 100,
                height: 100,
                child: Placeholder(), // Replace with your image
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const <Widget>[
                    Text('Transportation & Delivery', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    Text('From delivering packages to providing a ride, find reliable transportation solutions.'),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Add more service descriptions with images here
          const SizedBox(
            width: 100,
            height: 100,
            child: Placeholder(), // Replace with your image
          ),
          const SizedBox(height: 8),
          const Text('Food', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const Text('Craving something specific? Find someone to get it for you.'),
          const SizedBox(height: 16),
          const SizedBox(
            width: 100,
            height: 100,
            child: Placeholder(), // Replace with your image
          ),
          const SizedBox(height: 8),
          const Text('Social Interaction', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const Text('Looking for companionship or someone to hang out with? Connect with others in your area.'),
          const SizedBox(height: 16),
          const SizedBox(
            width: 100,
            height: 100,
            child: Placeholder(), // Replace with your image
          ),
          const SizedBox(height: 8),
          const Text('Special Missions', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const Text('Have a unique task? Describe it and find someone who can help.'),
          const SizedBox(height: 16),
          const SizedBox(
            width: 100,
            height: 100,
            child: Placeholder(), // Replace with your image
          ),
          const SizedBox(height: 8),
          const Text('Repairs', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const Text('Need a quick fix around the house? Find skilled individuals for minor repairs.'),
        ],
      ),
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
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Text(
            'Welcome to our global task network! Here\'s how it works:',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 10),
          Text(
            '1. **Request a Mission:** If you need a task done, simply post a "mission" with a description, category, and optional price.',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          Text('Be clear about what you need and any specific requirements.'),
          SizedBox(height: 10),
          Text(
            '2. **Browse Missions:** If you\'re looking to help, browse the available missions in your area or globally based on categories.',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          Text('Find tasks that match your skills and interests.'),
          SizedBox(height: 10),
          Text(
            '3. **Connect and Agree:** Once a task taker is interested in your mission, or you find a mission you want to take, you can connect with the other party to discuss details and agree on terms.',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(
            '4. **Complete the Mission:** The task taker completes the mission as agreed.',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(
            '5. **Confirmation and Feedback:** Once the mission is complete, confirm the completion and provide feedback to help build a trusted community.',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Text(
            'Whether you need help with errands, deliveries, or even social interactions, our platform connects you with a global network of willing individuals. Start sending and receiving missions today!',
            style: TextStyle(fontSize: 16),
          ),
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
              decoration: const InputDecoration(
                labelText: 'Mission Category',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 10),
            const TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Price (Optional)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Due Date (Optional)',
                border: OutlineInputBorder(),
              ),
              readOnly: true, // Prevent manual editing
              onTap: () async {
                // Implement date picker here
                DateTime? selectedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2023),
                  lastDate: DateTime(2030),
                );
                if (selectedDate != null) {
                  // Update the text field with the selected date
                }
              },
            ),
            const SizedBox(height: 10),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Criteria (Optional)',
                border: OutlineInputBorder(),
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Implement submit mission logic
              },
              child: const Text('Submit Mission'),
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
          const Text(
            'Available Missions',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView(
              children: const <Widget>[
                Card(child: Padding(padding: EdgeInsets.all(10.0), child: Text('Errands', style: TextStyle(fontSize: 18)))),
                Card(child: Padding(padding: EdgeInsets.all(10.0), child: Text('Transportation & Delivery', style: TextStyle(fontSize: 18)))),
                Card(child: Padding(padding: EdgeInsets.all(10.0), child: Text('Food', style: TextStyle(fontSize: 18)))),
                Card(child: Padding(padding: EdgeInsets.all(10.0), child: Text('Social Interaction', style: TextStyle(fontSize: 18)))),
                Card(child: Padding(padding: EdgeInsets.all(10.0), child: Text('Special Missions', style: TextStyle(fontSize: 18)))),
                Card(child: Padding(padding: EdgeInsets.all(10.0), child: Text('Repairs', style: TextStyle(fontSize: 18)))),
                // Add more categories or mission listings here
              ],
            ),
          ),
        ],
      ),
    );
  }
}

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
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Text(
            'Have questions or need assistance?',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 10),
          Text('Email: support@missionapp.com'),
          Text('Phone: +1 (555) 123-4567'),
          Text('Address: 123 Main Street, Anytown, USA'),
          // Add a contact form or more details as needed
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
        title: const Text('Login'),
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
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 10),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Implement login logic
                Navigator.pop(context); // For now, just go back
              },
              child: const Text('Login'),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {
                // Implement forgot password or sign up navigation
              },
              child: const Text('Forgot Password? / Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}