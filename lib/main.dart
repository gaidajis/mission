import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/intl.dart';
import 'theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  @override
 Widget build(BuildContext context) {
     return MaterialApp(
      title: 'The Mission!',
      theme: ThemeData(
         fontFamily: 'Pacifico',
         primarySwatch: AppTheme.primarySwatch,
         scaffoldBackgroundColor: AppTheme.lightGrey,
        appBarTheme: AppBarTheme(
          backgroundColor: AppTheme.lightBlue,
          foregroundColor: AppTheme.darkGrey,
        ),
         elevatedButtonTheme:AppTheme.elevatedButtonThemeData ,
         inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10)
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFADD8E6))
          ),
        )),
       home: LoginPage(),
    );




  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> _signInWithEmailAndPassword() async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text);
      if (!context.mounted) return;
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    } on FirebaseAuthException catch (e) {
      if (!context.mounted) return;
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
            title: Text('Error'), content: Text(e.message ?? 'An error occurred')),
      );
    }
  }

  Future<void> _createUserWithEmailAndPassword() async {
    try {
     await _auth.createUserWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text);
    } on FirebaseAuthException catch (e) {
      if (!context.mounted) return;
      showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(title: Text('Error'), content: Text(e.message ?? 'An error occurred')),
    );
    }
  }

  Future<void> _signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
       final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await _auth.signInWithCredential(credential).then((value) {
        if (!context.mounted) return;
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
      });
    } catch (e) {
      if (!context.mounted) return;
      showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(title: Text('Error'), content: Text(e.toString()))
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Image.asset("assets/images/logo.jpg", width: 230, height: 50),

          backgroundColor: AppTheme.lightBlue),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty || !value.contains('@')) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _passwordController,
                 decoration: const InputDecoration(labelText: 'Password'),
                    obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
              ),
              ElevatedButton(
                onPressed: _signInWithEmailAndPassword,
                child: const Text('Login'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _createUserWithEmailAndPassword,
                child: const Text('Create an Account'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                 onPressed: _signInWithGoogle,
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.email),
                    SizedBox(width: 10),
                    Text('Sign in with Google'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
          backgroundColor: AppTheme.lightBlue,
          foregroundColor: AppTheme.darkGrey, title: Image.asset(
            "assets/images/logo.jpg",
            width: 230,
            height: 50,)),
      drawer: Drawer(
        backgroundColor: AppTheme.lightGrey,
        child: ListView(
            padding: EdgeInsets.zero, children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(color: AppTheme.lightBlue),
            child: Text('My Profile',
                style: TextStyle(color: AppTheme.darkGrey, fontSize: 24)),
          ),
          ListTile(
              leading: Icon(Icons.person), title: Text('My Profile'), onTap: () {}),
          ListTile(leading: Icon(Icons.send), title: Text('Missions Given'), onTap: () {}),
          ListTile(leading: Icon(Icons.reply), title: Text('Missions Taken'), onTap: () {}),
          ListTile(leading: Icon(Icons.calendar_today), title: Text('Calendar'),
              onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => CalendarPage()));
          }),
        ]),
      ),
      backgroundColor: AppTheme.lightGrey,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Text('Welcome!', style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppTheme.lightBlue),
                textAlign: TextAlign.center),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(
                          builder: (context) => HowItWorksPage()));
                },
                child: const Text('How Does It Work?')),
            const SizedBox(height: 10),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SendOnMissionPage()));
                },
                child: const Text('Send On A Mission')),
            const SizedBox(height: 10),

            const SizedBox(height: 10),
            ElevatedButton(onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ChooseMissionPage()));
            }, child: const Text('Choose Your Mission')),
            const SizedBox(height: 10),
            ElevatedButton(onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ContactPage()));
            }, child: const Text('Contact')),
          ],
        ),
      ),
    );
  }
}

class CalendarPage extends StatelessWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(title: Image.asset("assets/images/logo.jpg", width: 230, height: 50), backgroundColor: AppTheme.lightBlue),
       backgroundColor: AppTheme.lightGrey,
        body: TableCalendar(focusedDay: DateTime.now(), firstDay: DateTime.utc(2010, 10, 16), lastDay: DateTime.utc(2030, 3, 14)));
 }
}

class HowItWorksPage extends StatelessWidget {
  const HowItWorksPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Image.asset("assets/images/logo.jpg", width: 230, height: 50),
          backgroundColor: AppTheme.lightBlue),
      body: const Padding(padding: EdgeInsets.all(16.0), child: Text('Explain the process of how the app works here.'))
    );
  }
}

class SendOnMissionPage extends StatefulWidget {
  const SendOnMissionPage({Key? key}) : super(key: key);


  @override
  State<SendOnMissionPage> createState() => _SendOnMissionPageState();
}

class _SendOnMissionPageState extends State<SendOnMissionPage> { @override
  void initState() {
    super.initState();
    _dueDateController.text = DateFormat('yyyy-MM-dd').format(_selectedDate);
  }

  @override
  void dispose() {
    _dueDateController.dispose();
    super.dispose();
  }
  String? _selectedCategory;
  DateTime _selectedDate = DateTime.now();
    final TextEditingController _dueDateController = TextEditingController();
    @override
  Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(title: Image.asset("assets/images/logo.jpg", width: 230, height: 50), backgroundColor: AppTheme.lightBlue),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              DropdownButtonFormField<String>(
                items: ['Errands', 'Transportation/Delivery', 'Food', 'Social Interactions', 'Special Missions', 'Repairs'].map((String value) {
                  return DropdownMenuItem<String>(value: value, child: Text(value));
                }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    _selectedCategory = value;
                  });},
                decoration: InputDecoration(labelText: 'Mission Category'),
                ),
               SizedBox(height: 10),
              TextField(decoration: InputDecoration(labelText: 'Description')),
              const SizedBox(height: 10),
              TextField(decoration: InputDecoration(labelText: 'Price (if applicable)')),
              const SizedBox(height: 10),
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
                        _selectedDate = pickedDate;
                      _dueDateController.text =
                           DateFormat('yyyy-MM-dd').format(_selectedDate);
                    }
                  },
                   controller: _dueDateController,
                ),
               SizedBox(height: 10),
              TextField(decoration: InputDecoration(labelText: 'Criteria')),
               SizedBox(height: 20),
              ElevatedButton(onPressed: () {}, child: const Text('Submit Mission')),
            ],
          ),
        ),
      ),
    );
  }

}

class ChooseMissionPage extends StatelessWidget {
  const ChooseMissionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Image.asset("assets/images/logo.jpg", width: 230, height: 50), backgroundColor: AppTheme.lightBlue),
        body: const Padding(padding: EdgeInsets.all(16.0), child: Text('List of available missions.')));
  }
}

class ContactPage extends StatelessWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Image.asset("assets/images/logo.jpg", width: 230, height: 50),
            backgroundColor: AppTheme.lightBlue),
        body: const Padding(padding: EdgeInsets.all(16.0), child: Text('Contact information.')));
  }
}