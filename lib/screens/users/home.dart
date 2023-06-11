import 'dart:ui';
import 'package:e_learning_app/screens/users/profile.dart';
import 'package:e_learning_app/services/store.dart';
import 'package:e_learning_app/widgets/userLecView.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserHome extends StatefulWidget {
  static const String id = 'userhome';
  @override
  _UserHomeState createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  Store _store = Store();
  double xOffset = 0;
  double yOffset = 0;
  double scaffactor = 1;
  bool isDrawerOpen = false;
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
    return AnimatedContainer(
      transform: Matrix4.translationValues(xOffset, yOffset, scaffactor)
        ..scale(scaffactor),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: isDrawerOpen == false
              ? BorderRadius.circular(0)
              : BorderRadius.circular(40)),
      duration: Duration(milliseconds: 250),
      child: ListView(
        children: [
          SizedBox(
            height: size.height * .01,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isDrawerOpen == false) {
                          xOffset = 170;
                          yOffset = 120;
                          scaffactor = 0.7;
                          isDrawerOpen = true;
                        } else {
                          xOffset = 0;
                          yOffset = 0;
                          scaffactor = 1;
                          isDrawerOpen = false;
                        }
                      });
                    },
                    child: isDrawerOpen == false
                        ? Icon(
                            Icons.filter_list_rounded,
                            size: 30,
                          )
                        : Icon(Icons.arrow_back_ios)),
                Row(
                  children: [
                    Text(
                      'Hi, ',
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 20,
                          fontStyle: FontStyle.italic),
                    ),
                    Text(
                      _auth.currentUser.displayName,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontStyle: FontStyle.italic),
                    ),
                  ],
                ),
                url != null
                    ? GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, Profile.id);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            backgroundImage: NetworkImage(url),
                          ),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          backgroundImage: AssetImage('images/pp.png'),
                        ),
                      ),
              ],
            ),
          ),
          SizedBox(
            height: size.height * .02,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
            child: Text(
              'Welcome Back',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: size.height * .01,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                      hintText: 'Search',
                      suffixIcon: Icon(
                        Icons.search,
                        color: Colors.black,
                      ),
                      fillColor: Colors.white,
                      focusColor: Colors.white,
                      hoverColor: Colors.white),
                ),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              height: size.height * .07,
              width: size.width * .8,
            ),
          ),
          SizedBox(
            height: size.height * .01,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Subjects',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Text('More'),
                    Icon(Icons.navigate_next_outlined),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: size.height * .003,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 290, 0),
            child: Container(
              height: 5,
              width: 50,
              color: Colors.red[400],
            ),
          ),
          SizedBox(
            height: size.height * .02,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  UserLecView(lecSubName: 'Maths')));
                    },
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(40, 230, 40, 0),
                        child: Text(
                          'Maths',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      height: size.height * .32,
                      width: size.width * .3,
                      decoration: BoxDecoration(
                          color: Colors.red[600],
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(60),
                              bottomLeft: Radius.circular(60)),
                          image: DecorationImage(
                            image: AssetImage('images/maths.png'),
                          )),
                    ),
                  ),
                ),
                SizedBox(
                  width: size.width * .05,
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  UserLecView(lecSubName: 'Chemistry')));
                    },
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(25, 10, 40, 0),
                        child: Text(
                          'Chemistry',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 23,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      height: size.height * .30,
                      width: size.width * .5,
                      decoration: BoxDecoration(
                          color: Colors.green[600],
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(60),
                              bottomRight: Radius.circular(60)),
                          image: DecorationImage(
                              image: AssetImage('images/chemistry.png'),
                              fit: BoxFit.fill)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: size.height * .02,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  UserLecView(lecSubName: 'Physics')));
                    },
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 200, 40, 0),
                        child: Text(
                          'Physics',
                          style: TextStyle(
                              color: Colors.white,
                              fontStyle: FontStyle.italic,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      height: size.height * .30,
                      width: size.width * .5,
                      decoration: BoxDecoration(
                          color: Colors.purple[100],
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(60),
                              bottomRight: Radius.circular(60)),
                          image: DecorationImage(
                              image: AssetImage('images/physics.png'),
                              fit: BoxFit.fill)),
                    ),
                  ),
                ),
                SizedBox(
                  width: size.width * .05,
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  UserLecView(lecSubName: 'Geography')));
                    },
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 5, 40, 0),
                        child: Text(
                          'Geography',
                          style: TextStyle(
                              color: Colors.white,
                              fontStyle: FontStyle.italic,
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      height: size.height * .30,
                      width: size.width * .5,
                      decoration: BoxDecoration(
                          color: Colors.deepOrange[200],
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(60),
                              bottomLeft: Radius.circular(60)),
                          image: DecorationImage(
                            image: AssetImage('images/geo.png'),
                          )),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
