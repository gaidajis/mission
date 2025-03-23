// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = const Color(0xFF424242);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          'Home',
          style: GoogleFonts.genos(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),
        
        ),
        
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
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
                    'About The Mission',
                    style: GoogleFonts.genos(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),                   
                    
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "The Mission is a platform that allows you to give tasks in minutes. It connects people from all over the world. It provides work for people quickly. It's a better guarantee for users than classified ads websites.",
                    style: TextStyle(fontSize: 18, color: Colors.white70),
                  ),
                  const SizedBox(height: 16),
                Row(
                 children: <Widget>[
                    Icon(Icons.rocket_launch, color: Colors.white), 
                    SizedBox(width: 8), 
                    Text(
                     'Imagine the Possibilities',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Colors.white),
                    ),
                  ],
                ),
                  const SizedBox(height: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 4.0),
                        child: Text("• Need help with tasks?", style: TextStyle(fontSize: 18, color: Colors.white70)),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 4.0),
                        child: Text("• Want personalized services?", style: TextStyle(fontSize: 18, color: Colors.white70)),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 4.0),
                        child: Text("• Need help with pets?", style: TextStyle(fontSize: 18, color: Colors.white70)),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 4.0),
                        child: Text("• Want verified profiles?", style: TextStyle(fontSize: 14, color: Colors.white70)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () {},
                    
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white, 
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [const Text('Explore Missions', style: TextStyle(color: Colors.black),), Icon(Icons.explore, color: Colors.black)],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
