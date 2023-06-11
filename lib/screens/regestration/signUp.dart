import 'dart:io';
import 'package:e_learning_app/screens/regestration/signin.dart';
import 'package:e_learning_app/screens/users/bar.dart';
import 'package:e_learning_app/services/auth.dart';
import 'package:e_learning_app/services/store.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:e_learning_app/widgets/textfield.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignUp extends StatefulWidget {
  static const String id = 'SignUp';
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  String email, password, name;
  Auth _auth = Auth();
  Store _store = Store();
  bool isLoading = false;
  File _image;
  String profilePic;
  String downloaded;
  UploadTask task;
  getImage() async {
    var image =
        await ImagePicker.platform.pickImage(source: ImageSource.gallery);
    File tempImage = File(image.path);
    setState(() {
      _image = tempImage;
      profilePic = image.path;
    });
    print(image.path);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Form(
        key: _key,
        child: SafeArea(
          child: Scaffold(
              backgroundColor: Colors.lightBlue[200],
              body: ModalProgressHUD(
                inAsyncCall: isLoading,
                child: Container(
                  height: size.height,
                  width: size.width,
                  child: ListView(
                    children: [
                      Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(50, 0, 50, 6),
                            child: Container(
                              height: size.height * .25,
                              width: size.width,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage('images/welcome.png')),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(50, 220, 50, 0),
                            child: Container(
                              height: size.height * .69,
                              width: size.width * .9,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(30),
                                      topRight: Radius.circular(5),
                                      bottomLeft: Radius.circular(5),
                                      bottomRight: Radius.circular(30))),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      getImage();
                                      print(_image.path);
                                    },
                                    child: Container(
                                      height: size.height * .15,
                                      width: size.width * .5,
                                      child: _image != null
                                          ? Text('')
                                          : Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'Add Image',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                SizedBox(
                                                  height: 15,
                                                ),
                                                Icon(Icons.add)
                                              ],
                                            ),
                                      decoration: _image != null
                                          ? BoxDecoration(
                                              color: Colors.blue[900],
                                              image: DecorationImage(
                                                image: FileImage(_image),
                                              ),
                                              shape: BoxShape.circle)
                                          : BoxDecoration(
                                              color: Colors.blue[200],
                                              shape: BoxShape.circle),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 20, right: 15, left: 15),
                                    child: MyTextField(
                                      onSaved: (value) {
                                        name = value;
                                      },
                                      hint: 'Mohamed Ayman',
                                      label: 'Name',
                                      icon: Icon(
                                        Icons.account_circle,
                                        color: Colors.blue[900],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 15, left: 15),
                                    child: MyTextField(
                                      onSaved: (value) {
                                        email = value;
                                      },
                                      hint: 'account@gmail.com',
                                      label: 'Email',
                                      icon: Icon(
                                        Icons.account_box_rounded,
                                        color: Colors.blue[900],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 15, left: 15),
                                    child: MyTextField(
                                      onSaved: (value) {
                                        password = value;
                                      },
                                      hint: 'Password',
                                      label: 'Password',
                                      icon: Icon(
                                        Icons.lock,
                                        color: Colors.blue[900],
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      if (_key.currentState.validate()) {
                                        _key.currentState.save();
                                        setState(() {
                                          isLoading = true;
                                        });

                                        try {
                                          final user =
                                              await _auth.signUpWithEmail(
                                                  name, email, password);
                                          if (_image != null) {
                                            downloaded =
                                                await _store.uploadImage(
                                                    _image,
                                                    'Users',
                                                    'Profile Pictures',
                                                    email);
                                          } else {
                                            print('fuck');
                                          }

                                          setState(() {
                                            isLoading = false;
                                          });
                                          Navigator.pushNamed(context, Bar.id);
                                        } catch (e) {
                                          print(e);
                                        }
                                      }
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          60, 8, 60, 0),
                                      child: Container(
                                        child: Center(
                                            child: Text(
                                          'SignUp',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        )),
                                        width: size.width * .3,
                                        height: size.height * .06,
                                        decoration: BoxDecoration(
                                            color: Colors.blue[900],
                                            borderRadius:
                                                BorderRadius.circular(30)),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(20, 10, 0, 5),
                                    child: Row(
                                      children: [
                                        Text(
                                          'Already have an account?',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 15),
                                        ),
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pushNamed(
                                                  context, SignIn.id);
                                            },
                                            child: Text(
                                              'SignIn',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15),
                                            ))
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )),
        ));
  }
}
