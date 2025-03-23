import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class Mission {
  final String name;
  final String location;
  final double reward;

  Mission({required this.name, required this.location, required this.reward});
}

class ChooseMissionScreen extends StatefulWidget {
  const ChooseMissionScreen({super.key});
  @override
  ChooseMissionScreenState createState() => ChooseMissionScreenState();
}

class ChooseMissionScreenState extends State<ChooseMissionScreen> {
  final List<Mission> missions = [
    Mission(name: 'Pick up groceries', location: 'Downtown', reward: 20.0),
    Mission(name: 'Walk dog', location: 'Parkside', reward: 15.0),
    Mission(name: 'Assemble furniture', location: 'Suburbs', reward: 30.0),
  ];

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
            title: Text('Mission Accepted', style: GoogleFonts.genos(fontWeight: FontWeight.bold)),
            content: Text('You have accepted the mission: ${selectedMission!.name}'),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
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
        title: Text('Choose Your Mission', style: GoogleFonts.genos(fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(



              'Available Missions:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: missions.length,
                itemBuilder: (context, index) {
                  final mission = missions[index];
                  return ListTile(
                    title: Text(mission.name, style: GoogleFonts.genos()),
                    subtitle: Text('${mission.location}, \$${mission.reward.toStringAsFixed(0)}',style: GoogleFonts.genos()),
                    onTap: () => _selectMission(mission),
                    selected: selectedMission == mission,
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            if (selectedMission != null) ...[
              Text(                
                'Mission Details:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text('Name: ${selectedMission!.name}', style: GoogleFonts.genos()),
              Text('Location: ${selectedMission!.location}'),
              Text('Reward: \$${selectedMission!.reward.toStringAsFixed(0)}'),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: _acceptMission,
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green,),
                    child: Text('Accept', style: GoogleFonts.genos()),
                  ),
                  ElevatedButton(
                    onPressed: _declineMission,
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red,),
                    child: Text('Decline', style: GoogleFonts.genos()),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}