import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore
import 'mission_details_screen.dart';

class SendOnMissionScreen extends StatelessWidget {
  const SendOnMissionScreen({super.key});

  Future<void> _sendMissionToFirebase(
    String category,
    BuildContext context,
  ) async {
    try {
      await FirebaseFirestore.instance.collection('missions').add({
        'category': category,
        'timestamp': FieldValue.serverTimestamp(),
        // Add any other relevant data you want to store (location, user info, etc.)
      });
      // Optionally, show a success message or navigate to another screen
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Mission "$category" posted successfully!')),
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MissionDetailsScreen(category: category),
        ),
      );
    } catch (e) {
      // Handle errors (e.g., show an error message)
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to post mission: $e')));
      print('Error sending mission: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black87),
      body: Container(
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Send on Mission',
                style: GoogleFonts.genos(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio: 2 / 1,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  children:
                      <String>[
                        'Errands',
                        'Transportation Delivery',
                        'Food',
                        'SocialInteraction',
                        'Animals',
                        'SpecialMissions',
                        'Repairs',
                      ].map((category) {
                        return Card(
                          elevation: 3,
                          color: Colors.grey[850],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: InkWell(
                            onTap: () {
                              _sendMissionToFirebase(category, context);
                            },
                            child: Center(
                              child: Text(
                                category,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.genos(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
