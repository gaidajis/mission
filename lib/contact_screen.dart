import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Subtle background with a very faint pattern (optional, can be removed)
          Positioned.fill(
            child: Opacity(
              opacity: 0.05,
              child: Image.asset(
                'assets/swiss_pattern.png', // Replace with your subtle pattern image if you have one
                repeat: ImageRepeat.repeat,
                color: Colors.white,
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const Icon(Icons.flag_rounded, size: 60, color: Colors.redAccent), // Using a flag icon subtly
                  const SizedBox(height: 16),
                  Text('Get In Touch',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat( // A clean, modern font
                          fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white)),
                  const SizedBox(height: 32),
                  Card(
                    elevation: 8,
                    color: Colors.grey.shade900.withOpacity(0.8),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.email_rounded, color: Colors.redAccent),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Email Us',
                                        style: GoogleFonts.lato( // Another clean font
                                            fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                                    const SizedBox(height: 8),
                                    InkWell(
                                      onTap: () => _launchUrl('mailto:contact@missions.ch'),
                                      child: Text('contact@missions.ch',
                                          style: GoogleFonts.lato(fontSize: 16, color: Colors.grey.shade300)),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          Row(
                            children: [
                              const Icon(Icons.phone_android_rounded, color: Colors.white),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Call Us',
                                        style: GoogleFonts.lato(
                                            fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                                    const SizedBox(height: 8),
                                    Text('+41 79 732 65 66',
                                        style: GoogleFonts.lato(fontSize: 16, color: Colors.grey.shade300)),
                                    Text('+41 79 889 61 28',
                                        style: GoogleFonts.lato(fontSize: 16, color: Colors.grey.shade300)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          Row(
                            children: [
                              const Icon(Icons.location_on_rounded, color: Colors.redAccent),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Visit Us',
                                        style: GoogleFonts.lato(
                                            fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                                    const SizedBox(height: 8),
                                    Text('Grandvaux, Switzerland',
                                        style: GoogleFonts.lato(fontSize: 16, color: Colors.grey.shade300)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 48),
                  Text('We are here to help!',
                      style: GoogleFonts.lato(fontSize: 20, color: Colors.grey.shade400)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}