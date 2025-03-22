// lib/contact_screen.dart
import 'package:flutter/material.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = const Color(0xFF2962FF);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Contact Us',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: primaryColor)),
          const SizedBox(height: 16),
          const Text(
            'Reach out to us through the following methods:',
            style: TextStyle(fontSize: 12),
          ),
          const SizedBox(height: 16),
          const Text('Email:', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text('contact@themissionapp.com', style: TextStyle(fontSize: 12)),
          const SizedBox(height: 16),
          const Text('Phone:', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text('+1 555-123-4567', style: TextStyle(fontSize: 12)),
          const SizedBox(height: 16),
          const Text('Address:', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text('123 Main Street, Anytown, USA', style: TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
