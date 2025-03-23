// lib/contact_screen.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
          Text('Contact Us', style: GoogleFonts.genos(fontSize: 18, fontWeight: FontWeight.bold, color: primaryColor)),
           const SizedBox(height: 16),
           Text(
            'Reach out to us through the following methods:',
            style: GoogleFonts.genos(fontSize: 12),
           ),
           const SizedBox(height: 16),
           Text('Email:', style: GoogleFonts.genos(fontSize: 14, fontWeight: FontWeight.bold)),
           const SizedBox(height: 8),
           Text('contact@themissionapp.com', style: GoogleFonts.genos(fontSize: 12)),
           const SizedBox(height: 16),
           Text('Phone:', style: GoogleFonts.genos(fontSize: 14, fontWeight: FontWeight.bold)),
           const SizedBox(height: 8),
           Text('+1 555-123-4567', style: GoogleFonts.genos(fontSize: 12)),
           const SizedBox(height: 16),
           Text('Address:', style: GoogleFonts.genos(fontSize: 14, fontWeight: FontWeight.bold)),
           const SizedBox(height: 8),
           Text('123 Main Street, Anytown, USA', style: GoogleFonts.genos(fontSize: 12)),
        ],
      ),
    );
  }
}
