import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_core/firebase_core.dart';// Add this line

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'The Mission!', //change theme parameter to ThemeData
        
        theme: ThemeData( //change theme parameter to ThemeData
          fontFamily: 'Pacifico',
        primarySwatch: MaterialColor(0xFFADD8E6, <int, Color>{
          50: Color(0xFFE3F2FD),
          100: Color(0xFFBBDEFB),
          200: Color(0xFF90CAF9),
          300: Color(0xFF64B5F6),
          400: Color(0xFF42A5F5),
          500: Color(0xFFADD8E6),
          600: Color(0xFF1E88E5),
          700: Color(0xFF1976D2),
          800: Color(0xFF1565C0),
          900: Color(0xFF0D47A1),
        }),
          scaffoldBackgroundColor: Colors.grey[100],
          appBarTheme: AppBarTheme(
            backgroundColor: Color(0xFFADD8E6),
            foregroundColor: Colors.black87,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFADD8E6),
              foregroundColor: Colors.black87,
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
   final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Future<void> _signInWithEmailAndPassword() async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
    } catch (e) {
      // Handle error
      if (!context.mounted) return; showDialog(context: context, builder: (context) => AlertDialog(title: Text('Error'), content: Text(e.toString()),));
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
      if (!context.mounted) return; showDialog(context: context, builder: (context) => AlertDialog(title: Text('Error'), content: Text(e.toString()),));
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
      key: formKey,
      appBar: AppBar(title: Image.asset("web/logo/logo.jpg", width: 230, height: 50), backgroundColor: Color(0xFFADD8E6)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 10),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
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
                children: [Icon(Icons.email), SizedBox(width: 10,),Text('Sign in with Google'),],
              ),
            )
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
    const lightBlue = Color(0xFFADD8E6);
    const darkGrey = Colors.black87;
    const lightGrey = Colors.grey;
    return Scaffold(
      appBar: AppBar(backgroundColor: lightBlue,
        foregroundColor: darkGrey,
          title:  Image.asset("web/logo/logo.jpg",
             width: 230,

            height: 50,
          )),
      drawer: Drawer(
        backgroundColor: lightGrey[100],
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(color: lightBlue),
              child: Text(
                  'My Profile',
                  style: TextStyle(
                      color: darkGrey,
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
      backgroundColor: lightGrey[100],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Text('Welcome!',
                style: TextStyle(
                    fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFFADD8E6)),
                textAlign: TextAlign.center),
            SizedBox(height: 20),
            ElevatedButton(onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => HowItWorksPage()));}, child: Text('How Does It Work?')),
            SizedBox(height: 10),
            ElevatedButton(onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => SendOnMissionPage()));}, child: Text('Send On A Mission')),
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

class CalendarPage extends StatelessWidget{
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar( backgroundColor: Color(0xFFADD8E6),
        middle: const Text("Calendar"),
      ),
        child: Scaffold(
          appBar: AppBar(title: Image.asset("web/icons/Icon-192.png", width: 50, height: 50), backgroundColor: Color(0xFFADD8E6)),
          body: TableCalendar(focusedDay: DateTime.now(), firstDay: DateTime.utc(2010, 10, 16), lastDay: DateTime.utc(2030, 3, 14))),
    );
 }
}

class HowItWorksPage extends StatelessWidget {
  const HowItWorksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Image.asset("web/logo/logo.jpg", width: 230, height: 50), backgroundColor: Color(0xFFADD8E6)), body: Padding(padding: const EdgeInsets.all(16.0), child: Text('Explain the process of how the app works here.')));
  }
}

class SendOnMissionPage extends StatelessWidget {
  const SendOnMissionPage({super.key});

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
                onChanged: (_) {},
                decoration: InputDecoration(labelText: 'Mission Category'),
              ),
              SizedBox(height: 10),
              TextField(decoration: InputDecoration(labelText: 'Description')),
              SizedBox(height: 10),
              TextField(decoration: InputDecoration(labelText: 'Price (if applicable)')),
              SizedBox(height: 10),
              TextField(decoration: InputDecoration(labelText: 'Due Date'), onTap: (){},),
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
    return Scaffold(appBar: AppBar(title: Image.asset("web/logo/logo.jpg", width: 230, height: 50), backgroundColor: Color(0xFFADD8E6)), body: Padding(padding: const EdgeInsets.all(16.0), child: Text('List of available missions.')));
  }
}

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {    
    return Scaffold(appBar: AppBar(title: Image.asset("web/logo/logo.jpg", width: 230, height: 50), backgroundColor: Color(0xFFADD8E6)), body: Padding(padding: const EdgeInsets.all(16.0), child: Text('Contact information.')));
  }
}