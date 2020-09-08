import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'welcome_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FeedScreen extends StatefulWidget {
  static String id = "feed_screen";
  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  bool isPressed = false;
  int _current_index = 0;
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
          leading: Image.asset('images/Pilgrimage_logo.png'),
          title: Text("Pilgrimage",
              style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.w500,
                  fontFamily: "Pacifico")),
          backgroundColor: Colors.tealAccent.shade700,
          actions: <Widget>[
            RaisedButton(
              color: Colors.redAccent,
              child: Icon(Icons.exit_to_app),
              onPressed: () async {
                SharedPreferences pref = await SharedPreferences.getInstance();
                pref.remove("email");
                Navigator.popAndPushNamed(context, WelcomeScreen.id);
              },
            )
          ],
        ),
        body: ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) => Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        new Text(
                          "Mayank",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    new IconButton(
                      icon: Icon(Icons.more_vert),
                      onPressed: null,
                    )
                  ],
                ),
              ),
              Flexible(
                fit: FlexFit.loose,
                child: new Image.network(
                  "https://images.pexels.com/photos/672657/pexels-photo-672657.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new IconButton(
                          icon: new Icon(Icons.favorite),
                          color: isPressed ? Colors.red : Colors.white,
                          onPressed: () {
                            setState(() {
                              isPressed = !isPressed;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Divider(
                color: Colors.white30,
                thickness: 5.0,
              )
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          unselectedItemColor: Colors.white,
          selectedItemColor: Colors.tealAccent.shade700,
          currentIndex: _current_index,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                title: Text(
                  "Feed",
                  style: TextStyle(fontFamily: "Pacifico"),
                )),
            BottomNavigationBarItem(
                icon: Icon(Icons.add_box),
                title: Text(
                  "Upload",
                  style: TextStyle(fontFamily: "Pacifico"),
                )),
            BottomNavigationBarItem(
                icon: Icon(Icons.perm_identity),
                title: Text(
                  "Profile",
                  style: TextStyle(fontFamily: "Pacifico"),
                ))
          ],
          onTap: (index) {
            setState(() {
              _current_index = index;
            });
          },
        ));
  }
}
