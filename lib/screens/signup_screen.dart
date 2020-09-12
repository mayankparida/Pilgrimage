import 'package:flutter/material.dart';
import 'package:com/componenets/resources.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'feed_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpScreen extends StatefulWidget {
  static String id = 'signup_screen';
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool loadingSpinner = false;
  final _auth = FirebaseAuth.instance;
  String email;
  String password;
  String name;
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
              //Hero tag for Hero Animation on Logo
              Hero(
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
              RoundEntryName(
                  title: 'Enter your user id',
                  colour: Colors.tealAccent.shade700,
                  onChanged: (value) {
                    name = value;
                  }),
              SizedBox(
                height: 8.0,
              ),
              //Semi Custom Text Field : Code present in resources
              RoundEntryEmail(
                title: 'Enter your email',
                colour: Colors.tealAccent.shade700,
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
                colour: Colors.tealAccent.shade700,
                onChanged: (value) {
                  password = value;
                },
              ),
              SizedBox(
                height: 24.0,
              ),
              //Semi Custom Round Button : Code present in resources
              RoundButton(
                  title: 'SignUp',
                  colour: Colors.tealAccent.shade700,
                  //To create a new user
                  onPressed: () async {
                    setState(() {
                      loadingSpinner = true;
                    });
                    try {
                      final new_user =
                          await _auth.createUserWithEmailAndPassword(
                              email: email, password: password);
                      var Userupdateinfo = UserUpdateInfo();
                      Userupdateinfo.displayName = name;
                      await new_user.user.updateProfile(Userupdateinfo);
                      await new_user.user.reload();
                      if (new_user != null) {
                        storeemail();
                        Navigator.pushNamed(context, FeedScreen.id);
                      }
                      setState(() {
                        loadingSpinner = false;
                      });
                    } catch (e) {
                      print(e);
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
