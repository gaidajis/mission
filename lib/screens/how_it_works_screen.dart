import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'send_on_mission_screen.dart'; // Assuming this screen exists

class HowItWorksScreen extends StatelessWidget {
  const HowItWorksScreen({super.key});

  // Define the steps data to avoid repetition
  final List<Map<String, dynamic>> _steps = const [
    {
      'icon': Icons.edit_location,
      'title': '1. Describe Your Need',
      'description':
          'Clearly define what you need - from local food in Japan to a virtual tour in Greece.',
    },
    {
      'icon': Icons.category,
      'title': '2. Specify the Service',
      'description':
          'Choose a category: Social, Transportation, Delivery, Goods, Social Animals, Repairs, or Special Requests.',
    },
    {
      'icon': Icons.settings,
      'title': '3. Set Your Terms',
      'description':
          'Indicate your budget, desired timeframe, and any specific instructions.',
    },
    {
      'icon': Icons.public,
      'title': '4. Connect Globally',
      'description':
          'Your mission is broadcast to a worldwide network of potential helpers.',
    },
    {
      'icon': Icons.assignment_turned_in,
      'title': '5. Receive Offers',
      'description':
          'Interested users will submit their applications to fulfill your mission.',
    },
    {
      'icon': Icons.person_search,
      'title': '6. Select Your Helper',
      'description':
          'Review applications, check profiles, and choose the best person for the task.',
    },
    {
      'icon': Icons.chat_bubble_outline,
      'title': '7. Mission in Progress',
      'description':
          'Communicate directly with your chosen helper to coordinate the task.',
    },
    {
      'icon': Icons.check_circle_outline,
      'title': '8. Mission Accomplished',
      'description':
          'Once the mission is completed to your satisfaction, approve and the helper gets paid.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    const Color textColor = Colors.grey; // Consistent text color
    const Color iconColor = Colors.grey; // Consistent icon color
    const Color cardBackgroundColor = Color(0xFF2A2A2A); // Slightly lighter than pure black
    const Color borderColor = Color(0xFF424242); // Subtle border color

    return Scaffold(
      appBar: AppBar(
        // Kept AppBar styling as it wasn't explicitly mentioned as problematic
        backgroundColor: Colors.black87,
        title: Text(
          'How The Mission Works',
          style: TextStyle(color: textColor),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.black87, Colors.black], // Dark gradient
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        iconTheme: const IconThemeData(color: textColor), // Ensure back arrow is visible
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black87, Colors.black], // Consistent dark gradient
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        // Use SafeArea to avoid OS intrusions (notch, status bar, navigation bar)
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
                child: Text(
                  'Unleash the Power of Global Connection',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22, // Slightly larger for emphasis
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ), // Changed to TextStyle
                ),
              ),
              // Use Expanded with ListView for scrollable steps
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  itemCount: _steps.length,
                  itemBuilder: (context, index) {
                    final step = _steps[index];
                    // Use ListTile for a standard, well-structured layout
                    return _buildStepTile(
                      context: context,
                      icon: step['icon'] as IconData,
                      title: step['title'] as String,
                      description: step['description'] as String,
                      iconColor: iconColor,
                      textColor: textColor,
                      backgroundColor: cardBackgroundColor,
                      borderColor: borderColor,
                      isFirst: index == 0,
                      isLast: index == _steps.length - 1,
                    );
                  },
                ),
              ),
              // Keep the button outside the scrollable list
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SendOnMissionScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF333333), // Darker grey button
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 16),
                    textStyle: GoogleFonts.genos(fontSize: 18, fontWeight: FontWeight.w600),
                    // Removed GoogleFonts here.
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      side: BorderSide(color: borderColor) // Subtle border matching cards
                    ),
                    elevation: 3,
                    shadowColor: Colors.black,
                    foregroundColor: textColor, // Text color
                  ),
                  child: const Text('Initiate Your Mission'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Using ListTile for better structure and accessibility
  Widget _buildStepTile({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String description,
    required Color iconColor,
    required Color textColor,
    required Color backgroundColor,
    required Color borderColor,
    bool isFirst = false,
    bool isLast = false,
  }) {
    // Define corner radius for the cards
    const Radius cardRadius = Radius.circular(8.0);
    // Define shape based on position in the list
    final ShapeBorder cardShape = RoundedRectangleBorder(
      side: BorderSide(color: borderColor, width: 1),
      borderRadius: BorderRadius.vertical(
        top: isFirst ? cardRadius : Radius.zero,
        bottom: isLast ? cardRadius : Radius.zero,
      ),
    );

    return Card(
      // Remove default Card margin to control spacing precisely with Padding
      margin: EdgeInsets.only(bottom: isLast ? 0 : 1.5), // Tiny space between cards
      color: backgroundColor,
      shape: cardShape,
      elevation: 1.0, // Subtle elevation
      shadowColor: Colors.black,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start, // Align items to the top
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0, top: 2.0), // Space icon from text
              child: Icon(icon, size: 30, color: iconColor),
            ),
            // Use Expanded to allow text to take remaining space and wrap
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, // Align text left
                children: [
                  Text(
                    title,
                    style: GoogleFonts.genos(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ), // Changed to TextStyle
                  ),
                  const SizedBox(height: 6),
                  Text( // Changed to TextStyle
                    description,
                    style: GoogleFonts.genos(
                      fontSize: 14, // Clearer description font size
                      color: textColor, // Slightly lighter description
                      height: 1.3 // Improve line spacing for readability
                    ),
                    // Removed maxLines and ellipsis to show full text,
                    // relies on ListView scrolling and Expanded to handle height. // Changed to TextStyle
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}