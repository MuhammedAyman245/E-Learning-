import 'package:e_learning_app/screens/regestration/signin.dart';
import 'package:e_learning_app/screens/users/assignments.dart';
import 'package:e_learning_app/screens/users/chat.dart';
import 'package:e_learning_app/screens/users/profile.dart';
import 'package:e_learning_app/screens/users/quizPage.dart';
import 'package:e_learning_app/services/auth.dart';
import 'package:e_learning_app/services/store.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DrawerPage extends StatefulWidget {
  @override
  _DrawerPageState createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  Auth auth = Auth();
  Store _store = Store();
  String url;
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
    print(url);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: size.width,
      color: Colors.lightBlue[900],
      child: Column(
        children: [
          SizedBox(
            height: size.height * .05,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 10, 0, 0),
            child: Row(
              children: [
                url != null
                    ? GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, Profile.id);
                        },
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(url),
                        ),
                      )
                    : Container(
                        height: size.height * .07,
                        width: size.width * .1,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('images/pp.png')),
                            color: Colors.white,
                            shape: BoxShape.circle),
                      ),
                SizedBox(
                  width: size.width * .02,
                ),
                Column(
                  children: [
                    Text(
                      _auth.currentUser.displayName,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontStyle: FontStyle.italic),
                    ),
                    Text(
                      _auth.currentUser.email,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontStyle: FontStyle.italic),
                    )
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: size.height * .13,
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, Profile.id);
            },
            child: Row(
              children: [
                SizedBox(
                  width: size.width * .02,
                ),
                Icon(
                  Icons.account_circle,
                  color: Colors.white,
                  size: 25,
                ),
                SizedBox(
                  width: size.width * .02,
                ),
                Text(
                  'Profile',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic),
                )
              ],
            ),
          ),
          SizedBox(
            height: size.height * .05,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => QuizPage()));
            },
            child: Row(
              children: [
                SizedBox(
                  width: size.width * .02,
                ),
                Icon(
                  Icons.question_answer,
                  color: Colors.white,
                  size: 25,
                ),
                SizedBox(
                  width: size.width * .02,
                ),
                Text(
                  'Quizes',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic),
                )
              ],
            ),
          ),
          SizedBox(
            height: size.height * .05,
          ),
          Row(
            children: [
              SizedBox(
                width: size.width * .02,
              ),
              Icon(
                Icons.question_answer,
                color: Colors.white,
                size: 25,
              ),
              SizedBox(
                width: size.width * .05,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, Assignments.id);
                },
                child: Text(
                  'Assignments',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic),
                ),
              )
            ],
          ),
          SizedBox(
            height: size.height * .05,
          ),
          Row(
            children: [
              SizedBox(
                width: size.width * .02,
              ),
              Icon(
                Icons.message,
                color: Colors.white,
                size: 25,
              ),
              SizedBox(
                width: size.width * .02,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Chat()));
                },
                child: Text(
                  'Chats',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic),
                ),
              )
            ],
          ),
          SizedBox(
            height: size.height * .05,
          ),
          GestureDetector(
            onTap: () async {
              await auth.signOut();
              Navigator.pushNamed(context, SignIn.id);
            },
            child: Row(
              children: [
                SizedBox(
                  width: size.width * .02,
                ),
                Icon(
                  Icons.logout,
                  color: Colors.white,
                  size: 25,
                ),
                SizedBox(
                  width: size.width * .02,
                ),
                Text(
                  'LogOut',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
