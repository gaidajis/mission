// lib/send_on_mission_screen.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'mission_details_screen.dart'; // Ensure this import is correct based on your file structure

class SendOnMissionScreen extends StatelessWidget {
  const SendOnMissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: const Text(
          'Send on Mission',
          style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
        ),
      ),
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
              Text('Send on Mission',
                  style: GoogleFonts.genos(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.grey)),
              const SizedBox(height: 16),
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
                  ].map((category) {
                    return Card(
                      elevation: 3,
                      color: Colors.grey[850],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: InkWell(
                        onTap: () {
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
                            style: GoogleFonts.genos(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.grey),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}