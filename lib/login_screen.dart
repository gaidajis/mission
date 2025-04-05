import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mission/home_screen.dart';
import '../auth_service.dart'; // Make sure this path is correct
import 'create_account_screen.dart'; // Adjust the import according to your project structure

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();
  String errorMessage = '';

  // Dispose controllers when the widget is removed from the tree
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // --- Added Scaffold here ---
    return Scaffold(
      // Set a background color that matches your app theme
      backgroundColor: Colors.black, // Or Colors.black87, etc.
      body: Padding( // The original Padding widget is now the body of the Scaffold
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(24.0),
              decoration: BoxDecoration(
                color: Colors.grey, // Slightly adjusted color/opacity
                borderRadius: BorderRadius.circular(12), // Slightly larger radius
                boxShadow: [
                  BoxShadow(
                    color: Colors.black, // Darker shadow
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: const Offset(0, 4), // Slightly larger offset
                  ),
                ],
              ),
              child: Column(
                children: <Widget>[
                  Text( // Changed to Text widget, ensure correct styling
                    'Login',
                    style: TextStyle(
                      fontSize: 22, // Increased size
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[300], // Lighter color for dark theme
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(color: Colors.grey[200]), // Text input color
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(color: Colors.grey[400]),
                      enabledBorder: OutlineInputBorder( // Style for normal state
                        borderSide: BorderSide(color: Colors.grey[700]!),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder( // Style when focused
                        borderSide: const BorderSide(color: Colors.amber), // Use accent color
                         borderRadius: BorderRadius.circular(8),
                      ),
                      filled: true,
                      fillColor: Colors.grey[850], // Background color for text field
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    style: TextStyle(color: Colors.grey[200]), // Text input color
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(color: Colors.grey[400]),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey[700]!),
                         borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.amber),
                         borderRadius: BorderRadius.circular(8),
                      ),
                      filled: true,
                      fillColor: Colors.grey[850],
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Display error message if it's not empty
                  if (errorMessage.isNotEmpty)
                    Padding( // Added padding around error message
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        errorMessage,
                        style: const TextStyle(color: Colors.redAccent, fontSize: 14), // Adjusted style
                      ),
                    ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber, // Use accent color
                      foregroundColor: Colors.black, // Text color on button
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12), // Adjusted padding
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      elevation: 3, // Add some elevation
                    ),
                    onPressed: () async {
                      String email = _emailController.text.trim();
                      String password = _passwordController.text.trim();

                      if (email.isEmpty || password.isEmpty) {
                        setState(() {
                          errorMessage = 'Please enter both email and password.';
                        });
                        return;
                      }
                      // Clear previous error message before attempting login
                      setState(() {
                         errorMessage = '';
                      });

                      // Show loading indicator (optional but good UX)
                      // Consider adding a bool state like _isLoading and show CircularProgressIndicator

                      User? user = await _authService.signInWithEmailAndPassword(email, password);

                      // Check if the widget is still mounted before proceeding
                      if (!context.mounted) return;

                      if (user != null) {
                        // Navigate to ProfileScreen on successful login
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const MainAppScreen()),
                        );
                      } else {
                        // Update error message on failure
                        setState(() {
                          errorMessage = 'Login failed. Please check email and password.'; // More user-friendly message
                        });
                      }
                      // Hide loading indicator if used
                    },
                    child: const Text('Login', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)), // Adjusted style
                  ),
                  // Add option to create an account the screen name is create_account_screen.dart
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const SignUpScreen()),
                      );
                    },
                    child: const Text(
                      'Create an account',
                      style: TextStyle(color: Colors.amber), // Accent color for text
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
    // --- End of Scaffold ---
  }
}

