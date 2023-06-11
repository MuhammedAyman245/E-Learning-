import 'dart:io';
import 'package:e_learning_app/models/lec.dart';
import 'package:e_learning_app/services/store.dart';
import 'package:e_learning_app/widgets/textfield.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class AddLecture extends StatefulWidget {
  static const String id = 'lecture';
  @override
  _AddLectureState createState() => _AddLectureState();
}

class _AddLectureState extends State<AddLecture> {
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  String lecName, lecSub, lecDuration, lecLink;
  Store _store = Store();
  File _image;
  String downloaded;
  bool uploaded = false;
  getImage() async {
    var image =
        await ImagePicker.platform.pickVideo(source: ImageSource.gallery);

    File tempImage = File(image.path);
    setState(() {
      _image = tempImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black87,
      body: ModalProgressHUD(
        inAsyncCall: uploaded,
        child: Form(
          key: _key,
          child: ListView(
            children: [
              SizedBox(
                height: size.height * .06,
              ),
              Row(
                children: [
                  SizedBox(
                    width: size.width * .1,
                  ),
                  IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios_outlined,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                  SizedBox(
                    width: size.width * .1,
                  ),
                  Text(
                    'Add New Lecture ',
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        color: Colors.white),
                  ),
                ],
              ),
              SizedBox(
                height: size.height * .1,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                child: Container(
                  height: size.height * .7291,
                  width: size.width * .9,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40))),
                  child: Column(
                    children: [
                      SizedBox(
                        height: size.height * .020,
                      ),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(30, 5, 30, 10),
                          child: MyTextForm(
                            label: 'Subject',
                            onSaved: (value) {
                              lecSub = value;
                            },
                          )),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(30, 5, 30, 10),
                          child: MyTextForm(
                            label: 'Lecture Name',
                            onSaved: (value) {
                              lecName = value;
                            },
                          )),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(30, 5, 30, 10),
                          child: MyTextForm(
                            label: 'Duration',
                            onSaved: (value) {
                              lecDuration = value;
                            },
                          )),
                      GestureDetector(
                        onTap: () {
                          getImage();
                        },
                        child: Padding(
                            padding: EdgeInsets.fromLTRB(60, 0, 60, 20),
                            child: Container(
                              height: size.height * .1,
                              width: size.width,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Add Lecture'),
                                  Icon(Icons.star)
                                ],
                              ),
                            )),
                      ),
                      GestureDetector(
                        onTap: () async {
                          if (_key.currentState.validate()) {
                            _key.currentState.save();
                            setState(() {
                              uploaded = true;
                            });
                            _store.addLecture(Lectures(
                                duration: lecDuration,
                                link: lecLink,
                                sub: lecSub,
                                name: lecName));

                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content:
                                    Text('Your Lecture Data is Uploading')));
                            if (_image != null) {
                              downloaded = await _store.uploadImage(
                                  _image, 'Lectures', lecSub, lecName);
                            } else {
                              print('fuck');
                            }
                            if (downloaded == null) {
                              print('wait');
                            } else {
                              setState(() {
                                uploaded = false;
                              });
                              print(downloaded);
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Uploaded !')));
                            }
                          }
                        },
                        child: Container(
                          height: size.height * .07,
                          width: size.width * .2,
                          decoration: BoxDecoration(
                              color: Colors.black87,
                              borderRadius: BorderRadius.circular(40)),
                          child: Column(
                            children: [
                              Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                              Text(
                                'Add',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
