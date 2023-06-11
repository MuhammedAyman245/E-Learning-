import 'dart:io';
import 'package:e_learning_app/screens/users/bar.dart';
import 'package:e_learning_app/services/store.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class Profile extends StatefulWidget {
  static const String id = 'profile';
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  Store _store = Store();
  String url;
  String downloaded;
  File _image;
  String profilePic;
  bool isLoading = false;

  getImage() async {
    var image =
        await ImagePicker.platform.pickImage(source: ImageSource.gallery);
    File tempImage = File(image.path);
    setState(() {
      _image = tempImage;
    });
    print(image.path);
  }

  Future<String> loadData() async {
    try {
      String img;
      img = await _store.loadImage(
          'Users', 'Profile Pictures', _auth.currentUser.email);

      if (url == null) {
        print('wait');
      } else {
        print(url);
      }
      setState(() {
        url = img;
      });

      return url;
    } catch (e) {}
  }

  @override
  void initState() {
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.grey[100],
        body: ModalProgressHUD(
          inAsyncCall: isLoading,
          child: ListView(
            children: [
              SizedBox(height: size.height * .02),
              Row(
                children: [
                  IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios_rounded,
                        size: 30,
                      ),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Bar()));
                      }),
                  SizedBox(
                    width: size.width * .25,
                  ),
                  Text(
                    'Profile',
                    style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Colors.black),
                  ),
                ],
              ),
              SizedBox(
                height: size.height * .04,
              ),
              url != null
                  ? Center(
                      child: Stack(
                        children: [
                          Container(
                            height: size.height * .25,
                            width: size.width * .5,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                image:
                                    DecorationImage(image: NetworkImage(url)),
                                shape: BoxShape.circle),
                          ),
                          Positioned(
                              left: 145,
                              bottom: 10,
                              child: GestureDetector(
                                onTap: () async {
                                  await getImage();
                                  setState(() {
                                    isLoading = true;
                                  });
                                  downloaded = await _store.uploadImage(
                                      _image,
                                      'Users',
                                      'Profile Pictures',
                                      _auth.currentUser.email);
                                  print(downloaded);
                                  setState(() {
                                    url = downloaded;
                                  });
                                  setState(() {
                                    isLoading = false;
                                  });
                                },
                                child: Opacity(
                                  opacity: 0.7,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.black,
                                    child: Center(
                                      child: Icon(
                                        Icons.camera_alt_rounded,
                                        size: 30,
                                        color: Colors.white,
                                      ),
                                    ),
                                    radius: 25,
                                  ),
                                ),
                              )),
                        ],
                      ),
                    )
                  : Container(),
              SizedBox(
                height: size.height * .02,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 0, 0, 10),
                child: Text(
                  'Name : ${_auth.currentUser.displayName}',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 0, 0, 10),
                child: Text(
                  'Email : ${_auth.currentUser.email}',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ));
  }
}
