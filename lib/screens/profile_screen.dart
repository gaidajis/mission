import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:image_picker/image_picker.dart'; // Import Image Picker
import 'mission_details_screen.dart';
import 'dart:developer';
import 'dart:io'; // For File

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _formKey = GlobalKey<FormState>();
  User? _currentUser;
  bool _isLoadingProfile = true;
  bool _isSavingProfile = false;
  bool _isEditing = false;
  String? _profilePhotoUrl;
  File? _profilePhotoFile; // To store the selected image file

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  String _email = '';
  String _countryCode = '+41';

  DatabaseReference? _userProfileRef;
  final DatabaseReference _missionsRef = FirebaseDatabase.instance.ref('missions');
  final FirebaseStorage _storage = FirebaseStorage.instance; // Firebase Storage instance
  final ImagePicker _picker = ImagePicker(); // Image Picker instance

  static const TextStyle inputLabelStyle = TextStyle(color: Colors.grey);
  static const TextStyle inputTextStyle = TextStyle(color: Colors.white);
  static const TextStyle profileViewLabelStyle = TextStyle(color: Colors.grey);
  static const TextStyle profileViewValueStyle = TextStyle(color: Colors.white, fontWeight: FontWeight.bold);

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _currentUser = FirebaseAuth.instance.currentUser;

    if (_currentUser == null) {
      log("Error: Current user is null in ProfileScreen initState.");
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("User not logged in!"), backgroundColor: Colors.red));
        }
      });
    } else {
      _userProfileRef = FirebaseDatabase.instance.ref('users/${_currentUser!.uid}/profile');
      _email = _currentUser!.email ?? 'No Email';
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
          _countryCode = data['countryCode'] ?? '+41';
          String fullPhone = data['phoneNumber'] ?? '';
          if (fullPhone.startsWith(_countryCode)) {
            _phoneNumberController.text = fullPhone.substring(_countryCode.length).trim();
          } else {
            _phoneNumberController.text = fullPhone;
          }
          _profilePhotoUrl = data['profilePhotoUrl'];
        });
      } else if (mounted) {
        log("Profile data not found for user ${_currentUser?.uid}. Creating default profile node might be needed.");
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

  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    if (_userProfileRef == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Error: User reference not available."), backgroundColor: Colors.red),
      );
      return;
    }

    setState(() => _isSavingProfile = true);

    try {
      // Upload profile photo if a new one is selected
      if (_profilePhotoFile != null) {
        final ref = _storage.ref().child('users/${_currentUser!.uid}/profile_photo.jpg');
        await ref.putFile(_profilePhotoFile!);
        _profilePhotoUrl = await ref.getDownloadURL();
      }

      await _userProfileRef!.update({
        'firstName': _firstNameController.text.trim(),
        'lastName': _lastNameController.text.trim(),
        'phoneNumber': _phoneNumberController.text.trim(),
        'countryCode': _countryCode,
        if (_profilePhotoUrl != null) 'profilePhotoUrl': _profilePhotoUrl,
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile updated successfully!'), backgroundColor: Colors.green),
        );
        setState(() {
          _isEditing = false;
          _profilePhotoFile = null; // Reset selected file after saving
        });
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

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _profilePhotoFile = File(image.path);
      });
    }
  }

  Widget _buildProfileInfoRow(IconData icon, String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: Colors.amberAccent),
            const SizedBox(width: 12),
            Text(label, style: profileViewLabelStyle),
          ],
        ),
        const SizedBox(height: 8),
        Text(value, style: profileViewValueStyle),
        const Divider(color: Colors.grey),
      ],
    );
  }

  Widget _buildProfileView() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 70,
                    backgroundColor: Colors.grey.shade700,
                    backgroundImage: _profilePhotoUrl != null
                        ? NetworkImage(_profilePhotoUrl!) as ImageProvider<Object>?
                        : null,
                    child: _profilePhotoUrl == null
                        ? const Icon(Icons.person, size: 70, color: Colors.white)
                        : null,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            _buildProfileInfoRow(Icons.person_outline, 'First Name', _firstNameController.text),
            const SizedBox(height: 16),
            _buildProfileInfoRow(Icons.person_outline, 'Last Name', _lastNameController.text),
            const SizedBox(height: 16),
            _buildProfileInfoRow(Icons.email_outlined, 'Email', _email),
            const SizedBox(height: 16),
            _buildProfileInfoRow(Icons.phone_outlined, 'Phone Number', '$_countryCode ${_phoneNumberController.text}'),
            const SizedBox(height: 40),
            Center(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        setState(() => _isEditing = true);
                      },
                      icon: const Icon(Icons.edit, color: Colors.black),
                      label: Text('Edit Profile', style: GoogleFonts.genos(color: Colors.black, fontSize: 16)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amberAccent,
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        minimumSize: const Size(double.infinity, 50), // Make button full width
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
Widget _buildEditProfileTab() {
    if (_isLoadingProfile) {
      return const Center(child: CircularProgressIndicator(color: Colors.amberAccent));
    }

    if (!_isEditing) {
      return _buildProfileView();
    }

    const focusedBorder = UnderlineInputBorder(borderSide: BorderSide(color: Colors.amberAccent));
    const enabledBorder = UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey));

    return SingleChildScrollView( // Add this SingleChildScrollView
      padding: const EdgeInsets.all(32.0),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                const SizedBox(height: 16),
                Center(
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: 70,
                        backgroundColor: Colors.grey.shade700,
                        backgroundImage: _profilePhotoFile != null
                            ? FileImage(_profilePhotoFile!) as ImageProvider<Object>?
                            : _profilePhotoUrl != null
                                ? NetworkImage(_profilePhotoUrl!) as ImageProvider<Object>?
                                : null,
                        child: _profilePhotoFile == null && _profilePhotoUrl == null
                            ? const Icon(Icons.person, size: 70, color: Colors.white)
                            : null,
                      ),
                      InkWell(
                        onTap: _pickImage,
                        child: const CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.amberAccent,
                          child: Icon(Icons.camera_alt, size: 20, color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                TextFormField(
                  controller: _firstNameController,
                  decoration: InputDecoration(
                    labelText: 'First Name *',
                    labelStyle: inputLabelStyle,
                    enabledBorder: enabledBorder,
                    focusedBorder: focusedBorder,
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: CircleAvatar(
                        radius: 14,
                        backgroundColor: Colors.grey.shade700,
                        backgroundImage: _profilePhotoFile != null
                            ? FileImage(_profilePhotoFile!) as ImageProvider<Object>?
                            : _profilePhotoUrl != null
                                ? NetworkImage(_profilePhotoUrl!) as ImageProvider<Object>?
                                : null,
                        child: _profilePhotoFile == null && _profilePhotoUrl == null
                            ? const Icon(Icons.person, size: 14, color: Colors.white)
                            : null,
                      ),
                    ),
                  ),
                  style: inputTextStyle,
                  validator: (value) => (value == null || value.trim().isEmpty) ? 'Please enter your first name' : null,
                ),
                const SizedBox(height: 24),
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
                const SizedBox(height: 24),
                TextFormField(
                  initialValue: _email,
                  readOnly: true,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    labelStyle: inputLabelStyle,
                    enabledBorder: enabledBorder,
                    focusedBorder: focusedBorder,
                    prefixIcon: Icon(Icons.email_outlined, color: Colors.grey, size: 20),
                  ),
                  style: TextStyle(color: Colors.grey[500]),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 24),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    CountryCodePicker(
                      onChanged: (CountryCode code) {
                        setState(() {
                          _countryCode = code.dialCode ?? '+41';
                        });
                      },
                      initialSelection: _countryCode,
                      favorite: const ['+41', '+49', '+33', '+39'],
                      backgroundColor: Colors.grey[850],
                      dialogBackgroundColor: Colors.grey[850],
                      textStyle: inputTextStyle,
                      searchStyle: inputTextStyle,
                      dialogTextStyle: inputTextStyle,
                      closeIcon: const Icon(Icons.close, color: Colors.white),
                      flagWidth: 25,
                      padding: const EdgeInsets.only(bottom: 12, right: 0),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        controller: _phoneNumberController,
                        decoration: const InputDecoration(
                          labelText: 'Phone Number *',
                          labelStyle: inputLabelStyle,
                          enabledBorder: enabledBorder,
                          focusedBorder: focusedBorder,
                        ),
                        style: inputTextStyle,
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter your phone number';
                          }
                          if (!RegExp(r'^[0-9\s-]*$').hasMatch(value)) {
                            return 'Enter a valid phone number';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
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
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        minimumSize: const Size(double.infinity, 50), // Make button full width
                      ),),
                const SizedBox(height: 40),
                TextButton.icon(
                  icon: const Icon(Icons.logout, color: Colors.redAccent, size: 18),
                  label: const Text('Sign Out', style: TextStyle(color: Colors.redAccent)),
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                    if (mounted) {
                      Navigator.pushReplacementNamed(context, '/login');
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPostedMissionsTab() {
    if (_currentUser == null) {
      return const Center(child: Text('Not logged in.', style: TextStyle(color: Colors.grey)));
    }
    final query = _missionsRef
        .orderByChild('userId')
        .equalTo(_currentUser!.uid);

    return _buildMissionsList(query.onValue, "You haven't posted any missions yet.");
  }

  Widget _buildAcceptedMissionsTab() {
    if (_currentUser == null) {
      return const Center(child: Text('Not logged in.', style: TextStyle(color: Colors.grey)));
    }
    final query = _missionsRef
        .orderByChild('assignedUserId')
        .equalTo(_currentUser!.uid);

    return _buildMissionsList(query.onValue, "You haven't accepted any missions yet.");
  }

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

        final missionsMap = Map<String, dynamic>.from(snapshot.data!.snapshot.value as Map);
        final missionsList = missionsMap.entries.map((entry) {
          return Map<String, dynamic>.from(entry.value as Map)..putIfAbsent('missionId', () => entry.key);
        }).toList();

        missionsList.sort((a, b) {
          final timeA = a['createdAt'] ?? '';
          final timeB = b['createdAt'] ?? '';
          return timeB.compareTo(timeA);
        });

        if (missionsList.isEmpty) {
          return Center(child: Text(emptyListMessage, style: const TextStyle(color: Colors.grey)));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(10.0),
          itemCount: missionsList.length,
          itemBuilder: (context, index) {
            final missionData = missionsList[index];
            final missionId = missionData['missionId'] as String;
            final title = missionData['description'] as String? ?? 'No Description';
            final shortDesc = title.length > 60 ? '${title.substring(0, 60)}...' : title;
            final location = missionData['locationDescription'] as String? ?? 'No Location';
            final status = missionData['status'] as String? ?? 'Unknown';
            final category = missionData['category'] as String? ?? 'N/A';

            return Card(
              margin: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 4.0),
              color: cardColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(color: borderColor, width: 0.5),
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
                  style: TextStyle(color: textColor, fontSize: 12, height: 1.3),
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



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text(
          'My Account',
          style: GoogleFonts.genos(color: Colors.grey[300], fontWeight: FontWeight.bold),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.black87, Colors.black],
              begin: Alignment.topLeft, end: Alignment.bottomRight,
            ),
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.amberAccent,
          labelColor: Colors.amberAccent,
          unselectedLabelColor: Colors.grey[400],
          tabs: const [
            Tab(icon: Icon(Icons.person), text: 'Profile'),
            Tab(icon: Icon(Icons.publish), text: 'Posted'),
            Tab(icon: Icon(Icons.assignment_turned_in), text: 'Accepted'),
          ],
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