import 'package:com/screens/feed_screen.dart';
import 'package:com/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart';
import 'screens/login_screen.dart';
import 'screens/loading_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //Setting the basic theme of the app to be dark
      theme: ThemeData.dark().copyWith(
          textTheme: TextTheme(
            body1: TextStyle(color: Colors.white),
          ),
          primaryColor: Colors.tealAccent.shade700),
      initialRoute: LoadingScreen.id, //Initial route of the app
      //All possible routes in the app
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        SignUpScreen.id: (context) => SignUpScreen(),
        FeedScreen.id: (context) => FeedScreen(),
        LoadingScreen.id: (context) => LoadingScreen()
      },
    );
  }
}
