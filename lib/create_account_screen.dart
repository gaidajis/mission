import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mission/auth_service.dart'; // Adjust the import according to your project structure
import 'package:mission/home_screen.dart'; // Adjust the import according to your project structure
import 'package:mission/login_screen.dart'; // Adjust the import according to your project structure

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  SignUpScreenState createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen> {
  final _emailController = TextEditingController(); // Renamed for consistency
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final AuthService _authService = AuthService();
  String errorMessage = '';
  bool _isLoading = false;
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  final _formKey = GlobalKey<FormState>();
  final _emailFocusNode = FocusNode(); // Renamed for consistency
  final _passwordFocusNode = FocusNode();
  final _confirmPasswordFocusNode = FocusNode();

  // Note: Removed focus listeners as they weren't directly used for styling matching the LoginScreen example.
  // If you had specific focus-based styling logic beyond the border color, you'd re-add them.

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    super.dispose();
  }

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  void _toggleConfirmPasswordVisibility() {
    setState(() {
      _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
    });
  }

  void _signUp() async {
    // Hide keyboard
    FocusScope.of(context).unfocus();

    // Validate form
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
        errorMessage = '';
      });

      try {
        User? user = await _authService.signUpWithEmailAndPassword(
          _emailController.text.trim(),
          _passwordController.text.trim(),
        );

        // Check if mounted before navigating
        if (!mounted) return;

        if (user != null) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const MainAppScreen()), // Ensure MainAppScreen exists
          );
        } else {
          // This part might not be reached if signUpWithEmailAndPassword throws on failure
          setState(() {
            errorMessage = 'Registration failed. Please try again.';
          });
        }
      } on FirebaseAuthException catch (e) {
        setState(() {
          // Provide more specific errors if desired, otherwise use e.message
          errorMessage = e.message ?? 'An unknown error occurred.';
          // Example specific errors:
          // if (e.code == 'weak-password') {
          //   errorMessage = 'The password provided is too weak.';
          // } else if (e.code == 'email-already-in-use') {
          //   errorMessage = 'An account already exists for that email.';
          // } else {
          //   errorMessage = e.message ?? 'An unknown error occurred.';
          // }
        });
      } catch (e) {
        // Catch other potential errors
        setState(() {
          errorMessage = 'An unexpected error occurred: ${e.toString()}';
        });
      } finally {
        // Ensure isLoading is set to false even if context check fails or unexpected error
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    } else {
      // Optional: Show a generic message if form validation fails
      // setState(() {
      //   errorMessage = 'Please fix the errors above.';
      // });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // --- Style adopted from LoginScreen ---
      backgroundColor: Colors.black, // Dark background
      body: Padding( // Outer padding
        padding: const EdgeInsets.all(24.0),
        child: Column( // Center the content vertically
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container( // Styled container
              padding: const EdgeInsets.all(24.0),
              decoration: BoxDecoration(
                color: Colors.grey[850], // Darker grey for container background
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black, // Shadow color
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Form( // Keep the Form for validation
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min, // Prevent column from expanding unnecessarily
                  children: [
                    // --- Title ---
                    Text(
                      'Create Account',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[300], // Light text for dark theme
                      ),
                    ),
                    const SizedBox(height: 20),

                    // --- Email Field ---
                    TextFormField(
                      controller: _emailController,
                      focusNode: _emailFocusNode,
                      style: TextStyle(color: Colors.grey[200]), // Input text color
                      decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: TextStyle(color: Colors.grey[400]),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey[700]!),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.amber), // Accent color on focus
                          borderRadius: BorderRadius.circular(8),
                        ),
                        errorBorder: OutlineInputBorder( // Style for error state
                          borderSide: const BorderSide(color: Colors.redAccent),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedErrorBorder: OutlineInputBorder( // Style for error state when focused
                          borderSide: const BorderSide(color: Colors.redAccent, width: 2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        filled: true,
                        fillColor: Colors.grey[900], // Slightly darker fill than container
                      ),
                      keyboardType: TextInputType.emailAddress,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        // Basic email format check (consider using a regex package for robust validation)
                        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                          return 'Please enter a valid email address';
                        }
                        return null; // Return null if valid
                      },
                    ),
                    const SizedBox(height: 16.0),

                    // --- Password Field ---
                    TextFormField(
                      controller: _passwordController,
                      focusNode: _passwordFocusNode,
                      style: TextStyle(color: Colors.grey[200]),
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
                        errorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.redAccent),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.redAccent, width: 2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        filled: true,
                        fillColor: Colors.grey[900],
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                            color: Colors.grey[500], // Icon color
                          ),
                          onPressed: _togglePasswordVisibility,
                        ),
                      ),
                      obscureText: !_isPasswordVisible,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a password';
                        }
                        // Example: Minimum length validation
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null; // Return null if valid
                      },
                    ),
                    const SizedBox(height: 16.0),

                    // --- Confirm Password Field ---
                    TextFormField(
                      controller: _confirmPasswordController,
                      focusNode: _confirmPasswordFocusNode,
                      style: TextStyle(color: Colors.grey[200]),
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        labelStyle: TextStyle(color: Colors.grey[400]),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey[700]!),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.amber),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.redAccent),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.redAccent, width: 2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        filled: true,
                        fillColor: Colors.grey[900],
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
                            color: Colors.grey[500], // Icon color
                          ),
                          onPressed: _toggleConfirmPasswordVisibility,
                        ),
                      ),
                      obscureText: !_isConfirmPasswordVisible,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please confirm your password';
                        }
                        if (value != _passwordController.text) {
                          return 'Passwords do not match';
                        }
                        return null; // Return null if valid
                      },
                    ),
                    const SizedBox(height: 12.0), // Slightly less space before error

                    // --- Error Message ---
                    if (errorMessage.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0, top: 4.0), // Add padding
                        child: Text(
                          errorMessage,
                          style: const TextStyle(color: Colors.redAccent, fontSize: 14),
                          textAlign: TextAlign.center, // Center align error text
                        ),
                      ),
                    const SizedBox(height: 12.0), // Space before button adjusted


                    // --- Sign Up Button ---
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber, // Accent color button
                        foregroundColor: Colors.black, // Text color on button
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        elevation: 3,
                        minimumSize: const Size(double.infinity, 48), // Make button wider
                      ),
                      onPressed: _isLoading ? null : _signUp, // Disable button when loading
                      child: _isLoading
                          ? const SizedBox( // Use SizedBox for consistent CircularProgressIndicator size
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                color: Colors.black, // Indicator color
                                strokeWidth: 3,
                              ),
                            )
                          : const Text(
                              'Create Account',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                    ),
                    const SizedBox(height: 16.0),

                    // --- Link to Login Screen ---
                    TextButton(
                      onPressed: _isLoading ? null : () { // Disable if loading
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const LoginScreen()), // Ensure LoginScreen exists
                        );
                      },
                      child: const Text(
                        'Already have an account? Log in',
                        style: TextStyle(color: Colors.amber), // Accent color text
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}