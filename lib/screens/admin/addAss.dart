import 'dart:io';

import 'package:e_learning_app/models/assignments.dart';
import 'package:e_learning_app/services/store.dart';
import 'package:e_learning_app/widgets/decoratedContainer.dart';
import 'package:e_learning_app/widgets/textfield.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class AddAssignment extends StatefulWidget {
  static const String id = 'addAss';
  @override
  _AddAssignmentState createState() => _AddAssignmentState();
}

class _AddAssignmentState extends State<AddAssignment> {
  File file;
  String subName;
  String assName;
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  String downloaded;
  Store _store = Store();
  bool isLoading = false;
  pickFile() async {
    FilePickerResult _file = await FilePicker.platform.pickFiles();
    if (_file != null) {
      File tempFile = File(_file.files.single.path);
      setState(() {
        file = tempFile;
      });
      print(file);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        key: _key,
        child: ModalProgressHUD(
          inAsyncCall: isLoading,
          child: DecoratedContainer(
            bodyColor: Colors.white,
            headColor: Colors.black87,
            image: 'images/back.png',
            subName: 'Add Assignment',
            child: ListView(
              children: [
                MyTextForm(
                    label: 'Subject Name',
                    onSaved: (value) {
                      subName = value;
                    }),
                SizedBox(height: size.height * .02),
                MyTextForm(
                    label: 'Assignment Name',
                    onSaved: (value) {
                      assName = value;
                    }),
                SizedBox(height: size.height * .02),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: GestureDetector(
                    onTap: () {
                      pickFile();
                    },
                    child: Container(
                      height: size.height * .06,
                      decoration: BoxDecoration(
                          color: Colors.black87,
                          borderRadius: BorderRadius.circular(20)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Pick A file',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic),
                          ),
                          SizedBox(
                            width: size.width * .02,
                          ),
                          Icon(
                            Icons.attach_file,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: size.height * .1),
                GestureDetector(
                  onTap: () async {
                    if (_key.currentState.validate()) {
                      setState(() {
                        isLoading = true;
                      });
                      _key.currentState.save();
                      _store.addAssignment(
                          Assignment(sub: subName, assName: assName));
                      if (file != null) {
                        downloaded = await _store.uploadImage(
                            file, 'Assignment', subName, assName);
                      }
                      if (downloaded != null) {
                        setState(() {
                          isLoading = false;
                        });
                      }
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text('Done !')));
                    }
                  },
                  child: Container(
                    child: Column(
                      children: [Icon(Icons.add), Text('Add')],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
