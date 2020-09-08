import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'welcome_screen.dart';

class FeedScreen extends StatefulWidget {
  static String id = "feed_screen";
  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final _auth = FirebaseAuth.instance;
  FirebaseUser loggedInUser;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
          actions: <Widget>[
            FlatButton(
              color: Colors.redAccent,
              child: Text(
                "Log Out",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                SharedPreferences pref = await SharedPreferences.getInstance();
                pref.remove("email");
                Navigator.popAndPushNamed(context, WelcomeScreen.id);
              },
            )
          ],
          title: Text(
            'Pilgrimage',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.red.shade500),
    );
  }
}
