import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_learning_app/constants.dart';
import 'package:e_learning_app/models/quiz.dart';
import 'package:e_learning_app/screens/users/home.dart';
import 'package:e_learning_app/services/store.dart';
import 'package:e_learning_app/widgets/decoratedContainer.dart';
import 'package:flutter/material.dart';
import 'package:e_learning_app/screens/users/bar.dart';

class Quiz extends StatefulWidget {
  static const String id = 'quiz';

  @override
  _QuizState createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  int i = 0;
  int c = 0;
  int w = 0;
  Store _store = Store();
  bool isEnded = false;
  List<String> userAnswer = ['', '', '', '', ''];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: _store.loadQuiz(),
        builder: (context, snapshots) {
          if (snapshots.hasData) {
            List<QuizData> quizData = [];
            for (var doc in snapshots.data.docs) {
              quizData.add(QuizData(
                  quizNumber: doc[quizNumber],
                  question: doc[quizQuestion],
                  answer: doc[quizAnswer],
                  numofQues: doc[numofQues],
                  firstChoose: doc[firstChoose],
                  secondChoose: doc[secondChoose],
                  thirdChoose: doc[thirdChoose]));
            }
            if (quizData.isNotEmpty) {
              return isEnded == false
                  ? DecoratedContainer(
                      bodyColor: Colors.white,
                      headColor: Colors.lightBlue[900],
                      image: 'images/back.png',
                      subName: 'Quiz ${quizData[i].quizNumber}',
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(40, 20, 40, 40),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.blue[400],
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  bottomRight: Radius.circular(30))),
                          height: size.height * .6,
                          width: size.width * .9,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Q${i + 1}) ${quizData[i].question}',
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,
                                  fontSize: 30,
                                ),
                              ),
                              SizedBox(
                                height: size.height * .01,
                              ),
                              Container(
                                color: Colors.black,
                                height: size.height * .004,
                                width: size.width * .4,
                              ),
                              SizedBox(
                                height: size.height * .01,
                              ),
                              Row(
                                children: [
                                  Radio(
                                      value: quizData[i].firstChoose,
                                      groupValue: userAnswer[i],
                                      onChanged: (value) {
                                        userAnswer[i] = value;
                                        setState(() {});
                                      }),
                                  Text(
                                    quizData[i].firstChoose,
                                    style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 20,
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: size.height * .04,
                              ),
                              Row(
                                children: [
                                  Radio(
                                      value: quizData[i].secondChoose,
                                      groupValue: userAnswer[i],
                                      onChanged: (value) {
                                        userAnswer[i] = value;
                                        setState(() {});
                                      }),
                                  Text(
                                    quizData[i].secondChoose,
                                    style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 20,
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: size.height * .04,
                              ),
                              Row(
                                children: [
                                  Radio(
                                      value: quizData[i].thirdChoose,
                                      groupValue: userAnswer[i],
                                      onChanged: (value) {
                                        userAnswer[i] = value;
                                        setState(() {});
                                      }),
                                  Text(
                                    quizData[i].thirdChoose,
                                    style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 20,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: size.height * .04,
                              ),
                              GestureDetector(
                                onTap: () {
                                  if (i <
                                      int.parse(quizData[i].numofQues) - 1) {
                                    print(userAnswer[i]);
                                    print(quizData[i].answer);
                                    if (userAnswer[i] == quizData[i].answer) {
                                      setState(() {
                                        c = c + 1;
                                      });
                                    } else {
                                      setState(() {
                                        w = w + 1;
                                      });
                                    }
                                    setState(() {
                                      i = i + 1;
                                    });
                                  } else {
                                    if (userAnswer[i] == quizData[i].answer) {
                                      setState(() {
                                        c = c + 1;
                                        isEnded = true;
                                      });
                                    } else {
                                      setState(() {
                                        w = w + 1;
                                        isEnded = true;
                                      });
                                    }
                                    print(userAnswer[i]);
                                  }

                                  print('correct answer = $c');
                                  print('wrong answer = $w');
                                  print('$isEnded');
                                },
                                child: Container(
                                  height: size.height * .06,
                                  width: size.width * .3,
                                  decoration: BoxDecoration(
                                      color: Colors.black87,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          bottomRight: Radius.circular(20))),
                                  child: Center(
                                    child: Text(
                                      'Next',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontStyle: FontStyle.italic),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : DecoratedContainer(
                      bodyColor: Colors.white,
                      headColor: Colors.lightBlue[900],
                      image: 'images/back.png',
                      subName: 'Quiz ${quizData[i].quizNumber}',
                      child: Container(
                        child: Column(
                          children: [
                            SizedBox(
                              height: size.height * .1,
                            ),
                            Text('You\'ve Finished Your Quiz',
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                    fontSize: 25)),
                            SizedBox(
                              height: size.height * .1,
                            ),
                            Text('$c correct answers',
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                    fontSize: 25)),
                            Text('$w wrong answers',
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                    fontSize: 25)),
                            SizedBox(
                              height: size.height * .15,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Bar()));
                              },
                              child: Container(
                                height: size.height * .06,
                                width: size.width * .2,
                                decoration: BoxDecoration(
                                    color: Colors.lightBlue[900],
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      bottomRight: Radius.circular(15),
                                    )),
                                child: Center(
                                  child: Text(
                                    'Home',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FontStyle.italic,
                                        fontSize: 20),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
            } else {
              return Center(
                child: Text('No Quizes yet!'),
              );
            }
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: CircularProgressIndicator(),
                ),
                Center(
                  child: Text('Loading...'),
                )
              ],
            );
          }
        },
      ),
    );
  }
}
