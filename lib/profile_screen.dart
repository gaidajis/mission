// lib/profile_screen.dart
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = const Color(0xFF2962FF);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text(
          'My Profile',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text('My Profile',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: primaryColor)),
            const SizedBox(height: 16),
            const Text('Name: John Doe', style: TextStyle(fontSize: 12)),
            const SizedBox(height: 8),
            const Text('Email: john.doe@example.com', style: TextStyle(fontSize: 12)),
            const SizedBox(height: 24),
            Text('My Missions',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: primaryColor)),
            const SizedBox(height: 12),
            const Text('Given: 10', style: TextStyle(fontSize: 12)),
            const SizedBox(height: 8),
            const Text('Taken: 5', style: TextStyle(fontSize: 12)),
            const SizedBox(height: 8),
            const Text('Total: 15', style: TextStyle(fontSize: 12)),
            const SizedBox(height: 24),
            Text('Total Earnings',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: primaryColor)),
            const SizedBox(height: 12),
            const Text('\$500.00', style: TextStyle(fontSize: 14)),
            const SizedBox(height: 24),
            Text('My Calendar',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: primaryColor)),
            const SizedBox(height: 12),
            const Text('Calendar functionality here.', style: TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
