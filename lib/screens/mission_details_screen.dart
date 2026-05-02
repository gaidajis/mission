// ----- In MissionDetailsScreen.dart -----

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart'; // Needed for fetching

class MissionDetailsScreen extends StatelessWidget {
  // BEFORE:
  // final String category;
  // const MissionDetailsScreen({super.key, required this.category});

  // AFTER:
  final String missionId;
  const MissionDetailsScreen({super.key, required this.missionId}); // Now requires missionId

  @override
  Widget build(BuildContext context) {
    // You'll now use 'missionId' to fetch the specific mission data
    // For example, using a FutureBuilder:

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mission Details'), // Generic title initially
      ),
      body: FutureBuilder<DataSnapshot>(
        // Fetch data using the missionId
        future: FirebaseDatabase.instance.ref('missions').child(missionId).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError || !snapshot.hasData || snapshot.data?.value == null) {
            return Center(child: Text('Error loading mission details: ${snapshot.error ?? 'Not found'}'));
          }

          // Decode the data
          // Make sure the data structure matches what you save
          final missionData = Map<String, dynamic>.from(snapshot.data!.value as Map);
          final category = missionData['category'] ?? 'N/A'; // Get category from fetched data

          // Now build your details UI using missionData
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Category: $category', style: Theme.of(context).textTheme.headlineSmall),
                Text('Description: ${missionData['description'] ?? 'N/A'}'),
                Text('Location: ${missionData['locationDescription'] ?? 'N/A'}'),
                Text('Budget: ${missionData['budget'] ?? 'N/A'}'),
                // ... display other details ...
              ],
            ),
          );
        },
      ),
    );
  }
}