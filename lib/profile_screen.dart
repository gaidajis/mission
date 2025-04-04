// lib/profile_screen.dart
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../auth_service.dart'; // Import your AuthService

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthService authService = AuthService(); // Create an instance of AuthService

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: const Text(
          'My Profile',
          style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await authService.signOut();
              // The AuthWrapper will automatically detect the user state change
              // and navigate back to the LoginScreen.
            },
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.black87, Colors.black],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 16),
              const Text('My Profile',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.grey)),
              const SizedBox(height: 16),
              const Text('Name: Alice Kha', style: TextStyle(fontSize: 16, color: Colors.grey)),
              const SizedBox(height: 8),
              const Text('Email: a.alice.kha@gmailk.com', style: TextStyle(fontSize: 16, color: Colors.grey)),
              const SizedBox(height: 24),
              const Text('My Missions', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.grey)),
              const SizedBox(height: 12),
              const Text('Given: 10', style: TextStyle(fontSize: 16, color: Colors.grey)),
              const SizedBox(height: 8),
              const Text('Taken: 5', style: TextStyle(fontSize: 16, color: Colors.grey)),
              const SizedBox(height: 8),
              const Text('Total: 15', style: TextStyle(fontSize: 16, color: Colors.grey)),
              const SizedBox(height: 24),
              const Text('Total Earnings',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.grey)),
              const SizedBox(height: 12),
              const Text('\$500.00', style: TextStyle(fontSize: 18, color: Colors.grey)),
              const SizedBox(height: 24),
              const Text('My Calendar',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.grey)),
              const SizedBox(height: 12),
              TableCalendar(
                firstDay: DateTime.utc(2010, 10, 16),
                lastDay: DateTime.utc(2030, 3, 14),
                focusedDay: DateTime.now(),
                calendarStyle: CalendarStyle(
                  defaultTextStyle: const TextStyle(color: Colors.grey),
                  weekendTextStyle: const TextStyle(color: Colors.grey),
                  outsideTextStyle: TextStyle(color: Colors.grey.shade600),
                  todayTextStyle: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                  todayDecoration: BoxDecoration(
                    color: Colors.blueGrey,
                    shape: BoxShape.circle,
                  ),
                  selectedTextStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  selectedDecoration: const BoxDecoration(
                    color: Colors.blueGrey,
                    shape: BoxShape.circle,
                  ),
                ),
                headerStyle: HeaderStyle(
                  titleTextStyle: const TextStyle(color: Colors.grey, fontSize: 18, fontWeight: FontWeight.bold),
                  formatButtonTextStyle: const TextStyle(color: Colors.grey),
                  leftChevronIcon: const Icon(Icons.chevron_left, color: Colors.grey),
                  rightChevronIcon: const Icon(Icons.chevron_right, color: Colors.grey),
                ),
                calendarBuilders: CalendarBuilders(
                  markerBuilder: (context, date, events) {
                    if (date.year == 2024 && date.month == 8) {
                      if (date.day == 10) {
                        return const Align(
                          alignment: Alignment.bottomCenter,
                          child: Text('M1', style: TextStyle(color: Colors.white)),
                        );
                      } else if (date.day == 15) {
                        return const Align(
                          alignment: Alignment.bottomCenter,
                          child: Text('M2', style: TextStyle(color: Colors.white)),
                        );
                      } else if (date.day == 22) {
                        return const Align(
                          alignment: Alignment.bottomCenter,
                          child: Text('M3', style: TextStyle(color: Colors.white)),
                        );
                      }
                    }
                    return null;
                  },
                ),
                eventLoader: (day) {
                  if (day.year == 2024 && day.month == 8) {
                    if (day.day == 10 || day.day == 15 || day.day == 22) {
                      return ['Meeting'];
                    }
                  }
                  return [];
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}