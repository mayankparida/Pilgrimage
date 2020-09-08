import 'feed_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:com/componenets/buttons.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool loadingSpinner = false;
  final _auth = FirebaseAuth.instance;
  String email;
  String password;
  String message = '';
  storeemail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("email", email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: ModalProgressHUD(
        inAsyncCall: loadingSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Center(
                child: Text(
                  "Pilgrimage",
                  style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.w900),
                ),
              ),
//              Hero(
//                tag: 'logo',
//                child: Container(
//                  height: 100.0,
//                  child: Image.asset('images/pokemon_logo.png'),
//                ),
//              ),
              SizedBox(
                height: 48.0,
              ),
              RoundEntryEmail(
                title: 'Enter your email',
                colour: Colors.blue.shade900,
                onChanged: (value) {
                  email = value;
                },
              ),
              SizedBox(
                height: 8.0,
              ),
              RoundEntryPassword(
                title: 'Enter your password',
                colour: Colors.blue.shade900,
                onChanged: (value) {
                  password = value;
                },
              ),
              SizedBox(
                height: 8.0,
              ),
              Center(
                child: Text(
                  message,
                  style: TextStyle(color: Colors.red),
                ),
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundButton(
                  title: 'Login',
                  colour: Colors.blue.shade900,
                  onPressed: () async {
                    setState(() {
                      loadingSpinner = true;
                    });
                    try {
                      final user = await _auth.signInWithEmailAndPassword(
                          email: email, password: password);
                      if (user != null) {
                        storeemail();
                        Navigator.pushNamed(context, FeedScreen.id);
                      }
                      setState(() {
                        loadingSpinner = false;
                      });
                    } catch (e) {
                      setState(() {
                        loadingSpinner = false;
                        message =
                            'Oops!You have entered an invalid email or password!';
                      });
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
