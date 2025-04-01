import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'send_on_mission_screen.dart';

class HowItWorksScreen extends StatelessWidget {
  const HowItWorksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color iconColor = Colors.grey;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text(
          'How it works',
          style: GoogleFonts.genos(color: Colors.grey),
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
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black87, Colors.black], // Consistent dark gradient
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const SizedBox(height: 24),
            Center(
              child: Text(
                'The mission is global!',
                style: GoogleFonts.genos(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey, // Silver-like
                ),
              ),
            ),
            const SizedBox(height: 32),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 1.5,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                physics: const NeverScrollableScrollPhysics(), // To disable grid scrolling
                children: <Widget>[
                  _buildStepCard(
                    context,
                    'Post a Mission',
                    'Post a mission with price and description.',
                    Icons.public,
                    iconColor,
                  ),
                  _buildStepCard(
                    context,
                    'Get Applications',
                    'Verified users apply to your mission.',
                    Icons.assignment_turned_in,
                    iconColor,
                  ),
                  _buildStepCard(
                    context,
                    'Choose a Helper',
                    'Review and choose the best person.',
                    Icons.person_search,
                    iconColor,
                  ),
                  _buildStepCard(
                    context,
                    'Mission Completed',
                    'Approve completion, helper gets paid.',
                    Icons.check_circle_outline,
                    iconColor,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SendOnMissionScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black54, // Dark button
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  textStyle: const TextStyle(fontSize: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0), // Sharp edges
                  ),
                  elevation: 5,
                  shadowColor: Colors.grey,
                  foregroundColor: Colors.grey, // Silver-like text
                ),
                child: const Text('Initiate Mission Sequence',
                    style: TextStyle(color: Colors.grey)), // Silver-like text
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepCard(BuildContext context, String title, String description,
      IconData icon, Color iconColor) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[900]?.withValues(alpha: 0.8), // Corrected line
        borderRadius: BorderRadius.circular(0), // Sharp edges
        border: Border.all(color: Colors.grey[800]!, width: 1), // Subtle border
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.6),
            spreadRadius: 0.5,
            blurRadius: 2,
            offset: const Offset(1, 1),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon, size: 32, color: iconColor),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: GoogleFonts.genos(
                  fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey), // Silver-like
            ),
            const SizedBox(height: 6),
            Text(
              description,
              textAlign: TextAlign.center,
              style: GoogleFonts.genos(fontSize: 12, color: Colors.grey), // Silver-like
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ],
        ),
      ),
    );
  }
}