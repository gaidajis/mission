// lib/home_screen.dart
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'auth_service.dart';
import 'package:google_fonts/google_fonts.dart';
import 'send_on_mission_screen.dart';
import 'choose_mission_screen.dart';
import 'contact_screen.dart';
import 'how_it_works_screen.dart';
import 'profile_screen.dart'; // Assuming you have this file

class MainAppScreen extends StatefulWidget {
  const MainAppScreen({super.key});

  @override
  MainAppScreenState createState() => MainAppScreenState();
}

class MainAppScreenState extends State<MainAppScreen> {
  int _selectedIndex = 0;

  late List<Widget> _widgetOptions;

  @override
  void initState() {
    super.initState();
    _widgetOptions = <Widget>[
      _buildHomeScreen(),
      const HowItWorksScreen(),
      const SendOnMissionScreen(),
      const ChooseMissionScreen(),
      const ContactScreen(),
      const ProfileScreen(), // Profile is now in the drawer
    ];
  }

  Widget _buildHomeScreen() {
    final currentUser = AuthService().getCurrentUser();
    if (currentUser == null) {
      return const Center(child: Text('User not logged in'));
    }
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .get()
          .catchError((error) {
        print("Error fetching user data: $error");
        return null; // Or handle the error as needed
      }),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError || !snapshot.hasData || !snapshot.data!.exists || snapshot.data == null) {
          return const Center(child: Text('Error loading user data'));
        }
        final userData = snapshot.data!.data() as Map<String, dynamic>?;
        final userName = userData?['displayName'] ?? 'Guest';

        return Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.black87, Colors.black],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Image.asset(
                            'assets/images/Gemini_Generated_Image_ehb5lnehb5lnehb5.jpeg',
                            height: 200,
                            width: 200,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Welcome, $userName!',
                          style: GoogleFonts.genos(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  Text(
                    'The Mission',
                    style: GoogleFonts.genos(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Connecting Global Needs with Local Action\n\n'
                    'Our Mission\n\n'
                    'The mission of The Mission is to create a revolutionary platform that empowers anyone, anywhere, to connect their needs with a global network of individuals ready to assist online and offline. We envision a world where geographical boundaries no longer limit what you can request and achieve.\n\n'
                    'The Core Idea: Global Demand, Local Action\n\n'
                    'Imagine a world where you can tap into the skills, resources, and local knowledge of people across the globe, all from the convenience of your device. The Mission facilitates this by allowing users to:\n\n'
                    'Clearly Articulate Their Demand: Users can post specific requests, outlining exactly what they need, where they need it, and any relevant details.\n\n'
                    'Connect with a Global Network: The Mission connects these demands with a diverse pool of users who can offer their services, time, or local expertise.\n\n'
                    'Facilitate Online and Offline Actions: Requests can range from purely digital tasks to real-world actions performed in a specific location.\n\n'
                    'Examples in Action\n\n'
                    'Here are some examples of how The Mission can bridge global needs, categorized by service type:\n\n'
                    'Standard Services:\n\n'
                    'Social:\nConnect with locals for virtual coffee chats and cultural exchange.\nFind online language practice partners for various languages.\nRequest virtual companionship for someone feeling lonely.\nSeek advice and insights from locals on cultural norms and etiquette.\nTransportation:\nRequest someone to book a specific type of taxi or public transport ticket in a different city.\nAsk a local to research the best transportation options between two points in their area.\nCoordinate airport pickups or drop-offs (beyond premium services).\nDelivery:\nRequest someone to purchase and ship local goods or products not available in your area.\nArrange for the delivery of forgotten items to a specific location within a city.\nCoordinate the pick-up and delivery of documents or small packages locally.\nGoods:\nAsk someone to physically browse local stores for a specific item and provide photos or descriptions before purchase.\nRequest help finding rare or vintage items in a particular region.\nSeek recommendations for the best local markets or shops for specific types of goods.\nSocial Animals:\nRequest a local to check in on your pet while you are away (with appropriate safety measures and verification).\nFind someone in a specific area to walk your pet during the day.\nSeek advice from local pet owners on the best vets or pet-friendly places.\nRepairs:\nRequest a virtual consultation with someone who has experience fixing a specific type of household item.\nAsk a local to recommend reliable repair services in their area.\nSeek guidance on troubleshooting common technical issues.\nSpecial Requests:\nCraving authentic Japanese ramen while living in Switzerland? You can connect with someone in Japan to guide you through an online cooking class, curate a package of local ingredients to be shipped, or even recommend the best local ramen spots for your next trip.\nNeed a visual confirmation of something in a faraway place? If you\'re in Hawaii and want to see how your house in Greece weathered a storm, you can request a local to take photos or even a short video.\nArriving in a new city and want a premium welcome? You can connect with locals willing to greet you at the airport with a specific vehicle, assist with luggage, or provide local insights upon arrival.\nLooking for a unique, handcrafted item from a specific region? You can request locals to browse markets and shops on your behalf and arrange for shipping.\nWant to practice a new language with a native speaker? Connect with individuals globally for online conversation exchange.\nCurious about a city you\'ve always dreamed of visiting? Request a local to give you a live virtual tour, highlighting key landmarks and hidden gems.\nNeed specific information or data from a particular location? Connect with locals who can help with research, data collection, or fact-checking.\nNeed help with a task that requires a specific skill, regardless of location? Find individuals globally who can offer their expertise remotely, such as graphic design, coding, or writing.\nIn times of crisis, users could potentially connect with local individuals who can offer support or relay information.\nUsers could request help with local environmental initiatives or support for community projects in different parts of the world.\nAsk a local to wait in line for a highly anticipated product release.\nRequest someone to transcribe a document in a specific language.\nSeek assistance in planning a local event or gathering from afar.\n\n'
                    'Key Features We Envision for The Mission\n\n'
                    'Detailed Request Creation: Allowing users to specify category (social, transportation, delivery, etc.), location, budget, timeframe, and any other crucial details.\nRobust Search and Filtering: Enabling users to find the right individuals based on location, skills, service categories offered, reviews, and availability.\nSecure Communication Channels: Facilitating safe and direct communication between requesters and providers.\nReputation and Review System: Building trust and accountability within the community.\nSecure Payment Options: Providing a reliable platform for transactions.\nLocation-Based Services: Leveraging location to connect users with nearby individuals for offline requests.\nNotification System: Keeping users informed about the status of their requests and relevant responses.\nCategorization of Requests: Organizing demands into clear and intuitive categories (Standard Services and Special Requests) for easier Browse and matching.\nService Provider Profiles: Allowing users to showcase their skills, services offered, and areas of expertise.\n\n'
                    'Join Us in Achieving The Mission: A Globally Connected Community\n\n'
                    'We believe The Mission has the potential to break down geographical barriers and foster a truly global community where diverse needs can be met by the wide-ranging talents and local knowledge of individuals worldwide. We are excited to embark on this journey and invite you to join us in making this vision a reality.',
                    style: GoogleFonts.roboto(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // Navigator.pop(context); // Remove this line to allow the body to update
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
        actions: const <Widget>[],
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
                child: Image.asset(
                  '/home/user/mission_idx/assets/images/Gemini_Generated_Image_ehb5lnehb5lnehb5.jpeg',
                  height: 60,
                  width: 60,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              leading: const Icon(Icons.home, color: Colors.grey),
              title: Text(
                'Home',
                style: TextStyle(
                  color: _selectedIndex == 0 ? const Color(0xFF819ca9) : Colors.grey,
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
                  color: _selectedIndex == 1 ? const Color(0xFF819ca9) : Colors.grey,
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
                  color: _selectedIndex == 2 ? const Color(0xFF819ca9) : Colors.grey,
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
                  color: _selectedIndex == 3 ? const Color(0xFF819ca9) : Colors.grey,
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
                  color: _selectedIndex == 4 ? const Color(0xFF819ca9) : Colors.grey,
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
                'Profile',
                style: TextStyle(
                  color: _selectedIndex == 5 ? const Color(0xFF819ca9) : Colors.grey, // Profile is now at index 5
                ),
              ),
              selected: _selectedIndex == 5, // Profile is now at index 5
              selectedTileColor: Colors.black54,
              onTap: () => _onItemTapped(5), // Profile is now at index 5
            ),
            const Divider(indent: 16.0, endIndent: 16.0, color: Colors.grey),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              leading: const Icon(Icons.logout, color: Colors.grey),
              title: Text(
                'Logout',
                style: TextStyle(
                  color: _selectedIndex == 6 ? const Color(0xFF819ca9) : Colors.grey, // Logout is now at index 6
                ),
              ),
              selected: _selectedIndex == 6, // Logout is now at index 6
              selectedTileColor: Colors.black54,
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                if (context.mounted) {
                  Navigator.pushReplacementNamed(context, '/login');
                }
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
    );
  }
}