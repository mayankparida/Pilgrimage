import 'feed_screen.dart';
import 'package:flutter/material.dart';
import 'signup_screen.dart';
import 'login_screen.dart';
import 'package:com/componenets/buttons.dart';

class WelcomeScreen extends StatefulWidget {
  static String id = 'welcome_screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
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
//                Hero(
//                  tag: 'logo',
//                  child: Container(
//                    child: Image.asset('images/pokemon_logo.png'),
//                    height: animation.value * 50,
//                  ),
//                ),
                Center(
                  child: Text(
                    "Pilgrimage",
                    style:
                        TextStyle(fontSize: 40.0, fontWeight: FontWeight.w900),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            RoundButton(
              title: 'Login',
              colour: Colors.blue.shade900,
              onPressed: () {
                Navigator.pushNamed(context, LoginScreen.id);
              },
            ),
            RoundButton(
              title: 'SignUp',
              colour: Colors.red.shade500,
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
