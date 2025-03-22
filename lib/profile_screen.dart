// lib/profile_screen.dart
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

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
            const SizedBox(height: 16),
            Text('My Profile',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: primaryColor)),
            const SizedBox(height: 16),
            const Text('Name: Alice Kha', style: TextStyle(fontSize: 12)),
            const SizedBox(height: 8),
            const Text('Email: a.alice.kha@gmailk.com', style: TextStyle(fontSize: 12)),
            const SizedBox(height: 24),
            Text('My Missions', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: primaryColor)),

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
            TableCalendar(
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              focusedDay: DateTime.now(),
               calendarBuilders: CalendarBuilders(
                  markerBuilder: (context, date, events) {
                    if (date.year == 2024 && date.month == 8) {
                      if(date.day == 10){
                           return const Align(
                          alignment: Alignment.bottomCenter,
                          child: Text('M1'),
                          );
                      }else if (date.day == 15){
                           return const Align(
                          alignment: Alignment.bottomCenter,
                          child: Text('M2'),
                          );
                      } else if (date.day == 22){
                         return const Align(
                          alignment: Alignment.bottomCenter,
                          child: Text('M3'),
                          );
                      }
                    }
                  },
                ),
              eventLoader: (day){
                if (day.year == 2024 && day.month == 8) {
                  if(day.day == 10 || day.day == 15 || day.day == 22){
                    return ['Meeting'];
                  }
                }
                return [];
              },
            )
          ],
        ),
      ),
    );
  }
}
