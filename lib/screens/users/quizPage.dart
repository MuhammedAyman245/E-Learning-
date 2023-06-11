import 'package:e_learning_app/models/quiz.dart';
import 'package:e_learning_app/screens/admin/quiz.dart';
import 'package:e_learning_app/services/store.dart';
import 'package:e_learning_app/widgets/decoratedContainer.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../constants.dart';

class QuizPage extends StatelessWidget {
  static const String id = 'quizPage';
  Store _store = Store();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.grey[100],
        body: ModalProgressHUD(
            inAsyncCall: isLoading,
            child: DecoratedContainer(
              bodyColor: Colors.white,
              headColor: Colors.lightBlue[900],
              image: 'images/back.png',
              subName: 'Quizes',
              child: StreamBuilder(
                stream: _store.loadQuiz(),
                builder: (context, snapshots) {
                  if (snapshots.hasData) {
                    List<QuizData> quiz = [];
                    for (var doc in snapshots.data.docs) {
                      quiz.add(QuizData(
                        sub: doc[subName],
                        quizNumber: doc[quizNumber],
                      ));
                    }
                    if (quiz.isNotEmpty) {
                      return ListView.builder(
                          itemCount:
                              quiz[0].sub == quiz[1].sub ? 1 : quiz.length,
                          itemBuilder: (context, int index) {
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(60, 10, 60, 5),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, Quiz.id);
                                },
                                child: Container(
                                  height: size.height * .1,
                                  decoration: BoxDecoration(
                                      color: Colors.blue[600],
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(15),
                                          topRight: Radius.circular(15))),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: size.width * .1,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Quiz ${quiz[index].quizNumber}',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontStyle: FontStyle.italic,
                                                color: Colors.black87,
                                                fontSize: 24),
                                          ),
                                          Text(
                                            quiz[index].sub,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontStyle: FontStyle.italic,
                                                color: Colors.black54,
                                                fontSize: 18),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: size.width * .3,
                                      ),
                                      CircleAvatar(
                                        backgroundColor: Colors.blue[600],
                                        child: Center(
                                          child: Icon(
                                            Icons.play_arrow,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          });
                    } else {
                      return Center(
                          child: Text(
                        'No Quizes Yet',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                            color: Colors.blue[900],
                            fontSize: 20),
                      ));
                    }
                  } else {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: CircularProgressIndicator(),
                          ),
                          Center(
                            child: Text('Loading...'),
                          )
                        ],
                      ),
                    );
                  }
                },
              ),
            )));
  }
}
