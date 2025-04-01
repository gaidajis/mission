// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text(
          'Home',
          style: GoogleFonts.genos(
              color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 24),
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
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[900]?.withValues(alpha: 0.8),
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(                      
                      color: Colors.black.withValues(alpha: 0.6),
                      spreadRadius: 2,
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'About The Mission',
                      style: GoogleFonts.genos(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey, // Silver-like
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "The Mission is a platform that allows you to give tasks in minutes. It connects people from all over the world. It provides work for people quickly. It's a better guarantee for users than classified ads websites.",
                      style: TextStyle(fontSize: 18, color: Colors.grey), // Silver-like
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: <Widget>[
                        const Icon(Icons.rocket_launch, color: Colors.grey), // Silver-like
                        const SizedBox(width: 8),
                        const Text(
                          'Imagine the Possibilities',
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Colors.grey), // Silver-like
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const <Widget>[
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 4.0),
                          child: Text("• Need help with tasks?", style: TextStyle(fontSize: 18, color: Colors.grey)), // Silver-like
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 4.0),
                          child: Text("• Want personalized services?", style: TextStyle(fontSize: 18, color: Colors.grey)), // Silver-like
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 4.0),
                          child: Text("• Need help with pets?", style: TextStyle(fontSize: 18, color: Colors.grey)), // Silver-like
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 4.0),
                          child: Text("• Want verified profiles?", style: TextStyle(fontSize: 14, color: Colors.grey)), // Silver-like
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black54,
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        foregroundColor: Colors.grey, // Silver-like text
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Explore Missions', style: TextStyle(color: Colors.grey)), // Silver-like
                          Icon(Icons.explore, color: Colors.grey), // Silver-like
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}