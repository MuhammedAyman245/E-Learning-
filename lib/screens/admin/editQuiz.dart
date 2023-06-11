import 'package:e_learning_app/models/quiz.dart';
import 'package:e_learning_app/screens/admin/quiz.dart';
import 'package:e_learning_app/services/store.dart';
import 'package:e_learning_app/widgets/textfield.dart';
import 'package:flutter/material.dart';

class EditQuiz extends StatefulWidget {
  static const String id = 'editQuiz';
  @override
  _EditQuizState createState() => _EditQuizState();
}

class _EditQuizState extends State<EditQuiz> {
  GlobalKey<FormState> _key = GlobalKey<FormState>();

  Store _store = Store();
  List<QuizData> _quiz = [];
  String aQuestion, answer, firstChoose, secondChoose, thirdChoose;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    QuizData quizData = ModalRoute.of(context).settings.arguments;
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
                      'Add Quiz ',
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          color: Colors.white),
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * .04,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: Container(
                    height: size.height * .79,
                    width: size.width * .9,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40))),
                    child: ListView(
                      children: [
                        SizedBox(
                          height: size.height * .04,
                        ),
                        Column(
                          children: [
                            MyTextForm(
                                label: 'Add question',
                                onSaved: (value) {
                                  aQuestion = value;
                                }),
                            MyTextForm(
                                label: 'Answer',
                                onSaved: (value) {
                                  answer = value;
                                }),
                            MyTextForm(
                                label: 'First Choose',
                                onSaved: (value) {
                                  firstChoose = value;
                                }),
                            MyTextForm(
                                label: 'Second Choose',
                                onSaved: (value) {
                                  secondChoose = value;
                                }),
                            MyTextForm(
                                label: 'Third Choose',
                                onSaved: (value) {
                                  thirdChoose = value;
                                }),
                          ],
                        ),
                        TextButton(
                          onPressed: () {
                            if (_key.currentState.validate()) {
                              _key.currentState.save();

                              _store.editQuiz(
                                  quizData.id,
                                  QuizData(
                                      question: aQuestion,
                                      answer: answer,
                                      firstChoose: firstChoose,
                                      secondChoose: secondChoose,
                                      thirdChoose: thirdChoose));
                            }
                            _key.currentState.reset();
                          },
                          child: Container(
                            height: size.height * .07,
                            width: size.width * .2,
                            decoration: BoxDecoration(
                                color: Colors.black87,
                                borderRadius: BorderRadius.circular(40)),
                            child: Center(
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
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )));
  }
}
