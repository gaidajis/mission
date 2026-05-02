import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'mission_details_screen.dart'; // Ensure this accepts missionId
import 'dart:developer'; // For logging

// --- Configuration ---
const String defaultCountryCode = 'CH'; // Set default country (Switzerland)

// --- Widget ---
class SendOnMissionScreen extends StatefulWidget {
  const SendOnMissionScreen({super.key});

  @override
  State<SendOnMissionScreen> createState() => _SendOnMissionScreenState();
}

class _SendOnMissionScreenState extends State<SendOnMissionScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String? _selectedCategory;

  // --- Text Input Controllers ---
  final _descriptionController = TextEditingController();
  final _locationController = TextEditingController();
  final _budgetController = TextEditingController();
  final _timeframeController = TextEditingController();
  final _instructionsController = TextEditingController();

  // --- Mission Categories ---
  final List<String> _missionCategories = const [
    'Errands', 'Transportation', 'Delivery', 'Food',
    'Social', 'Animals', 'Repairs', 'Special',
  ];

  // --- Lifecycle ---
  @override
  void dispose() {
    _descriptionController.dispose();
    _locationController.dispose();
    _budgetController.dispose();
    _timeframeController.dispose();
    _instructionsController.dispose();
    super.dispose();
  }

  // --- Actions ---

  /// Handles the final submission process after validation.
  Future<void> _submitMission() async {
    // 1. Validate all form fields using the key
    final isFormValid = _formKey.currentState?.validate() ?? false;

    // 2. Manually check if a category has been selected
    final isCategorySelected = _selectedCategory != null;

    // 3. Trigger UI update to show validation errors if needed
    setState(() {
      // This call ensures validation messages appear if triggered by button press
    });

    // 4. Stop if form is invalid OR category not selected
    if (!isFormValid || !isCategorySelected) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all required fields and select a category.'),
          backgroundColor: Colors.orangeAccent,
        ),
      );
      return;
    }

    // 5. Check Authentication
    final User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Authentication Error. Please log in again.')),
      );
      return;
    }

    // 6. Start Loading State
    setState(() => _isLoading = true);

    try {
      final DatabaseReference missionsRef = FirebaseDatabase.instance.ref('missions');
      final newMissionRef = missionsRef.push(); // Generate unique ID
      final missionId = newMissionRef.key;

      if (missionId == null) {
        throw Exception("Failed to generate mission ID.");
      }

      // 7. Prepare Mission Data for Saving Online
      final missionData = {
        // Core Info (for filtering/display by others)
        'missionId': missionId,
        'userId': user.uid, // The user who created the mission
        'category': _selectedCategory!, // Known non-null due to check above
        'locationDescription': _locationController.text.trim(),
        'country': defaultCountryCode, // Or get dynamically later
        'status': 'new', // Initial status for others to see
        'createdAt': DateTime.now().toUtc().toIso8601String(), // Client UTC time
        'timestamp': ServerValue.timestamp, // Firebase server timestamp

        // Detailed Info
        'description': _descriptionController.text.trim(),
        'budget': _budgetController.text.trim(), // Optional
        'timeframe': _timeframeController.text.trim(), // Optional
        'instructions': _instructionsController.text.trim(), // Optional

        // Future Use (for accepted missions)
        'applicants': {}, // Map of userId: applicationTimestamp for potential helpers
        'assignedUserId': null, // ID of the user who accepts the mission
      };

      // 8. Save Data Online to Firebase RTDB
      await newMissionRef.set(missionData);

      // 9. Show Accurate Success Feedback
      if (!mounted) return;

      _showSuccessDialog(missionId);

    } catch (e) {
      log('Error posting mission: $e');
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              Text('Failed to post mission. Please try again. Error: $e'),
          backgroundColor: Colors.redAccent,
        ),
      );
    } finally {
      // 10. Stop Loading State
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  /// Shows the success dialog after mission is posted online.
  void _showSuccessDialog(String missionId) {
    showDialog(
      context: context,
      barrierDismissible: false, // User must explicitly choose an action
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey[900],
          title: Text(
            'Mission Posted Online!', // Accurate Message
            style: GoogleFonts.genos(fontWeight: FontWeight.bold, color: Colors.grey[300]),
          ),
          content: Text(
            'Your mission is now visible to potential helpers in $defaultCountryCode.',
            style: const TextStyle(color: Colors.grey),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('View Mission', style: TextStyle(color: Colors.amberAccent)),
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
                Navigator.pushReplacement( // Go to details, replace form
                  context,
                  MaterialPageRoute(
                    builder: (context) => MissionDetailsScreen(missionId: missionId),
                  ),
                );
              },
            ),
            TextButton(
              child: const Text('OK', style: TextStyle(color: Colors.grey)),
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
                Navigator.of(context).pop(); // Go back from SendOnMissionScreen
              },
            ),
          ],
        );
      },
    );
  }

  // --- UI Building Helpers ---

  /// Builds a styled TextFormField.
  Widget _buildTextFormField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
    bool isOptional = false,
  }) {
    String? defaultValidator(String? value) {
      if (!isOptional && (value == null || value.trim().isEmpty)) {
        return 'Please enter the $label.';
      }
      return null;
    }
    final effectiveValidator = validator ?? defaultValidator;
    final displayLabel = label + (isOptional ? ' (Optional)' : ' *'); // Indicate required

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        style: const TextStyle(color: Colors.white),
        maxLines: maxLines,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: displayLabel,
          labelStyle: TextStyle(color: Colors.grey[400]),
          floatingLabelStyle: const TextStyle(color: Colors.amberAccent), // Style when focused
          prefixIcon: Icon(icon, color: Colors.grey[400], size: 20), // Icon color matches label
          filled: true,
          fillColor: Colors.black,
          contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 12.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(color: Colors.amberAccent, width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
             borderSide: BorderSide(color: Colors.grey[700]!, width: 0.5),
          ),
           errorBorder: OutlineInputBorder(
             borderRadius: BorderRadius.circular(8.0),
             borderSide: const BorderSide(color: Colors.redAccent, width: 1),
           ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
          ),
           errorStyle: const TextStyle(color: Colors.redAccent, fontSize: 11), // Customize error text
        ),
        validator: effectiveValidator,
      ),
    );
  }

  /// Builds the grid for category selection.
  Widget _buildCategoryGrid() {
     // Define colors consistent with the theme
    const Color textColor = Colors.grey;
    const Color cardColor = Color(0xFF2A2A2A);
    const Color selectedColor = Colors.amberAccent;
    const Color borderColor = Color(0xFF424242);

    return GridView.builder(
      shrinkWrap: true, // Essential inside ListView
      physics: const NeverScrollableScrollPhysics(), // Grid itself doesn't scroll
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 2.8 / 1,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: _missionCategories.length,
      itemBuilder: (context, index) {
        final category = _missionCategories[index];
        final isSelected = category == _selectedCategory;

        // InkWell makes the container tappable
        return InkWell(
          onTap: () {
            // **CRITICAL:** This ONLY updates the state, no saving happens here.
            setState(() {
              _selectedCategory = category;
            });
          },
          borderRadius: BorderRadius.circular(8), // Match container radius
          splashColor: selectedColor, // Add a splash effect
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: isSelected ? selectedColor : cardColor,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: isSelected ? selectedColor : borderColor,
                width: isSelected ? 1.5 : 1,
              ),
            ),
            child: Center(
              child: Text(
                category,
                textAlign: TextAlign.center,
                style: GoogleFonts.genos(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: isSelected ? selectedColor : textColor,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ),
        );
      },
    );
  }

   /// Builds a section header with a divider.
   Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.genos(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.grey[300])
          ),
          const Divider(color: Color(0xFF424242), thickness: 0.5, height: 10),
        ],
      ),
    );
  }


  // --- Main Build Method ---
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text('Create New Mission', style: GoogleFonts.genos(color: Colors.grey)),
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
            begin: Alignment.topCenter, end: Alignment.bottomCenter,
            colors: [Colors.black87, Colors.black],
          ),
        ),
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: ListView( // Use ListView for scrolling if content overflows
              padding: const EdgeInsets.all(16.0),
              children: <Widget>[

                _buildSectionHeader('Mission Details'),
                // Description (Mandatory)
                _buildTextFormField(
                  controller: _descriptionController,
                  label: 'Description',
                  icon: Icons.description,
                  maxLines: 3,
                   validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please describe the mission.';
                    }
                    if (value.trim().length < 15) { // Slightly longer minimum
                      return 'Description should be at least 15 characters.';
                    }
                    return null;
                  },
                ),
                // Location (Mandatory)
                _buildTextFormField(
                  controller: _locationController,
                  label: 'Location',
                  icon: Icons.location_on,
                  maxLines: 2,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please specify the location.';
                    }
                    if (value.trim().length < 5) {
                      return 'Location details seem too short.';
                    }
                    return null;
                  },
                ),

                _buildSectionHeader('Category *'),
                // Category Selection Grid
                _buildCategoryGrid(),
                // Validation message area for category (shown if submit fails due to category)
                if (_formKey.currentState != null && !_formKey.currentState!.validate() && _selectedCategory == null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                       'Please select a category.',
                       style: TextStyle(color: Theme.of(context).colorScheme.error, fontSize: 12),
                       textAlign: TextAlign.center,
                     ),
                 ),
                 // Handle case where only category is missing after button press
                 if (_formKey.currentState != null && _formKey.currentState!.validate() == true && _selectedCategory == null)
                   Padding(
                     padding: const EdgeInsets.only(top: 8.0),
                     child: Text(
                       'Please select a category.',
                       style: TextStyle(color: Theme.of(context).colorScheme.error, fontSize: 12),
                       textAlign: TextAlign.center,
                     ),
                 ),

                _buildSectionHeader('Optional Terms'),
                 // Budget (Optional)
                _buildTextFormField(
                  controller: _budgetController,
                  label: 'Budget',
                  icon: Icons.attach_money,
                  keyboardType: TextInputType.text, // Allows text like "Negotiable"
                  isOptional: true,
                ),
                // Timeframe (Optional)
                _buildTextFormField(
                  controller: _timeframeController,
                  label: 'Timeframe',
                  icon: Icons.timer,
                  isOptional: true,
                ),
                // Instructions (Optional)
                _buildTextFormField(
                  controller: _instructionsController,
                  label: 'Specific Instructions',
                  icon: Icons.info_outline,
                  maxLines: 2,
                  isOptional: true,
                ),

                const SizedBox(height: 30), // Spacing before button

                // --- Final Submit Button ---
                ElevatedButton.icon(
                  // Disable button while loading
                  onPressed: _isLoading ? null : _submitMission,
                  icon: _isLoading
                      ? Container(
                          width: 20, height: 20, // Smaller indicator
                          margin: const EdgeInsets.only(right: 8), // Space between indicator and text
                          child: const CircularProgressIndicator(
                            color: Colors.black, strokeWidth: 2.5,
                          ),
                        )
                      : const Icon(Icons.publish, color: Colors.black, size: 20),
                  label: Text(
                    _isLoading ? 'Posting...' : 'Post Mission Online', // Clear action text
                    style: GoogleFonts.genos(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amberAccent, // Use the highlight color
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    elevation: 4,
                    // Style for disabled state (when loading)
                    disabledBackgroundColor: Colors.amberAccent, // Dimmed when loading
                  ),
                ),
                const SizedBox(height: 20), // Padding at the bottom
              ],
            ),
          ),
        ),
      ),
    );
  }
}