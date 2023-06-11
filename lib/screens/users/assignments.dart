import 'package:e_learning_app/constants.dart';
import 'package:e_learning_app/models/assignments.dart';
import 'package:e_learning_app/screens/admin/editAss.dart';
import 'package:e_learning_app/services/store.dart';
import 'package:e_learning_app/widgets/decoratedContainer.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class Assignments extends StatefulWidget {
  static const String id = 'Assignments';
  @override
  _AssignmentsState createState() => _AssignmentsState();
}

class _AssignmentsState extends State<Assignments> {
  bool isLoading = false;
  Store _store = Store();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: ModalProgressHUD(
            inAsyncCall: isLoading,
            child: DecoratedContainer(
              bodyColor: Colors.white,
              headColor: Colors.lightBlue[900],
              image: 'images/back.png',
              subName: 'Assignments',
              child: StreamBuilder(
                stream: _store.loadAssignments(),
                builder: (context, snapshots) {
                  if (snapshots.hasData) {
                    List<Assignment> ass = [];
                    for (var doc in snapshots.data.docs) {
                      ass.add(Assignment(
                          sub: doc[subName],
                          assName: doc[assName],
                          id: doc.id));
                    }
                    if (ass.isNotEmpty) {
                      return ListView.builder(
                          itemCount: ass.length,
                          itemBuilder: (context, int index) {
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(40, 10, 40, 5),
                              child: GestureDetector(
                                onTap: () {},
                                child: Container(
                                  height: size.height * .1,
                                  decoration: BoxDecoration(
                                      color: Colors.lightBlue[900],
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(30),
                                          bottomRight: Radius.circular(30))),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        '${ass[index].sub} Assignment',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontSize: 20),
                                      ),
                                      Text(
                                        ass[index].assName,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontStyle: FontStyle.italic,
                                            color: Colors.grey[400],
                                            fontSize: 18),
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
                        'No Assignments Yet',
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
