import 'package:e_learning_app/screens/users/drawer.dart';
import 'package:e_learning_app/screens/users/home.dart';
import 'package:e_learning_app/screens/users/profile.dart';
import 'package:e_learning_app/screens/users/quizPage.dart';
import 'package:flutter/material.dart';

class Bar extends StatefulWidget {
  static const String id = 'bar';
  @override
  _BarState createState() => _BarState();
}

class _BarState extends State<Bar> {
  GlobalKey _bottomNavigationKey = GlobalKey();
  final screen = [QuizPage(), UserHome(), Profile()];
  int _index = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          DrawerPage(),
          UserHome(),
        ],
      ),
    );
  }
}
