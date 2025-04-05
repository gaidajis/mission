import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_database/firebase_database.dart';

class Mission {
  final String missionId;
  final String userId;
  final String category;
  final String locationDescription;
  final String description;
  final String? budget;
  final String? timeframe;
  final String? instructions;
  final String? status; // Added status field

  Mission({
    required this.missionId,
    required this.userId,
    required this.category,
    required this.locationDescription,
    required this.description,
    this.budget,
    this.timeframe,
    this.instructions,
    this.status, // Initialize status
  });

  factory Mission.fromSnapshot(Map<String, dynamic> data, String key) {
    return Mission(
      missionId: key,
      userId: data['userId'] ?? '',
      category: data['category'] ?? '',
      locationDescription: data['locationDescription'] ?? '',
      description: data['description'] ?? '',
      budget: data['budget'],
      timeframe: data['timeframe'],
      instructions: data['instructions'],
      status: data['status'], // Retrieve status from data
    );
  }
}

class ChooseMissionScreen extends StatefulWidget {
  const ChooseMissionScreen({super.key});
  @override
  ChooseMissionScreenState createState() => ChooseMissionScreenState();
}

class ChooseMissionScreenState extends State<ChooseMissionScreen> {
  Mission? selectedMission;

  void _selectMission(Mission mission) {
    setState(() {
      selectedMission = mission;
    });
  }

  void _acceptMission() {
    if (selectedMission != null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.grey[900],
            title: Text('Mission Accepted', style: GoogleFonts.genos(fontWeight: FontWeight.bold, color: Colors.grey)),
            content: Text('You have accepted the mission: ${selectedMission!.category} - ${selectedMission!.description}', style: const TextStyle(color: Colors.grey)),
            actions: <Widget>[
              TextButton(
                child: const Text('OK', style: TextStyle(color: Colors.grey)),
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                    selectedMission = null;
                  });
                },
              ),
            ],
          );
        },
      );
    }
  }

  void _declineMission() {
    setState(() {
      selectedMission = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text('Choose Your Mission', style: GoogleFonts.genos(fontWeight: FontWeight.bold, color: Colors.grey)),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.black87, Colors.black],
              begin: Alignment.topLeft, end: Alignment.bottomRight,
            ),
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.grey),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Available Missions:',
                style: GoogleFonts.genos(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.grey),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: FutureBuilder(
                  future: FirebaseDatabase.instance
                      .ref('missions')
                      .orderByChild('status')
                      .equalTo('new')
                      .get(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError || !snapshot.hasData || snapshot.data?.value == null) {
                      return Center(child: Text('Error loading missions: ${snapshot.error ?? 'No data found'}', style: const TextStyle(color: Colors.white)));
                    }

                    final missionsData = snapshot.data!.value as Map<dynamic, dynamic>;
                    final List<Mission> missions = [];
                    missionsData.forEach((key, value) {
                      if (value != null && value is Map<String, dynamic>) {
                        missions.add(Mission.fromSnapshot(Map<String, dynamic>.from(value), key));
                      }
                    });

                    return ListView.builder(
                      itemCount: missions.length,
                      itemBuilder: (context, index) {
                        final mission = missions[index];
                        return ListTile(
                          tileColor: selectedMission?.missionId == mission.missionId ? Colors.grey[800] : null,
                          selectedTileColor: Colors.grey[800],
                          title: Text(mission.category, style: GoogleFonts.genos(color: Colors.grey)),
                          subtitle: Text('${mission.locationDescription}, ${mission.description}',
                              style: GoogleFonts.genos(color: Colors.grey.shade600)),
                          onTap: () => _selectMission(mission),
                          selected: selectedMission?.missionId == mission.missionId,
                        );
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              if (selectedMission != null) ...[
                Text(
                  'Mission Details:',
                  style: GoogleFonts.genos(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.grey),
                ),
                const SizedBox(height: 10),
                Text('Category: ${selectedMission!.category}', style: GoogleFonts.genos(color: Colors.grey)),
                Text('Location: ${selectedMission!.locationDescription}', style: GoogleFonts.genos(color: Colors.grey)),
                Text('Description: ${selectedMission!.description}', style: GoogleFonts.genos(color: Colors.grey)),
                if (selectedMission!.budget != null && selectedMission!.budget!.isNotEmpty)
                  Text('Budget: ${selectedMission!.budget}', style: GoogleFonts.genos(color: Colors.grey)),
                if (selectedMission!.timeframe != null && selectedMission!.timeframe!.isNotEmpty)
                  Text('Timeframe: ${selectedMission!.timeframe}', style: GoogleFonts.genos(color: Colors.grey)),
                if (selectedMission!.instructions != null && selectedMission!.instructions!.isNotEmpty)
                  Text('Instructions: ${selectedMission!.instructions}', style: GoogleFonts.genos(color: Colors.grey)),
                if (selectedMission!.status != null && selectedMission!.status!.isNotEmpty) // Display status if needed
                  Text('Status: ${selectedMission!.status}', style: GoogleFonts.genos(color: Colors.grey)),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: _acceptMission,
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.green[800], foregroundColor: Colors.grey),
                      child: Text('Accept', style: GoogleFonts.genos()),
                    ),
                    ElevatedButton(
                      onPressed: _declineMission,
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.red[800], foregroundColor: Colors.grey),
                      child: Text('Decline', style: GoogleFonts.genos()),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}