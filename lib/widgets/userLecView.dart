import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_learning_app/constants.dart';
import 'package:e_learning_app/models/lec.dart';
import 'package:e_learning_app/services/store.dart';
import 'package:e_learning_app/widgets/lecPage.dart';
import 'package:flutter/material.dart';

import 'decoratedContainer.dart';

class UserLecView extends StatefulWidget {
  static const String id = 'userView';
  String lecSubName;
  UserLecView({@required this.lecSubName});
  @override
  _UserLecViewState createState() => _UserLecViewState(lecSubName: lecSubName);
}

class _UserLecViewState extends State<UserLecView> {
  Store _store = Store();
  List<Lectures> _lec = [];
  String lecSubName;
  _UserLecViewState({@required this.lecSubName});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return StreamBuilder<QuerySnapshot>(
        stream: _store.loadLecture(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Lectures> lec = [];
            try {
              for (var doc in snapshot.data.docs) {
                lec.add(Lectures(
                  duration: doc[lecDuration],
                  link: doc[lecPath],
                  name: doc[lecName],
                  sub: doc[subName],
                  id: doc.id,
                ));
              }
            } catch (e) {
              print(e);
            }
            _lec = [...lec];
            lec.clear();
            for (var _lecs in _lec) {
              if (_lecs.sub == lecSubName) {
                lec.add(_lecs);
              }
            }
            return Scaffold(
                body: Container(
              height: size.height,
              width: size.width,
              child: DecoratedContainer(
                  headColor: lecSubName == 'Maths'
                      ? Colors.red[400]
                      : lecSubName == 'Physics'
                          ? Colors.blue[200]
                          : lecSubName == 'Geography'
                              ? Colors.deepOrange[200]
                              : Colors.green[600],
                  bodyColor: lecSubName == 'Maths'
                      ? Colors.white
                      : lecSubName == 'Physics'
                          ? Colors.white
                          : lecSubName == 'Geography'
                              ? Colors.white
                              : Colors.white,
                  subName: lecSubName,
                  image: lecSubName == 'Maths'
                      ? 'images/maths.png'
                      : lecSubName == 'Physics'
                          ? 'images/physics.png'
                          : lecSubName == 'Geography'
                              ? 'images/geo.png'
                              : 'images/chemistry.png',
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: size.width * .05,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(40, 10, 0, 0),
                            child: Text(
                              'Lessons : ',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                          child: ListView.builder(
                              itemCount: lec.length,
                              itemBuilder: (context, int index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => LecPage(
                                                  lec: lec[index],
                                                )));
                                  },
                                  child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          40, 0, 40, 20),
                                      child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(20),
                                                bottomLeft:
                                                    Radius.circular(20)),
                                            color: lecSubName == 'Maths'
                                                ? Colors.red[200]
                                                : lecSubName == 'Physics'
                                                    ? Colors.blue[100]
                                                    : lecSubName == 'Geography'
                                                        ? Colors.deepOrange[100]
                                                        : Colors.green[300],
                                          ),
                                          width: size.width,
                                          height: size.height * .1,
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        lec[index].name,
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 20),
                                                      ),
                                                      Text(
                                                        lec[index].duration,
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black38,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 18),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: size.width * .3,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 8),
                                                  child: CircleAvatar(
                                                    child:
                                                        Icon(Icons.play_arrow),
                                                  ),
                                                ),
                                              ]))),
                                );
                              })),
                    ],
                  )),
            ));
          } else {
            return Scaffold(
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(child: CircularProgressIndicator()),
                  Center(child: Text('Loding...'))
                ],
              ),
            );
          }
        });
  }
}
