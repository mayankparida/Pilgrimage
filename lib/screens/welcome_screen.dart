import 'package:flutter/material.dart';
import 'signup_screen.dart';
import 'login_screen.dart';
import 'package:com/componenets/resources.dart';

class WelcomeScreen extends StatefulWidget {
  static String id = 'welcome_screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  //Animation for the app logo
  AnimationController controller;
  Animation animation;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: Duration(seconds: 2), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.bounceOut);
    controller.forward();
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  //Hero tag for Hero Animation on Logo
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/Pilgrimage_logo.png'),
                    height: animation.value * 50,
                  ),
                ),
                Center(
                  child: Text(
                    "Pilgrimage",
                    style: TextStyle(
                        fontSize: 40.0,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Pacifico"),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            //Semi Custom Round Button : Code present in resources
            RoundButton(
              title: 'Login',
              colour: Colors.blue.shade900,
              onPressed: () {
                Navigator.pushNamed(context, LoginScreen.id);
              },
            ),
            //Semi Custom Round Button : Code present in resources
            RoundButton(
              title: 'SignUp',
              colour: Colors.tealAccent.shade700,
              onPressed: () {
                Navigator.pushNamed(context, SignUpScreen.id);
              },
            )
          ],
        ),
      ),
    );
  }
}
