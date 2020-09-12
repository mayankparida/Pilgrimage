import 'dart:async';
import 'dart:core';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'welcome_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:image_cropper/image_cropper.dart';
import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:com/componenets/resources.dart';

class FeedScreen extends StatefulWidget {
  static String id = "feed_screen";
  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  File _image;
  bool _isUploading = false;
  bool _isUploadCompleted = false;
  double _uploadProgress = 0;
  int _current_index = 0;
  FirebaseUser loggedInUser;
  String name;
  int Length;
  List ispressed = new List();
  bool isLoading = true;
  List<DocumentSnapshot> posts;
  List<Widget> body = <Widget>[];

  // firebase
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _db = Firestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  //To get all feed posts from Firebase Cloud Firestore
  getfeed() async {
    try {
      setState(() {
        isLoading = true;
      });
      QuerySnapshot snap = await _db
          .collection("posts")
          .orderBy("date", descending: true)
          .getDocuments();
      setState(() {
        posts = snap.documents;
        Length = posts.length;
        for (int i = 0; i < Length; i++) {
          ispressed.add(0);
        }
        isLoading = false;
      });
    } catch (e) {
      print(e);
    }
  }

  //To upload image from device gallery
  uploadImage() async {
    //Permission to access device gallery
    await Permission.photos.request();
    //To pick image from gallery
    var image = await ImagePicker.pickImage(
      source: ImageSource.gallery,
    );
    //To allow user to crop image
    File croppedImage = await ImageCropper.cropImage(
        sourcePath: image.path,
        compressQuality: 40,
        aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: "Crop Image",
            toolbarColor: Colors.tealAccent.shade700,
            toolbarWidgetColor: Colors.white,
            statusBarColor: Colors.tealAccent.shade700,
            activeControlsWidgetColor: Colors.tealAccent.shade700));
    _image = croppedImage;
    try {
      if (_image != null) {
        setState(() {
          _isUploading = true;
        });

        FirebaseUser user = await _auth.currentUser();

        String fileName = DateTime.now().millisecondsSinceEpoch.toString() +
            basename(_image.path);
        //To store image to Firebase Storage
        final StorageReference storageReference =
            _storage.ref().child("posts").child(user.uid).child(fileName);

        final StorageUploadTask uploadTask = storageReference.putFile(_image);

        StorageTaskSnapshot onComplete = await uploadTask.onComplete;
        //Getting image Url from Firebase Storage
        String photoUrl = await onComplete.ref.getDownloadURL();
        //Storing image url, user id in cloud firestore
        _db.collection("posts").add({
          "photoUrl": photoUrl,
          "name": user.displayName,
          "liked": 0,
          "date": DateTime.now(),
          "uploadedBy": user.uid
        });

        // when completed
        setState(() {
          _isUploading = false;
          _isUploadCompleted = true;
        });

        getfeed();
      }
    } catch (e) {
      print(e);
    }
  }

  //To upload image from device camera
  uploadCamera() async {
    //Permission to access device camera
    await Permission.camera.request();
    //To pick image from camera
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    //To allow user to crop image
    File croppedImage = await ImageCropper.cropImage(
        sourcePath: image.path,
        compressQuality: 40,
        aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: "Crop Image",
            toolbarColor: Colors.tealAccent.shade700,
            toolbarWidgetColor: Colors.white,
            statusBarColor: Colors.tealAccent.shade700,
            activeControlsWidgetColor: Colors.tealAccent.shade700));
    _image = croppedImage;
    try {
      if (_image != null) {
        setState(() {
          _isUploading = true;
        });

        FirebaseUser user = await _auth.currentUser();

        String fileName = DateTime.now().millisecondsSinceEpoch.toString() +
            basename(_image.path);
        //To store image to Firebase Storage
        final StorageReference storageReference =
            _storage.ref().child("posts").child(user.uid).child(fileName);

        final StorageUploadTask uploadTask = storageReference.putFile(_image);

        StorageTaskSnapshot onComplete = await uploadTask.onComplete;
        //Getting image Url from Firebase Storage
        String photoUrl = await onComplete.ref.getDownloadURL();
        //Storing image url, user id in cloud firestore
        _db.collection("posts").add({
          "photoUrl": photoUrl,
          "name": user.displayName,
          "date": DateTime.now(),
          "uploadedBy": user.uid
        });
        // when completed
        setState(() {
          _isUploading = false;
          _isUploadCompleted = true;
        });
        getfeed();
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    getfeed();
  }

  //To identify current user
  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
        setState(() {
          name = loggedInUser.displayName;
        });
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
                //To forget email which was saved using Shared Preferences to keep user logged out
                SharedPreferences pref = await SharedPreferences.getInstance();
                pref.remove("email");
                Navigator.popAndPushNamed(context, WelcomeScreen.id);
              },
            )
          ],
        ),
        body: isLoading
            ? Container(
                child: LinearProgressIndicator(),
              )
            : (_current_index != 3) //When not Settings page
                ? RefreshIndicator(
                    onRefresh: () {
                      getfeed();
                      return null;
                    },
                    child: ListView.builder(
                      itemCount: Length,
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
                                    SizedBox(width: 10.0),
                                    new Text(
                                      posts[index].data[
                                          "name"], //user id of uploaded post
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17.0,
                                          fontFamily: "Pacifico",
                                          letterSpacing: 1.0),
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
                            child: GestureDetector(
                              onDoubleTap: () {
                                setState(() {
                                  if (ispressed[index] == 0) {
                                    ispressed[index] = 1;
                                  }
                                });
                              },
                              child: FadeInImage(
                                placeholder:
                                    AssetImage('images/Pilgrimage_logo.png'),
                                image: NetworkImage(posts[index]
                                    .data["photoUrl"]), //uploaded post
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                new Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    new IconButton(
                                      icon: new Icon(Icons.favorite),
                                      color: ispressed[index] == 1
                                          ? Colors.red
                                          : Colors.white,
                                      onPressed: () {
                                        setState(() {
                                          if (ispressed[index] == 0) {
                                            ispressed[index] = 1;
                                          } else {
                                            ispressed[index] = 0;
                                          }
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
                  )
                : Settings(name: name),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          unselectedItemColor: Colors.white,
          selectedItemColor: Colors.tealAccent.shade700,
          currentIndex:
              _current_index, //To highlight selected section in navigation bar
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                title: Text(
                  "Feed",
                  style: TextStyle(fontFamily: "Pacifico"),
                )),
            BottomNavigationBarItem(
                icon: Icon(Icons.camera),
                title: Text(
                  "Camera",
                  style: TextStyle(fontFamily: "Pacifico"),
                )),
            BottomNavigationBarItem(
                icon: Icon(Icons.add_box),
                title: Text(
                  "Upload",
                  style: TextStyle(fontFamily: "Pacifico"),
                )),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                title: Text(
                  "Settings",
                  style: TextStyle(fontFamily: "Pacifico"),
                )),
          ],
          onTap: (index) {
            setState(() {
              _current_index = index;
            });
            if (_current_index == 1) {
              uploadCamera();
              setState(() {
                _current_index = 0;
              });
            } else if (_current_index == 2) {
              uploadImage();
              setState(() {
                _current_index = 0;
              });
            }
          },
        ));
  }
}
