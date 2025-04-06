import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import FirebaseAuth if needed for accept action
import 'dart:developer'; // For logging

// --- Data Model ---
class Mission {
  final String missionId;
  final String userId; // User who created the mission
  final String category;
  final String locationDescription;
  final String description;
  final String? budget;
  final String? timeframe;
  final String? instructions;
  final String? status;
  final String? assignedUserId; // User who accepted the mission (if any)

  Mission({
    required this.missionId,
    required this.userId,
    required this.category,
    required this.locationDescription,
    required this.description,
    this.budget,
    this.timeframe,
    this.instructions,
    this.status,
    this.assignedUserId,
  });

  // Factory constructor to create a Mission from Firebase snapshot data
  factory Mission.fromSnapshot(Map<String, dynamic> data, String key) {
    return Mission(
      missionId: key, // Use the key from the snapshot as the missionId
      userId: data['userId'] ?? '',
      category: data['category'] ?? 'Unknown Category',
      locationDescription: data['locationDescription'] ?? 'No Location',
      description: data['description'] ?? 'No Description',
      budget: data['budget'],
      timeframe: data['timeframe'],
      instructions: data['instructions'],
      status: data['status'],
      assignedUserId: data['assignedUserId'],
    );
  }
}

// --- Screen Widget ---
class ChooseMissionScreen extends StatefulWidget {
  const ChooseMissionScreen({super.key});
  @override
  ChooseMissionScreenState createState() => ChooseMissionScreenState();
}

class ChooseMissionScreenState extends State<ChooseMissionScreen> {
  Mission? selectedMission;
  bool _isAccepting = false; // Loading indicator for accepting

  // --- Actions ---

  /// Attempts to accept the currently selected mission.
  Future<void> _acceptMission() async {
    if (selectedMission == null) return;

    final User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("You must be logged in to accept missions."), backgroundColor: Colors.red),
        );
      }
      return;
    }

    // Prevent accepting own mission (optional rule, implement if desired)
    if (selectedMission!.userId == currentUser.uid) {
       if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("You cannot accept your own mission."), backgroundColor: Colors.orangeAccent),
        );
      }
      return;
    }


    setState(() => _isAccepting = true);

    try {
      // Reference the specific mission in Firebase
      final missionRef = FirebaseDatabase.instance.ref('missions/${selectedMission!.missionId}');

      // Prepare the updates: change status and assign the current user
      final updates = {
        'status': 'accepted', // Or 'in_progress', 'assigned', etc. - match your desired flow
        'assignedUserId': currentUser.uid,
        // Optionally add an 'acceptedAt' timestamp
        // 'acceptedAt': ServerValue.timestamp,
      };

      // Perform the update
      await missionRef.update(updates);

      // Show success feedback
      if (mounted) {
        showDialog(
          context: context,
          barrierDismissible: false, // User must acknowledge
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Colors.grey[900],
              title: Text('Mission Accepted!', style: GoogleFonts.genos(fontWeight: FontWeight.bold, color: Colors.greenAccent)),
              content: Text('You have accepted: ${selectedMission!.description}', style: const TextStyle(color: Colors.grey)),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK', style: TextStyle(color: Colors.amberAccent)),
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                    setState(() {
                      selectedMission = null; // Clear selection after accepting
                    });
                    // Optionally navigate somewhere else, e.g., back or to 'My Accepted Missions'
                     // Navigator.of(context).pop(); // Go back from ChooseMissionScreen if needed
                  },
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      log("Error accepting mission: $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to accept mission: $e"), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isAccepting = false);
      }
    }
  }

  /// Clears the selected mission when declined.
  void _declineMission() {
    setState(() {
      selectedMission = null; // Just clear the selection
    });
  }

  // --- Build Method ---
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
        // Background Gradient
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
              // --- Header ---
              Padding(
                 padding: const EdgeInsets.only(bottom: 10.0),
                 child: Text(
                   'Available Missions (Status: New)', // More specific title
                   style: GoogleFonts.genos(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.grey[300]),
                 ),
              ),

              // --- Missions List ---
              Expanded(
                // Use FutureBuilder to fetch missions with status 'new'
                child: FutureBuilder<DataSnapshot>( // Specify the type for clarity
                  future: FirebaseDatabase.instance
                      .ref('missions')
                      .orderByChild('status') // Query by the 'status' field
                      .equalTo('new')        // Filter for missions where status is 'new'
                      .get(),                // Fetch data once
                  builder: (context, snapshot) {
                    // Loading state
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator(color: Colors.amberAccent));
                    }
                    // Error state
                    if (snapshot.hasError) {
                       log("Error loading missions: ${snapshot.error}"); // Log the actual error
                       return Center(child: Text('Error loading missions. Please check logs.', style: TextStyle(color: Colors.redAccent[100])));
                    }
                    // No data or empty data state
                    if (!snapshot.hasData || snapshot.data?.value == null) {
                      return Center(child: Text('No new missions available right now.', style: TextStyle(color: Colors.grey[500])));
                    }

                    // Data received, process it
                    final List<Mission> missions = [];
                    try {
                      // Cast the snapshot value to a Map
                       final missionsData = Map<String, dynamic>.from(snapshot.data!.value as Map);
                       missionsData.forEach((key, value) {
                          // Ensure value is a map before processing
                          if (value != null && value is Map) {
                             final missionDataMap = Map<String, dynamic>.from(value);
                             // Optional: Filter out missions created by the current user if needed here
                             // final currentUser = FirebaseAuth.instance.currentUser;
                             // if (currentUser == null || missionDataMap['userId'] != currentUser.uid) {
                                missions.add(Mission.fromSnapshot(missionDataMap, key));
                             // }
                          }
                       });
                    } catch (e) {
                       log("Error parsing missions data: $e");
                       return Center(child: Text('Error displaying missions.', style: TextStyle(color: Colors.redAccent[100])));
                    }


                    // Handle case where parsing resulted in an empty list (e.g., all missions were filtered out)
                     if (missions.isEmpty) {
                       return Center(child: Text('No new missions available right now.', style: TextStyle(color: Colors.grey[500])));
                     }


                    // Build the ListView
                    return ListView.builder(
                      itemCount: missions.length,
                      itemBuilder: (context, index) {
                        final mission = missions[index];
                        final bool isSelected = selectedMission?.missionId == mission.missionId;

                        // Use ListTile within a Card for better structure and tap feedback
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 0),
                          color: isSelected ? Colors.grey[700] : Colors.grey, // Highlight selected
                           shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: BorderSide(
                                color: isSelected ? Colors.amberAccent : Colors.grey[700]!,
                                width: isSelected ? 1.5 : 0.5,
                              )
                           ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                            // Leading icon based on category (optional)
                             // leading: Icon(_getIconForCategory(mission.category), color: Colors.amberAccent),
                            title: Text(
                                mission.description,
                                style: GoogleFonts.genos(
                                    color: isSelected ? Colors.white : Colors.grey[300],
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16
                                ),
                                maxLines: 2, // Allow description to wrap slightly
                                overflow: TextOverflow.ellipsis,
                             ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: Text(
                                '${mission.category} • ${mission.locationDescription}',
                                style: TextStyle(color: Colors.grey[500], fontSize: 12),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            onTap: () {
                              // Update the selected mission when tapped
                              setState(() {
                                // If tapping the already selected mission, deselect it
                                if (isSelected) {
                                   selectedMission = null;
                                } else {
                                   selectedMission = mission;
                                }
                              });
                            },
                            // Trailing chevron indicates tappability
                             trailing: Icon(Icons.chevron_right, color: Colors.grey[600]),
                          ),
                        );
                      },
                    );
                  },
                ),
              ), // End of Expanded List

              // --- Details Section (Conditional) ---
              // Use AnimatedSize and AnimatedOpacity for smoother transition
              AnimatedSize(
                 duration: const Duration(milliseconds: 300),
                 curve: Curves.easeInOut,
                 child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 300),
                    opacity: selectedMission != null ? 1.0 : 0.0,
                    child: selectedMission != null
                      ? Container(
                         margin: const EdgeInsets.only(top: 20.0),
                         padding: const EdgeInsets.all(16.0),
                         decoration: BoxDecoration(
                             color: Colors.black,
                             borderRadius: BorderRadius.circular(8),
                             border: Border.all(color: Colors.grey[700]!, width: 0.5)
                         ),
                         child: Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Text(
                                 'Selected Mission Details:',
                                 style: GoogleFonts.genos(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.grey[300]),
                               ),
                               const Divider(color: Colors.grey, height: 15),
                               _buildDetailRow(Icons.category_outlined, 'Category', selectedMission!.category),
                               _buildDetailRow(Icons.location_on_outlined, 'Location', selectedMission!.locationDescription),
                               _buildDetailRow(Icons.description_outlined, 'Description', selectedMission!.description),
                               if (selectedMission!.budget != null && selectedMission!.budget!.trim().isNotEmpty)
                                 _buildDetailRow(Icons.attach_money_outlined, 'Budget', selectedMission!.budget!),
                               if (selectedMission!.timeframe != null && selectedMission!.timeframe!.trim().isNotEmpty)
                                 _buildDetailRow(Icons.timer_outlined, 'Timeframe', selectedMission!.timeframe!),
                               if (selectedMission!.instructions != null && selectedMission!.instructions!.trim().isNotEmpty)
                                 _buildDetailRow(Icons.info_outline, 'Instructions', selectedMission!.instructions!),
                               // Optionally show status if needed (should be 'new' here)
                               // _buildDetailRow(Icons.flag_outlined, 'Status', selectedMission!.status ?? 'N/A'),
                               const SizedBox(height: 20),
                               // --- Accept/Decline Buttons ---
                               Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                 children: [
                                   // Accept Button
                                   ElevatedButton.icon(
                                     icon: _isAccepting
                                        ? Container(width: 16, height: 16, margin: const EdgeInsets.only(right: 4), child: const CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                                        : const Icon(Icons.check_circle_outline, size: 18),
                                     label: Text('Accept', style: GoogleFonts.genos(fontWeight: FontWeight.bold)),
                                     onPressed: _isAccepting ? null : _acceptMission, // Disable while accepting
                                     style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.green[700],
                                        foregroundColor: Colors.white,
                                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                     ),
                                   ),
                                   // Decline Button
                                   ElevatedButton.icon(
                                     icon: const Icon(Icons.cancel_outlined, size: 18),
                                     label: Text('Decline', style: GoogleFonts.genos(fontWeight: FontWeight.bold)),
                                     onPressed: _isAccepting ? null : _declineMission, // Disable while accepting
                                     style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red[700],
                                        foregroundColor: Colors.white,
                                         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                     ),
                                   ),
                                 ],
                               ),
                             ],
                           ),
                         )
                       : const SizedBox.shrink(), // Render nothing when no mission is selected
                 ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper widget to build detail rows consistently
  Widget _buildDetailRow(IconData icon, String label, String value) {
     return Padding(
       padding: const EdgeInsets.symmetric(vertical: 4.0),
       child: Row(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           Icon(icon, color: Colors.grey[400], size: 16),
           const SizedBox(width: 8),
           Text(
             '$label: ',
             style: GoogleFonts.genos(color: Colors.grey[400], fontWeight: FontWeight.w600),
           ),
           Expanded(
             child: Text(
               value,
               style: GoogleFonts.genos(color: Colors.grey[200]),
               softWrap: true,
             ),
           ),
         ],
       ),
     );
  }
}