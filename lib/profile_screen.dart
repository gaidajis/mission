import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../auth_service.dart'; // Import your AuthService
import 'package:country_code_picker/country_code_picker.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  final AuthService authService = AuthService();
  final _formKey = GlobalKey<FormState>();

  String? _firstName;
  String? _lastName;
  String? _email;
  String? _phoneNumber;
  String? _countryCode = '+1'; // Default country code

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      //  Here you would typically fetch the user's profile data
      //  from your database (e.g., Firestore) using the user.uid.
      //  For this example, I'll use placeholder values.
      setState(() {
        _firstName = "John"; // Replace with actual data
        _lastName = "Doe"; // Replace with actual data
        _email = user.email;
        _phoneNumber = "123-456-7890"; // Replace with actual data
      });
    }
  }

  Future<void> _saveProfile() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      //  Here you would typically save the updated profile data
      //  to your database using the collected values (_firstName, _lastName, etc.).
      print('Saving Profile:');
      //  For example, if using Firestore:
      //  await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
      //    'firstName': _firstName,
      //    'lastName': _lastName,
      //    'phoneNumber': '$_countryCode $_phoneNumber',
      //  });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated successfully!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
          child: Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                const SizedBox(height: 16),
                const Text(
                  'Edit Profile',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                TextFormField(
                  initialValue: _firstName,
                  decoration: const InputDecoration(
                    labelText: 'First Name',
                    labelStyle: TextStyle(color: Colors.grey),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueGrey),
                    ),
                  ),
                  style: const TextStyle(color: Colors.grey),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your first name';
                    }
                    return null;
                  },
                  onSaved: (value) => _firstName = value,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  initialValue: _lastName,
                  decoration: const InputDecoration(
                    labelText: 'Last Name',
                    labelStyle: TextStyle(color: Colors.grey),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueGrey),
                    ),
                  ),
                  style: const TextStyle(color: Colors.grey),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your last name';
                    }
                    return null;
                  },
                  onSaved: (value) => _lastName = value,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  initialValue: _email,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(color: Colors.grey),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueGrey),
                    ),
                  ),
                  style: const TextStyle(color: Colors.grey),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!value.contains('@')) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                  onSaved: (value) => _email = value,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    CountryCodePicker(
                      onChanged: (CountryCode code) {
                        setState(() {
                          _countryCode = code.dialCode!;
                        });
                      },
                      initialSelection: 'US', //  Default country
                      favorite: const ['US', 'CA', 'GB', 'AU'],
                      showCountryOnly: false,
                      showOnlyCountryWhenClosed: false,
                      alignLeft: false,
                      textStyle: const TextStyle(color: Colors.grey),
                    ),
                    Expanded(
                      child: TextFormField(
                        initialValue: _phoneNumber,
                        decoration: const InputDecoration(
                          labelText: 'Phone Number',
                          labelStyle: TextStyle(color: Colors.grey),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.blueGrey),
                          ),
                        ),
                        style: const TextStyle(color: Colors.grey),
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your phone number';
                          }
                          return null;
                        },
                        onSaved: (value) => _phoneNumber = value,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: _saveProfile,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueGrey,
                  ),
                  child: const Text(
                    'Save Profile',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
