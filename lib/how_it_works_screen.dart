// lib/how_it_works_screen.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'send_on_mission_screen.dart';

class HowItWorksScreen extends StatelessWidget {
  const HowItWorksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = const Color(0xFF2962FF);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'How it works',
          style: GoogleFonts.genos(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withAlpha(76),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                 Text(
                    'The mission is simple!',   
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            _buildStepCard(
              context,
              'Post a Mission',
              'Post a mission with price and description.',
              Icons.add_task,
            ),
            const SizedBox(height: 12),
            _buildStepCard(
              context,
              'Get Applications',
              'Verified users apply to your mission.',
              Icons.assignment_turned_in,
            ),
            const SizedBox(height: 12),
            _buildStepCard(
              context,
              'Choose a Helper',
              'Review and choose the best person.',
              Icons.person_search,
            ),
            const SizedBox(height: 12),
            _buildStepCard(
              context,
              'Mission Completed',
              'Approve completion, helper gets paid.',
              Icons.check_circle_outline,
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                   Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SendOnMissionScreen()),
                    );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,  
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  textStyle: const TextStyle(fontSize: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Get Started Now', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepCard(BuildContext context, String title, String description, IconData icon) {
    final Color primaryColor = const Color(0xFF2962FF);
    return Card(
      elevation: 2,
      color: Colors.grey[900],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(icon, size: 40, color: primaryColor),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: GoogleFonts.genos(fontSize: 14, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text(description, style: GoogleFonts.genos(fontSize: 12, color: Colors.white70)),
               ],
           ),
            ),
          ],
        ),
      ),
    );
  }
}
