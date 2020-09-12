import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:com/screens/welcome_screen.dart';

class RoundButton extends StatelessWidget {
  //Constructor to assign Button title, colour and it's function
  RoundButton({this.title, this.colour, @required this.onPressed});

  final Color colour;
  final String title;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: colour,
        borderRadius: BorderRadius.circular(16.0),
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            title,
            style: TextStyle(fontFamily: "Pacifico", fontSize: 20.0),
          ),
        ),
      ),
    );
  }
}

class RoundEntryEmail extends StatelessWidget {
  //Constructor to assign Text Field title, colour and it's function
  RoundEntryEmail({this.title, this.colour, @required this.onChanged});
  final String title;
  final Color colour;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.emailAddress,
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.white),
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: title,
        hintStyle: TextStyle(color: Colors.grey),
        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: colour, width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: colour, width: 2.0),
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
        ),
      ),
    );
  }
}

class RoundEntryPassword extends StatelessWidget {
  //Constructor to assign Text Field title, colour and it's function
  RoundEntryPassword({this.title, this.colour, @required this.onChanged});
  final String title;
  final Color colour;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: true,
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.white),
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: title,
        hintStyle: TextStyle(color: Colors.grey),
        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: colour, width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: colour, width: 2.0),
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
        ),
      ),
    );
  }
}

class RoundEntryName extends StatelessWidget {
  //Constructor to assign Text Field title, colour and it's function
  RoundEntryName({this.title, this.colour, @required this.onChanged});
  final String title;
  final Color colour;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.text,
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.white),
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: title,
        hintStyle: TextStyle(color: Colors.grey),
        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: colour, width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: colour, width: 2.0),
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
        ),
      ),
    );
  }
}

//Settings Page used in Feed Screen
class Settings extends StatelessWidget {
  //Constructor that takes user id to display in settings page
  Settings({this.name});
  final String name;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade900,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              radius: 40.0,
              backgroundColor: Colors.white10,
              child: Icon(
                Icons.perm_identity,
                color: Colors.tealAccent.shade700,
                size: 40.0,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              name,
              style: TextStyle(
                  fontFamily: "Pacifico",
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 80.0),
              child: Divider(
                color: Colors.tealAccent.shade700,
                thickness: 1.0,
              ),
            ),
            FlatButton(
              child: Text(
                "Change Userid",
                style: TextStyle(color: Colors.white38),
              ),
              onPressed: () {},
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 80.0),
              child: Divider(
                color: Colors.tealAccent.shade700,
                thickness: 1.0,
              ),
            ),
            FlatButton(
              child: Text(
                "Change Password",
                style: TextStyle(color: Colors.white38),
              ),
              onPressed: () {},
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 80.0),
              child: Divider(
                color: Colors.tealAccent.shade700,
                thickness: 1.0,
              ),
            ),
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
        ),
      ),
    );
  }
}
