import 'package:e_learning_app/screens/admin/addAss.dart';
import 'package:e_learning_app/screens/admin/addQuiz.dart';
import 'package:e_learning_app/screens/admin/adminHome.dart';
import 'package:e_learning_app/screens/admin/editAss.dart';
import 'package:e_learning_app/screens/admin/editLec.dart';
import 'package:e_learning_app/screens/admin/editQuiz.dart';
import 'package:e_learning_app/screens/admin/lectures.dart';
import 'package:e_learning_app/screens/admin/manageAss.dart';
import 'package:e_learning_app/screens/admin/manageQuiz.dart';
import 'package:e_learning_app/screens/admin/manage_lecture.dart';
import 'package:e_learning_app/screens/admin/quiz.dart';
import 'package:e_learning_app/screens/admin/test.dart';
import 'package:e_learning_app/screens/regestration/signUp.dart';
import 'package:e_learning_app/screens/regestration/signin.dart';
import 'package:e_learning_app/screens/users/assignments.dart';
import 'package:e_learning_app/screens/users/bar.dart';
import 'package:e_learning_app/screens/users/home.dart';
import 'package:e_learning_app/screens/users/profile.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: SignIn.id,
      routes: {
        Assignments.id: (context) => Assignments(),
        AddAssignment.id: (context) => AddAssignment(),
        ManageAssignments.id: (context) => ManageAssignments(),
        EditAss.id: (context) => EditAss(),
        Test.id: (context) => Test(),
        SignIn.id: (context) => SignIn(),
        SignUp.id: (context) => SignUp(),
        UserHome.id: (context) => UserHome(),
        AdminHomePage.id: (context) => AdminHomePage(),
        AddLecture.id: (context) => AddLecture(),
        Profile.id: (context) => Profile(),
        AddQuiz.id: (context) => AddQuiz(),
        ManageLec.id: (context) => ManageLec(),
        EditLec.id: (context) => EditLec(),
        Bar.id: (context) => Bar(),
        ManageQuiz.id: (context) => ManageQuiz(),
        EditQuiz.id: (context) => EditQuiz(),
        Quiz.id: (context) => Quiz()
      },
    );
  }
}
