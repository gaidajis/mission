import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth
import 'mission_details_screen.dart';

class SendOnMissionScreen extends StatefulWidget {
  const SendOnMissionScreen({super.key});

  @override
  State<SendOnMissionScreen> createState() => _SendOnMissionScreenState();
}

class _SendOnMissionScreenState extends State<SendOnMissionScreen> {
  Future<void> _sendMissionToFirebase(
    String category,
    BuildContext context, // Context is needed for ScaffoldMessenger and Navigator
  ) async {
    try {
      final User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        // Handle the case where the user is not logged in
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('You must be logged in to post a mission.')),
        );
        return;
      }

      // Add the mission data to the 'missions' collection
      await FirebaseFirestore.instance.collection('missions').add({
        'category': category,
        'status': 'new', // Example: Add an initial status
        'timestamp': FieldValue.serverTimestamp(), // Use server time
        'userId': user.uid, // Add the user ID
        // Add any other relevant data you want to save
      });

      // Check if the widget is still mounted before showing SnackBar or navigating
      if (!context.mounted) return;

      // Show success dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.grey[900],
            title: Text('Mission Sent!', style: GoogleFonts.genos(fontWeight: FontWeight.bold, color: Colors.grey)),
            content: Text('Your mission "$category" has been sent.', style: const TextStyle(color: Colors.grey)),
            actions: <Widget>[
              TextButton(
                child: const Text('OK', style: TextStyle(color: Colors.grey)),
                onPressed: () {
                  Navigator.of(context).pop();
                  // Navigate to the details screen after successful posting
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MissionDetailsScreen(category: category),
                    ),
                  );
                },
              ),
            ],
          );
        },
      );
    } catch (e) {
      // Check if the widget is still mounted before showing the error SnackBar
      if (!context.mounted) return;

      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to post mission: $e')),
      );
      // Optional: Log the error for debugging
      // log('Error posting mission: $e');
      // print('Error posting mission: $e'); // Or use print for simple debugging
    }
  }

  @override
  Widget build(BuildContext context) {
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch, // Stretch children horizontally
          children: <Widget>[
            Text(
              'Send on Mission', // Title for the section
              textAlign: TextAlign.center, // Center the title
              style: GoogleFonts.genos(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.grey[300], // Slightly lighter grey for title
              ),
            ),
            const SizedBox(height: 20), // Increased spacing
            Expanded( // Make the GridView fill the remaining space
              child: GridView.count(
                crossAxisCount: 2, // Number of columns
                childAspectRatio: 2.5 / 1, // Adjust aspect ratio (width / height)
                crossAxisSpacing: 12, // Spacing between columns
                mainAxisSpacing: 12, // Spacing between rows
                children: <String>[ // List of mission categories
                  'Errands',
                  'Transportation', // Shortened for better fit
                  'Delivery',     // Separated from Transportation
                  'Food',
                  'Social',       // Shortened
                  'Animals',
                  'Repairs',
                  'Special',     // Shortened
                ].map((category) {
                  // Create a Card for each category
                  return Card(
                    elevation: 4, // Slightly increased elevation
                    color: Colors.grey, // Darker, slightly transparent card
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // Slightly more rounded
                      side: BorderSide(color: Colors.grey[700]!, width: 0.5), // Subtle border
                    ),
                    clipBehavior: Clip.antiAlias, // Ensure InkWell ripple stays within bounds
                    child: InkWell( // Make the card tappable
                      onTap: () {
                        _sendMissionToFirebase(category, context);
                      },
                      splashColor: Colors.amber.withAlpha(50), // Customize ripple color
                      child: Center( // Center the text within the card
                        child: Padding( // Add padding inside the card
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            category,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.genos(
                              fontSize: 16, // Adjust as needed
                              fontWeight: FontWeight.w600, // Slightly bolder
                              color: Colors.grey[300], // Lighter text color
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(), // Convert the mapped iterable to a List
              ),
            ),
          ],
        ),
      ),
    );
  }
}