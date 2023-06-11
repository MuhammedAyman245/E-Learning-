import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_learning_app/constants.dart';
import 'package:e_learning_app/models/quiz.dart';
import 'package:e_learning_app/screens/admin/editQuiz.dart';
import 'package:e_learning_app/services/store.dart';
import 'package:flutter/material.dart';

class ManageQuiz extends StatelessWidget {
  static const String id = 'manageQuiz';
  Store _store = Store();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: _store.loadQuiz(),
        builder: (context, snapshots) {
          if (snapshots.hasData) {
            List<QuizData> quizData = [];
            try {
              for (var doc in snapshots.data.docs) {
                quizData.add(QuizData(
                  id: doc.id,
                  sub: doc[subName],
                  quizNumber: doc[quizNumber],
                  numofQues: doc[numofQues],
                  question: doc[quizQuestion],
                  answer: doc[quizAnswer],
                  firstChoose: doc[firstChoose],
                  secondChoose: doc[secondChoose],
                  thirdChoose: doc[thirdChoose],
                ));
              }
              if (quizData.isNotEmpty) {
                return Center(
                    child: Column(
                  children: [
                    Container(
                      width: size.width,
                      height: size.height * .1,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(30),
                              bottomRight: Radius.circular(30))),
                      child: Center(
                        child: Text(
                          'Quiz ${quizData[0].quizNumber}',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * .05,
                    ),
                    Expanded(
                      child: ListView.builder(
                          itemCount: quizData.length,
                          itemBuilder: (context, int index) {
                            return GestureDetector(
                              onTapUp: (details) {
                                double dx = details.globalPosition.dx;
                                double dy = details.globalPosition.dy;

                                double dx2 =
                                    size.width - details.globalPosition.dx;
                                double dy2 =
                                    size.width - details.globalPosition.dy;
                                showMenu(
                                    context: context,
                                    position:
                                        RelativeRect.fromLTRB(dx, dy, dx2, dy2),
                                    items: [
                                      MyPopupMenuItem(
                                          onClick: () {
                                            Navigator.pushNamed(
                                                context, EditQuiz.id,
                                                arguments: quizData[index]);
                                          },
                                          child: Text('Edit')),
                                    ]);
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 0, 20, 20),
                                child: Container(
                                  width: size.width * .8,
                                  decoration: BoxDecoration(
                                      color: Colors.black54,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Column(
                                    children: [
                                      Text(
                                        '${index + 1} -  ${quizData[index].question}',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                      Text(
                                        'The Answer is ${quizData[index].answer}',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                      Text(
                                        'First choose => ${quizData[index].firstChoose}',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                      Text(
                                        'Second choose => ${quizData[index].secondChoose}',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                      Text(
                                        'Third choose => ${quizData[index].thirdChoose}',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: size.height * .08,
                        width: size.width * .3,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(40)),
                        child: Center(
                          child: Text(
                            'Done',
                            style: TextStyle(
                                fontSize: 20,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * .02,
                    )
                  ],
                ));
              } else {
                return Center(
                  child: Text('No Quizes added'),
                );
              }
            } catch (e) {}
            return Center(
                child: Column(
              children: [
                Container(
                  width: size.width,
                  height: size.height * .1,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30))),
                  child: Center(
                    child: Text(
                      'Quiz ${quizData[0].quizNumber}',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * .05,
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: quizData.length,
                      itemBuilder: (context, int index) {
                        return GestureDetector(
                          onTapUp: (details) {
                            double dx = details.globalPosition.dx;
                            double dy = details.globalPosition.dy;

                            double dx2 = size.width - details.globalPosition.dx;
                            double dy2 = size.width - details.globalPosition.dy;
                            showMenu(
                                context: context,
                                position:
                                    RelativeRect.fromLTRB(dx, dy, dx2, dy2),
                                items: [
                                  MyPopupMenuItem(
                                      onClick: () {
                                        Navigator.pushNamed(
                                            context, EditQuiz.id,
                                            arguments: quizData[index]);
                                      },
                                      child: Text('Edit')),
                                ]);
                          },
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                            child: Container(
                              width: size.width * .8,
                              decoration: BoxDecoration(
                                  color: Colors.black54,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                children: [
                                  Text(
                                    '${index + 1} -  ${quizData[index].question}',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                  Text(
                                    'The Answer is ${quizData[index].answer}',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                  Text(
                                    'First choose => ${quizData[index].firstChoose}',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                  Text(
                                    'Second choose => ${quizData[index].secondChoose}',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                  Text(
                                    'Third choose => ${quizData[index].thirdChoose}',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: size.height * .08,
                    width: size.width * .3,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(40)),
                    child: Center(
                      child: Text(
                        'Done',
                        style: TextStyle(
                            fontSize: 20,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * .02,
                )
              ],
            ));
          } else {
            return Column(
              children: [
                Center(
                  child: CircularProgressIndicator(),
                ),
                Center(
                  child: Text('Loading...'),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

class MyPopupMenuItem<T> extends PopupMenuItem<T> {
  Widget child;
  Function onClick;
  MyPopupMenuItem({@required this.child, @required this.onClick})
      : super(child: child);
  @override
  PopupMenuItemState<T, PopupMenuItem<T>> createState() {
    return MyPopupMenuItemState();
  }
}

class MyPopupMenuItemState<T, PopupMenuItem>
    extends PopupMenuItemState<T, MyPopupMenuItem<T>> {
  @override
  void handleTap() {
    widget.onClick();
  }
}
