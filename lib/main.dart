import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'auth_wrapper.dart';

// Main function: Entry point of the application
void main() async {
  // Ensure Flutter bindings are initialized
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Firebase with the default options for the current platform
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // Run the application by creating an instance of MyApp
  runApp(const MyApp());
}

// MyApp: The root widget of the application
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Disable the debug banner
      title: 'The Mission', // Set the application title
      home: const AuthWrapper(), // Set AuthWrapper as the home screen
      // Consider adding routes here if you navigate to MainAppScreen from AuthWrapper
      // routes: {
      //   '/main': (context) => const MainAppScreen(),
      // },
    );
  }
}
