import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/intl.dart';
import 'theme.dart'; // Import the theme.dart file

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'The Mission!', //change theme parameter to ThemeData

        theme: ThemeData(
          //change theme parameter to ThemeData
          fontFamily: 'Pacifico',
          primarySwatch: AppTheme.primarySwatch,
          scaffoldBackgroundColor: AppTheme.lightGrey,
          appBarTheme: AppBarTheme(
            backgroundColor: AppTheme.lightBlue,
            foregroundColor: AppTheme.darkGrey,
          ),
            elevatedButtonTheme: AppTheme.elevatedButtonThemeData,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              padding: EdgeInsets.zero,
            ),
          ),
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFADD8E6))),
          ),
        ),
        home: LoginPage(),

  );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Function to sign in with email and password
  Future<void> _signInWithEmailAndPassword() async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth.signInWithEmailAndPassword(
            email: _emailController.text, password: _passwordController.text);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      } catch (e) {
        // Handle error
        if (!context.mounted) return;
        showDialog(
          context: context,
          builder: (context) =>
              AlertDialog(title: Text('Error'), content: Text(e.toString())),
        );
      }
    }
      if (!context.mounted) return;
      showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(title: Text('Error'), content: Text(e.toString())),);
    }
  }

  Future<void> _createUserWithEmailAndPassword() async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
    } catch (e) {
      // Handle error
      if (!context.mounted) return; showDialog(context: context, builder: (context) => AlertDialog(title: Text('Error'), content: Text(e.toString()),));
    }
  }

  Future<void> _signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await _auth.signInWithCredential(credential);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
    } catch (e) {
      // Handle error
      if (!context.mounted) return;
      showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(title: Text('Error'), content: Text(e.toString())),
      );
    }
  }

  @override
  // Dispose controllers to avoid memory leaks.
  //It is essential to dispose of text editing controllers when they are no longer needed,
  //especially in stateful widgets. This helps prevent memory leaks by releasing the resources
  //held by the controllers. Failing to dispose of controllers can lead to performance issues
  //and crashes over time, especially in complex apps.
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( // Wrap with Form widget for form validation
      appBar: AppBar(
          title: Image.asset("assets/images/logo.jpg", width: 230, height: 50),
          backgroundColor: AppTheme.lightBlue),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey, // Add form key for validation
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty || !value.contains('@')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 10),
            TextField(
              validator: (value) {
                if (value == null || value.isEmpty || value.length < 6) {
                  return 'Password must be at least 6 characters';
                }
                return null;
              },
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _signInWithEmailAndPassword,
              child: Text('Login'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _createUserWithEmailAndPassword,
              child: Text('Create an Account'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _signInWithGoogle,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.email),
                  SizedBox(
                    width: 10,
                  ),
                  Text('Sign in with Google'),
                ],
              ),
            ),
          ],
          ],
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
          backgroundColor: AppTheme.lightBlue,
          foregroundColor: AppTheme.darkGrey,
          title: Image.asset(
            "assets/images/logo.jpg",
            width: 230,
            height: 50,
          )),
      drawer: Drawer(
        backgroundColor: AppTheme.lightGrey,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(color: AppTheme.lightBlue),
              child: Text(
                  'My Profile',
                  style: TextStyle(
                      color: AppTheme.darkGrey,
                      fontSize: 24)
                  ),
            ),
            // ListTile(leading: Icon(Icons.person, color: darkGrey), title: Text('My Profile'), onTap: () {}),
            ListTile(leading: Icon(Icons.person), title: Text('My Profile'), onTap: () {}),
            ListTile(leading: Icon(Icons.send), title: Text('Missions Given'), onTap: () {}),
            ListTile(leading: Icon(Icons.reply), title: Text('Missions Taken'), onTap: () {}),
            ListTile(leading: Icon(Icons.calendar_today), title: Text('Calendar'), onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => CalendarPage()));}),
          ],

        ),
      ),
      backgroundColor: AppTheme.lightGrey,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Text('Welcome!',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.lightBlue),
                textAlign: TextAlign.center),
            SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HowItWorksPage()));
                },
                child: Text('How Does It Work?')),
            SizedBox(height: 10),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SendOnMissionPage()));
                },
                child: Text('Send On A Mission')),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SendOnMissionPage()));
                },
            SizedBox(height: 10),
            ElevatedButton(onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => ChooseMissionPage()));}, child: Text('Choose Your Mission')),
            SizedBox(height: 10),
            ElevatedButton(onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => ContactPage()));}, child: Text('Contact')),
          ],
        ),
      ),
    );
  }
}

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
              title: Image.asset("assets/images/Icon-192.png", width: 50, height: 50),
              backgroundColor: AppTheme.lightBlue),
          body: TableCalendar(focusedDay: DateTime.now(), firstDay: DateTime.utc(2010, 10, 16), lastDay: DateTime.utc(2030, 3, 14))),
    );
 }
}

class HowItWorksPage extends StatelessWidget {
  const HowItWorksPage({super.key});

  @override
  Widget build(BuildContext context) {   return Scaffold(
      appBar: AppBar(
          title: Image.asset("assets/images/logo.jpg", width: 230, height: 50),
          backgroundColor: AppTheme.lightBlue),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text('Explain the process of how the app works here.')));
  }
}

class SendOnMissionPage extends StatefulWidget {
  const SendOnMissionPage({super.key});

  @override
  State<SendOnMissionPage> createState() => _SendOnMissionPageState();
}

class _SendOnMissionPageState extends State<SendOnMissionPage> {
  String? _selectedCategory;
  DateTime _selectedDate = DateTime.now();

  // Function to handle mission category selection
   @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(title: Image.asset("web/icons/logo.jpg", width: 230, height: 50), backgroundColor: Color(0xFFADD8E6)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              DropdownButtonFormField<String>(
                items: ['Errands', 'Transportation/Delivery', 'Food', 'Social Interactions', 'Special Missions', 'Repairs'].map((String value) {
                  return DropdownMenuItem<String>(value: value, child: Text(value));

                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value;
                  });
                },
                decoration: InputDecoration(labelText: 'Mission Category'),
              ),
              SizedBox(height: 10),
              TextField(decoration: InputDecoration(labelText: 'Description')),
              SizedBox(height: 10),
              TextField(decoration: InputDecoration(labelText: 'Price (if applicable)')),
                SizedBox(height: 10),
                TextField(
                  decoration: InputDecoration(labelText: 'Due Date'),
                  onTap: () async {
                    // Show date picker on tap
                    final DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: _selectedDate,
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2100),
                    );
                    if (pickedDate != null && pickedDate != _selectedDate) {
                      setState(() {
                        _selectedDate = pickedDate;
                      });
                    }
                  },
                  readOnly: true,
                  controller: TextEditingController(text: DateFormat('yyyy-MM-dd').format(_selectedDate)),
                ),
              SizedBox(height: 10),

              TextField(decoration: InputDecoration(labelText: 'Criteria')),
              SizedBox(height: 20),
              ElevatedButton(onPressed: () {}, child: Text('Submit Mission')),
            ],
          ),
        ),
      ),
    );
  }
}

class ChooseMissionPage extends StatelessWidget {
  const ChooseMissionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Image.asset("assets/images/logo.jpg", width: 230, height: 50),
            backgroundColor: AppTheme.lightBlue),
        body: Padding(padding: const EdgeInsets.all(16.0), child: Text('List of available missions.')));
  }
}

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {    
    return Scaffold(
        appBar: AppBar(
            title: Image.asset("assets/images/logo.jpg", width: 230, height: 50),
            backgroundColor: AppTheme.lightBlue),
        body: Padding(padding: const EdgeInsets.all(16.0), child: Text('Contact information.')));
  }
}