import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:country_code_picker/country_code_picker.dart';
import '../auth_service.dart'; // Assuming path is correct
import 'mission_details_screen.dart'; // Ensure this screen exists and accepts missionId
import 'dart:developer'; // For logging

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> with SingleTickerProviderStateMixin {
  // --- State Variables ---
  late TabController _tabController;
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  User? _currentUser;
  bool _isLoadingProfile = true; // Loading indicator for profile data
  bool _isSavingProfile = false; // Loading indicator for saving profile

  // Profile Data Controllers / Variables
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  String _email = ''; // Email usually comes from Auth, not DB profile
  String _countryCode = '+41'; // Default Switzerland

  // Firebase References
  DatabaseReference? _userProfileRef;
  final DatabaseReference _missionsRef = FirebaseDatabase.instance.ref('missions');

  // --- Lifecycle Methods ---
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this); // 3 Tabs: Profile, Posted, Accepted
    _currentUser = FirebaseAuth.instance.currentUser;

    if (_currentUser == null) {
      // Handle case where user is somehow null (shouldn't happen if screen is protected)
      log("Error: Current user is null in ProfileScreen initState.");
      // Potentially navigate back to login or show an error message
      WidgetsBinding.instance.addPostFrameCallback((_) {
         if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                   const SnackBar(content: Text("User not logged in!"), backgroundColor: Colors.red));
              // Consider Navigator.pop(context); or redirecting
         }
      });
    } else {
      _userProfileRef = FirebaseDatabase.instance.ref('users/${_currentUser!.uid}/profile');
      _email = _currentUser!.email ?? 'No Email'; // Get email from Auth
      _loadUserProfile();
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  // --- Data Handling Methods ---

  /// Loads user profile data from Firebase RTDB.
  Future<void> _loadUserProfile() async {
    if (_userProfileRef == null) return;
    setState(() => _isLoadingProfile = true);
    try {
      final snapshot = await _userProfileRef!.get();
      if (mounted && snapshot.exists && snapshot.value != null) {
        final data = Map<String, dynamic>.from(snapshot.value as Map);
        setState(() {
          _firstNameController.text = data['firstName'] ?? '';
          _lastNameController.text = data['lastName'] ?? '';
          _countryCode = data['countryCode'] ?? '+41'; // Default to CH if not set
           // Handle phone number potentially stored with country code
          String fullPhone = data['phoneNumber'] ?? '';
          if (fullPhone.startsWith(_countryCode)) {
             // Extract number part if stored with code
             _phoneNumberController.text = fullPhone.substring(_countryCode.length).trim();
          } else {
             _phoneNumberController.text = fullPhone;
          }
        });
      } else if (mounted) {
         log("Profile data not found for user ${_currentUser?.uid}. Creating default profile node might be needed.");
         // Set default values or indicate profile needs setup
         _firstNameController.text = '';
         _lastNameController.text = '';
         _phoneNumberController.text = '';
      }
    } catch (e) {
      log("Error loading profile: $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error loading profile: $e"), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoadingProfile = false);
      }
    }
  }

  /// Saves updated profile data to Firebase RTDB.
  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) {
      return; // Don't save if form is invalid
    }
    if (_userProfileRef == null) {
       ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Error: User reference not available."), backgroundColor: Colors.red),
       );
       return;
    }

    setState(() => _isSavingProfile = true);

    try {
      await _userProfileRef!.update({
        'firstName': _firstNameController.text.trim(),
        'lastName': _lastNameController.text.trim(),
        'phoneNumber': _phoneNumberController.text.trim(), // Store just the number
        'countryCode': _countryCode, // Store country code separately
         // Note: Email is usually managed via FirebaseAuth, not updated here.
         // If you need to update email, use _currentUser.updateEmail()
         // which requires re-authentication typically.
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile updated successfully!'), backgroundColor: Colors.green),
        );
      }
    } catch (e) {
      log("Error saving profile: $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error saving profile: $e"), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSavingProfile = false);
      }
    }
  }

  // --- UI Building Methods ---

  /// Builds the content for the "Edit Profile" tab.
  Widget _buildEditProfileTab() {
    if (_isLoadingProfile) {
      return const Center(child: CircularProgressIndicator(color: Colors.amberAccent));
    }

    // Style definitions
    const inputLabelStyle = TextStyle(color: Colors.grey);
    const inputTextStyle = TextStyle(color: Colors.white);
    const focusedBorder = UnderlineInputBorder(borderSide: BorderSide(color: Colors.amberAccent));
    const enabledBorder = UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey));

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
             const SizedBox(height: 16),
             const Center(
               child: Icon(Icons.person_pin, size: 80, color: Colors.grey),
             ),
             const SizedBox(height: 24),

            // First Name
            TextFormField(
              controller: _firstNameController,
              decoration: const InputDecoration(
                labelText: 'First Name *',
                labelStyle: inputLabelStyle,
                enabledBorder: enabledBorder,
                focusedBorder: focusedBorder,
                prefixIcon: Icon(Icons.person_outline, color: Colors.grey, size: 20),
              ),
              style: inputTextStyle,
              validator: (value) => (value == null || value.trim().isEmpty) ? 'Please enter your first name' : null,
            ),
            const SizedBox(height: 16),

            // Last Name
            TextFormField(
              controller: _lastNameController,
              decoration: const InputDecoration(
                labelText: 'Last Name *',
                labelStyle: inputLabelStyle,
                enabledBorder: enabledBorder,
                focusedBorder: focusedBorder,
                prefixIcon: Icon(Icons.person_outline, color: Colors.grey, size: 20),
              ),
              style: inputTextStyle,
              validator: (value) => (value == null || value.trim().isEmpty) ? 'Please enter your last name' : null,
            ),
            const SizedBox(height: 16),

            // Email (Read-only)
            TextFormField(
              initialValue: _email, // Set initial value, but make read-only
              readOnly: true, // User cannot edit email here
              decoration: const InputDecoration(
                labelText: 'Email',
                labelStyle: inputLabelStyle,
                enabledBorder: enabledBorder, // Use same border style
                focusedBorder: enabledBorder, // No focus highlight for read-only
                prefixIcon: Icon(Icons.email_outlined, color: Colors.grey, size: 20),
              ),
              style: TextStyle(color: Colors.grey[500]), // Dimmer color for read-only
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),

            // Phone Number
            Row(
              crossAxisAlignment: CrossAxisAlignment.end, // Align baseline
              children: [
                CountryCodePicker(
                  onChanged: (CountryCode code) {
                    setState(() {
                      _countryCode = code.dialCode ?? '+41';
                    });
                  },
                  initialSelection: _countryCode, // Set based on loaded data or default
                  favorite: const ['+41', '+49', '+33', '+39'], // CH, DE, FR, IT
                  backgroundColor: Colors.grey[850], // Dark background for dialog
                  dialogBackgroundColor: Colors.grey[850],
                   textStyle: inputTextStyle,
                   searchStyle: inputTextStyle,
                   dialogTextStyle: inputTextStyle,
                   closeIcon: const Icon(Icons.close, color: Colors.white), // Ensure close icon is visible
                  flagWidth: 25, // Adjust flag size
                   padding: const EdgeInsets.only(bottom: 12, right: 0), // Adjust padding to align with TextFormField baseline
                ),
                 // Give space between picker and field
                 const SizedBox(width: 8),
                Expanded(
                  child: TextFormField(
                    controller: _phoneNumberController,
                    decoration: const InputDecoration(
                      labelText: 'Phone Number *',
                      labelStyle: inputLabelStyle,
                      enabledBorder: enabledBorder,
                      focusedBorder: focusedBorder,
                      // No icon needed here as code is separate
                    ),
                    style: inputTextStyle,
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter your phone number';
                      }
                       // Basic validation (digits, maybe dashes/spaces) - adjust as needed
                       if (!RegExp(r'^[0-9\s-]*$').hasMatch(value)) {
                          return 'Enter a valid phone number';
                       }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Save Button
            ElevatedButton.icon(
              onPressed: _isSavingProfile ? null : _saveProfile,
              icon: _isSavingProfile
                  ? Container(
                      width: 18, height: 18,
                      margin: const EdgeInsets.only(right: 8),
                      child: const CircularProgressIndicator(strokeWidth: 2, color: Colors.black))
                  : const Icon(Icons.save, color: Colors.black, size: 20),
              label: Text(
                _isSavingProfile ? 'Saving...' : 'Save Profile',
                style: GoogleFonts.genos(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amberAccent,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                disabledBackgroundColor: Colors.amberAccent.withOpacity(0.5),
              ),
            ),
             const SizedBox(height: 40),
             // Sign Out Button
             TextButton.icon(
                  icon: const Icon(Icons.logout, color: Colors.redAccent, size: 18),
                  label: const Text('Sign Out', style: TextStyle(color: Colors.redAccent)),
                  onPressed: () async {
                        await _authService.signOut();
                        // Navigation should be handled by the auth state listener wrapper
                  },
             ),
          ],
        ),
      ),
    );
  }


  /// Builds the content for the "Posted Missions" tab.
  Widget _buildPostedMissionsTab() {
    if (_currentUser == null) {
      return const Center(child: Text('Not logged in.', style: TextStyle(color: Colors.grey)));
    }
    // Query for missions created by the current user
    final query = _missionsRef
        .orderByChild('userId')
        .equalTo(_currentUser!.uid);

    return _buildMissionsList(query.onValue, "You haven't posted any missions yet.");
  }

  /// Builds the content for the "Accepted Missions" tab.
  Widget _buildAcceptedMissionsTab() {
    if (_currentUser == null) {
      return const Center(child: Text('Not logged in.', style: TextStyle(color: Colors.grey)));
    }
    // Query for missions assigned to the current user
    final query = _missionsRef
        .orderByChild('assignedUserId')
        .equalTo(_currentUser!.uid);

    return _buildMissionsList(query.onValue, "You haven't accepted any missions yet.");
  }


  /// Generic function to build a list of missions using a StreamBuilder.
  Widget _buildMissionsList(Stream<DatabaseEvent> stream, String emptyListMessage) {
    const Color textColor = Colors.grey;
    const Color cardColor = Color(0xFF2A2A2A);
    const Color borderColor = Color(0xFF424242);

    return StreamBuilder<DatabaseEvent>(
      stream: stream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator(color: Colors.amberAccent));
        }
        if (snapshot.hasError) {
          log("Error fetching missions: ${snapshot.error}");
          return Center(child: Text('Error loading missions: ${snapshot.error}', style: const TextStyle(color: Colors.redAccent)));
        }
        if (!snapshot.hasData || snapshot.data?.snapshot.value == null) {
          return Center(child: Text(emptyListMessage, style: const TextStyle(color: Colors.grey)));
        }

        // Data is available, process it
        final missionsMap = Map<String, dynamic>.from(snapshot.data!.snapshot.value as Map);
        final missionsList = missionsMap.entries.map((entry) {
          // Important: Ensure data consistency or handle potential nulls robustly
           return Map<String, dynamic>.from(entry.value as Map)..putIfAbsent('missionId', () => entry.key);
        }).toList();

        // Optional: Sort missions, e.g., by creation date descending
        missionsList.sort((a, b) {
             final timeA = a['createdAt'] ?? '';
             final timeB = b['createdAt'] ?? '';
              // Handle potential parsing errors if needed
             return timeB.compareTo(timeA); // Descending
           });

        if (missionsList.isEmpty) {
          return Center(child: Text(emptyListMessage, style: const TextStyle(color: Colors.grey)));
        }

        // Build the list view
        return ListView.builder(
          padding: const EdgeInsets.all(10.0),
          itemCount: missionsList.length,
          itemBuilder: (context, index) {
            final missionData = missionsList[index];
            final missionId = missionData['missionId'] as String; // Should always exist now
             final title = missionData['description'] as String? ?? 'No Description';
             final shortDesc = title.length > 60 ? '${title.substring(0, 60)}...' : title; // Snippet
             final location = missionData['locationDescription'] as String? ?? 'No Location';
             final status = missionData['status'] as String? ?? 'Unknown';
             final category = missionData['category'] as String? ?? 'N/A';

            return Card(
               margin: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 4.0),
               color: cardColor,
               shape: RoundedRectangleBorder(
                 borderRadius: BorderRadius.circular(8),
                 side: BorderSide(color: borderColor.withOpacity(0.7), width: 0.5),
               ),
               child: ListTile(
                contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                 leading: Icon(_getIconForCategory(category), color: Colors.amberAccent, size: 30),
                 title: Text(
                     shortDesc,
                     style: GoogleFonts.genos(color: textColor, fontWeight: FontWeight.w600, fontSize: 16),
                     maxLines: 1,
                     overflow: TextOverflow.ellipsis,
                  ),
                 subtitle: Text(
                    '$location\nStatus: $status',
                    style: TextStyle(color: textColor.withOpacity(0.8), fontSize: 12, height: 1.3),
                    maxLines: 2,
                     overflow: TextOverflow.ellipsis,
                 ),
                 trailing: const Icon(Icons.chevron_right, color: textColor),
                 onTap: () {
                   Navigator.push(
                     context,
                     MaterialPageRoute(
                       builder: (context) => MissionDetailsScreen(missionId: missionId),
                     ),
                   );
                 },
               ),
            );
          },
        );
      },
    );
  }

  // Helper to get an icon based on category (similar to SendOnMissionScreen)
  IconData _getIconForCategory(String category) {
      switch (category) {
         case 'Errands': return Icons.directions_run;
         case 'Transportation': return Icons.local_taxi;
         case 'Delivery': return Icons.local_shipping;
         case 'Food': return Icons.restaurant;
         case 'Social': return Icons.people;
         case 'Animals': return Icons.pets;
         case 'Repairs': return Icons.build;
         case 'Special': return Icons.star;
         default: return Icons.help_outline;
      }
   }


  // --- Main Build Method ---
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
         // Use title based on current tab? Or keep generic? Generic for now.
        title: Text(
           'My Account', // Changed title
           style: GoogleFonts.genos(color: Colors.grey[300], fontWeight: FontWeight.bold),
        ),
        flexibleSpace: Container( // Gradient for AppBar background
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.black87, Colors.black],
              begin: Alignment.topLeft, end: Alignment.bottomRight,
            ),
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.amberAccent, // Highlight color for selected tab
          labelColor: Colors.amberAccent, // Color for selected tab label
          unselectedLabelColor: Colors.grey[400], // Color for unselected tab labels
          tabs: const [
            Tab(icon: Icon(Icons.person), text: 'Profile'),
            Tab(icon: Icon(Icons.publish), text: 'Posted'),
            Tab(icon: Icon(Icons.assignment_turned_in), text: 'Accepted'),
          ],
        ),
      ),
      body: Container(
        // Background Gradient for TabBarView content
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.black87, Colors.black],
          ),
        ),
        child: TabBarView(
          controller: _tabController,
          children: [
            _buildEditProfileTab(),
            _buildPostedMissionsTab(),
            _buildAcceptedMissionsTab(),
          ],
        ),
      ),
    );
  }
}