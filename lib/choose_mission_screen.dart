// lib/choose_mission_screen.dart
import 'package:flutter/material.dart';

class ChooseMissionScreen extends StatelessWidget {
  const ChooseMissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = const Color(0xFF2962FF);
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Choose Your Mission',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: primaryColor)),
          const SizedBox(height: 16),
          const Text(
            'Browse available missions.',
            style: TextStyle(fontSize: 12),
          ),
          const SizedBox(height: 10),
          const Text(
            'Available Missions:',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text('- Pick up groceries (Downtown, \$20)', style: TextStyle(fontSize: 12)),
          const SizedBox(height: 8),
          const Text('- Walk dog (Parkside, \$15)', style: TextStyle(fontSize: 12)),
          const SizedBox(height: 8),
          const Text('- Assemble furniture (Suburbs, \$30)', style: TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
