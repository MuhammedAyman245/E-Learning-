import 'package:e_learning_app/screens/admin/addAss.dart';
import 'package:e_learning_app/screens/admin/addQuiz.dart';
import 'package:e_learning_app/screens/admin/editAss.dart';
import 'package:e_learning_app/screens/admin/lectures.dart';
import 'package:e_learning_app/screens/admin/manageAss.dart';
import 'package:e_learning_app/screens/admin/manageQuiz.dart';
import 'package:e_learning_app/screens/admin/manage_lecture.dart';
import 'package:flutter/material.dart';

class AdminHomePage extends StatefulWidget {
  static const String id = 'adminHome';
  @override
  _AdminHomePageState createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          backgroundColor: Colors.black87,
          title: Center(child: Text('Admin Page')),
          actions: [IconButton(icon: Icon(Icons.logout), onPressed: () {})],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddLecture()));
              },
              child: Center(
                child: Container(
                  height: size.height * .08,
                  width: size.width * .55,
                  decoration: BoxDecoration(
                      color: Colors.black87,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30))),
                  child: Center(
                      child: Text(
                    'Add Lecture',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  )),
                ),
              ),
            ),
            SizedBox(
              height: size.height * .02,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ManageLec()));
              },
              child: Center(
                child: Container(
                  height: size.height * .08,
                  width: size.width * .55,
                  decoration: BoxDecoration(
                      color: Colors.black87,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30))),
                  child: Center(
                      child: Text(
                    'Manage Lecture',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  )),
                ),
              ),
            ),
            SizedBox(
              height: size.height * .02,
            ),
            GestureDetector(
              onTap: () {
                //       Navigator.pushNamed(context, AddLecture.id);
              },
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, AddAssignment.id);
                  },
                  child: Container(
                    height: size.height * .08,
                    width: size.width * .55,
                    decoration: BoxDecoration(
                        color: Colors.black87,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30))),
                    child: Center(
                        child: Text(
                      'Add Assignment',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    )),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: size.height * .02,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, ManageAssignments.id);
              },
              child: Center(
                child: Container(
                  height: size.height * .08,
                  width: size.width * .55,
                  decoration: BoxDecoration(
                      color: Colors.black87,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30))),
                  child: Center(
                      child: Text(
                    'Manage Assignment',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  )),
                ),
              ),
            ),
            SizedBox(
              height: size.height * .02,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddQuiz()));
              },
              child: Center(
                child: Container(
                  height: size.height * .08,
                  width: size.width * .55,
                  decoration: BoxDecoration(
                      color: Colors.black87,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30))),
                  child: Center(
                      child: Text(
                    'Add Quiz',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  )),
                ),
              ),
            ),
            SizedBox(
              height: size.height * .02,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ManageQuiz()));
              },
              child: Center(
                child: Container(
                  height: size.height * .08,
                  width: size.width * .55,
                  decoration: BoxDecoration(
                      color: Colors.black87,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30))),
                  child: Center(
                      child: Text(
                    'Manage Quiz',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
