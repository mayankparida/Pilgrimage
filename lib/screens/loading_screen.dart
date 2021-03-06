import 'package:com/screens/feed_screen.dart';
import 'welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoadingScreen extends StatefulWidget {
  static String id = "loading_screen";
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  //Checks for last stored email to keep user logged in
  getemail() async {
    //Shared Preferences used to store email of last logged in user and stays even after app is destroyed
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var email = prefs.getString('email');
    if (email != null) {
      Navigator.pushNamed(context, FeedScreen.id);
    } else {
      Navigator.pushNamed(context, WelcomeScreen.id);
    }
  }

  @override
  void initState() {
    super.initState();
    getemail();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitDualRing(
          color: Colors.tealAccent.shade700,
          size: 100.0,
        ),
      ),
    );
  }
}
