import 'package:e_learning_app/models/lec.dart';
import 'package:e_learning_app/services/store.dart';
import 'package:e_learning_app/widgets/textfield.dart';
import 'package:flutter/material.dart';

class EditLec extends StatefulWidget {
  static const String id = 'edit lec';
  @override
  _EditLecState createState() => _EditLecState();
}

class _EditLecState extends State<EditLec> {
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  String lecName, lecSub, lecDuration, lecLink;
  Store _store = Store();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    Lectures lectures = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      backgroundColor: Colors.black87,
      body: Form(
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
                  'Edit the Lecture ',
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
                    Padding(
                        padding: const EdgeInsets.fromLTRB(30, 5, 30, 10),
                        child: MyTextForm(
                          label: 'Lecture',
                          onSaved: (value) {
                            lecLink = value;
                          },
                        )),
                    GestureDetector(
                      onTap: () {
                        if (_key.currentState.validate()) {
                          _key.currentState.save();
                          _store.editLec(
                              lectures.id,
                              Lectures(
                                  duration: lecDuration,
                                  link: lecLink,
                                  sub: lecSub,
                                  name: lecName));
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
                              'Update',
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
    );
  }
}
