import 'package:flutter/cupertino.dart';

class QuizData {
  String quizNumber;
  String sub;
  String id;
  String question;
  String answer;
  String firstChoose;
  String secondChoose;
  String thirdChoose;
  String userAnswer;
  String numofQues;
  QuizData({
    @required this.sub,
    @required this.id,
    @required this.userAnswer,
    @required this.quizNumber,
    @required this.question,
    @required this.answer,
    @required this.numofQues,
    @required this.firstChoose,
    @required this.secondChoose,
    @required this.thirdChoose,
  });
}
