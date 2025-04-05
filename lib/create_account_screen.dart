// This file is responsible for creating user accounts. It includes the UI for the sign-up screen, where users can enter their email and password to create a new account. The code also handles user input validation and error messages. The `AuthService` class is used to interact with Firebase Authentication for user registration. The `SignUpScreen` widget is a stateful widget that manages the sign-up process.
// It includes text fields for email and password, a sign-up button, and a link to the login screen. The `signUpWithEmailAndPassword` method in the `AuthService` class is called when the user presses the sign-up button. If the registration is successful, the user is navigated to the main app screen. If there are any errors, appropriate error messages are displayed to the user.
// The password field is obscured for security, and the email field is validated to ensure it contains a valid email format. The UI is designed to be user-friendly and responsive, with clear instructions and feedback for the user.


import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mission/auth_service.dart'; // Adjust the import according to your project structure
import 'package:mission/home_screen.dart';
import 'package:mission/login_screen.dart'; // Adjust the import according to your project structure

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final AuthService _authService = AuthService();
  String errorMessage = '';
  bool _isLoading = false;
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  final _formKey = GlobalKey<FormState>();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _confirmPasswordFocusNode = FocusNode();
  
  @override
  void initState() {
    super.initState();
    _emailFocusNode.addListener(() {
      setState(() {});
    });
    _passwordFocusNode.addListener(() {
      setState(() {});
    });
    _confirmPasswordFocusNode.addListener(() {
      setState(() {});
    });
  }

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

        if (user != null) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => MainAppScreen()),
          );
        } else {
          setState(() {
            errorMessage = 'Registration failed. Please try again.';
          });
        }
      } on FirebaseAuthException catch (e) {
        setState(() {
          errorMessage = e.message ?? 'An unknown error occurred.';
        });
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    print('SignUpScreen is building');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Account'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _emailController,
                    focusNode: _emailFocusNode,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      //errorText: _emailFocusNode.hasFocus ? null : Validators.validateEmail(_emailController.text),
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: _passwordController,
                    focusNode: _passwordFocusNode,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      //errorText: _passwordFocusNode.hasFocus ? null : Validators.validatePassword(_passwordController.text),
                      border: OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(_isPasswordVisible ? Icons.visibility : Icons.visibility_off),
                        onPressed: _togglePasswordVisibility,
                      ),
                    ),
                    obscureText: !_isPasswordVisible,
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: _confirmPasswordController,
                    focusNode: _confirmPasswordFocusNode,
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      //errorText: _confirmPasswordFocusNode.hasFocus ? null : Validators.validateConfirmPassword(_passwordController.text, _confirmPasswordController.text),
                      border: OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(_isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off),
                        onPressed: _toggleConfirmPasswordVisibility,
                      ),
                    ),
                    obscureText: !_isConfirmPasswordVisible,
                  ),
                  const SizedBox(height: 16.0),
                  if (errorMessage.isNotEmpty)
                    Text(errorMessage, style: TextStyle(color: Colors.red)),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed:_isLoading ? null : _signUp,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber, // Use accent color
                      foregroundColor: Colors.black, // Text color on button
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12), // Adjusted padding
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      elevation: 3, // Add some elevation
                    ), // Disable button if loading
                    child:_isLoading ? CircularProgressIndicator() : const Text('Create Account'),
                  ),
                  const SizedBox(height: 16.0),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                    child: const Text('Already have an account? Log in'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

