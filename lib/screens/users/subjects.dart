import 'package:e_learning_app/models/lec.dart';
import 'package:e_learning_app/widgets/decoratedContainer.dart';
import 'package:flutter/material.dart';

class Subject extends StatefulWidget {
  final String subName;
  final String image;
  final Color headColor;
  final Color bodyColor;
  List<Lectures> lec = [];
  Subject(
      {@required this.subName,
      @required this.image,
      @required this.headColor,
      @required this.bodyColor});
  @override
  _SubjectState createState() => _SubjectState(
      subName: subName,
      image: image,
      headColor: headColor,
      bodyColor: bodyColor);
}

class _SubjectState extends State<Subject> {
  final String subName;
  final String image;
  final Color headColor;
  final Color bodyColor;
  List<Lectures> lec = [];
  _SubjectState(
      {@required this.subName,
      @required this.image,
      @required this.headColor,
      @required this.bodyColor});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
      height: size.height,
      width: size.width,
      child: DecoratedContainer(
          headColor: headColor,
          bodyColor: bodyColor,
          subName: subName,
          image: image,
          child: subName == 'Maths'
              ? ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
                      child: Text(
                        'Lessons : ',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
                      child: Row(
                        children: [
                          Container(
                            height: 5,
                            width: size.width * .26,
                            color: Colors.red[400],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: size.height * .02,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20),
                              bottomLeft: Radius.circular(20)),
                          color: Colors.purple[50],
                        ),
                        width: size.width,
                        height: size.height * .1,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Text(
                                      'Introduction',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                    Text(
                                      '1:00 min',
                                      style: TextStyle(
                                          color: Colors.black38,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: size.width * .36,
                              ),
                              CircleAvatar(
                                child: Icon(Icons.play_arrow),
                              )
                            ]),
                      ),
                    )
                  ],
                )
              : subName == 'Chemistry'
                  ? ListView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
                          child: Text(
                            'Lessons : ',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
                          child: Row(
                            children: [
                              Container(
                                height: 5,
                                width: size.width * .26,
                                color: Colors.red[400],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: size.height * .02,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20),
                                  bottomLeft: Radius.circular(20)),
                              color: Colors.grey[200],
                            ),
                            width: size.width,
                            height: size.height * .1,
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Text(
                                          'Introduction',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        ),
                                        Text(
                                          '1:00 min',
                                          style: TextStyle(
                                              color: Colors.black38,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: size.width * .36,
                                  ),
                                  CircleAvatar(
                                    child: Icon(Icons.play_arrow),
                                  )
                                ]),
                          ),
                        )
                      ],
                    )
                  : subName == 'Physics'
                      ? ListView(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
                              child: Text(
                                'Lessons : ',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
                              child: Row(
                                children: [
                                  Container(
                                    height: 5,
                                    width: size.width * .26,
                                    color: Colors.blue[900],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: size.height * .02,
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(20),
                                      bottomLeft: Radius.circular(20)),
                                  color: Colors.blue[200],
                                ),
                                width: size.width,
                                height: size.height * .1,
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Text(
                                              'Introduction',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20),
                                            ),
                                            Text(
                                              '1:00 min',
                                              style: TextStyle(
                                                  color: Colors.black38,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18),
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: size.width * .36,
                                      ),
                                      CircleAvatar(
                                        child: Icon(Icons.play_arrow),
                                      )
                                    ]),
                              ),
                            )
                          ],
                        )
                      : subName == 'Geography'
                          ? ListView(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(40, 0, 0, 0),
                                  child: Text(
                                    'Lessons : ',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(40, 0, 0, 0),
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 5,
                                        width: size.width * .26,
                                        color: Colors.blue[200],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: size.height * .02,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(40, 0, 40, 0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(20),
                                          bottomLeft: Radius.circular(20)),
                                      color: Color(0xffe3f3f2),
                                    ),
                                    width: size.width,
                                    height: size.height * .1,
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              children: [
                                                Text(
                                                  'Introduction',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20),
                                                ),
                                                Text(
                                                  '1:00 min',
                                                  style: TextStyle(
                                                      color: Colors.black38,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18),
                                                )
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: size.width * .36,
                                          ),
                                          CircleAvatar(
                                            child: Icon(Icons.play_arrow),
                                          )
                                        ]),
                                  ),
                                )
                              ],
                            )
                          : Text('')),
    ));
  }
}
