import 'feed_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:com/componenets/resources.dart';
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
  //Using Shared Preferences to store mail of last logged in user
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
              Hero(
                //Hero tag for Hero Animation on Logo
                tag: 'logo',
                child: Container(
                  height: 100.0,
                  child: Image.asset('images/Pilgrimage_logo.png'),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              //Semi Custom Text Field : Code present in resources
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
              //Semi Custom Text Field : Code present in resources
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
              //Error message in case of invalid email input
              Center(
                child: Text(
                  message,
                  style: TextStyle(color: Colors.red),
                ),
              ),
              SizedBox(
                height: 24.0,
              ),
              //Semi Custom Round Button : Code present in resources
              RoundButton(
                  title: 'Login',
                  colour: Colors.blue.shade900,
                  //Authenticate user and push user to Feed Screen
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
