import 'package:e_learning_app/constants.dart';
import 'package:e_learning_app/models/assignments.dart';
import 'package:e_learning_app/screens/admin/editAss.dart';
import 'package:e_learning_app/services/store.dart';
import 'package:e_learning_app/widgets/decoratedContainer.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class ManageAssignments extends StatefulWidget {
  static const String id = 'manage ass';
  @override
  _ManageAssignmentsState createState() => _ManageAssignmentsState();
}

class _ManageAssignmentsState extends State<ManageAssignments> {
  bool isLoading = false;
  Store _store = Store();
  List<Assignment> _ass = [];
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: ModalProgressHUD(
            inAsyncCall: isLoading,
            child: DecoratedContainer(
              bodyColor: Colors.white,
              headColor: Colors.black87,
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
                                onTapUp: (details) {
                                  double dx = details.globalPosition.dx;
                                  double dy = details.globalPosition.dy;

                                  double dx2 =
                                      size.width - details.globalPosition.dx;
                                  double dy2 =
                                      size.width - details.globalPosition.dy;
                                  showMenu(
                                      context: context,
                                      position: RelativeRect.fromLTRB(
                                          dx, dy, dx2, dy2),
                                      items: [
                                        MyPopupMenuItem(
                                            onClick: () {
                                              Navigator.pushNamed(
                                                  context, EditAss.id,
                                                  arguments: ass[index]);
                                            },
                                            child: Text('Edit')),
                                        MyPopupMenuItem(
                                            onClick: () {
                                              _store.deleteAssignment(
                                                  ass[index].id);
                                              Navigator.pop(context);
                                            },
                                            child: Text('Delete')),
                                      ]);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.grey[900],
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Column(
                                    children: [
                                      Text(
                                        '${ass[index].sub} Assignment',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontStyle: FontStyle.italic,
                                            color: Colors.white,
                                            fontSize: 20),
                                      ),
                                      Text(
                                        ass[index].assName,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontStyle: FontStyle.italic,
                                            color: Colors.grey,
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
                        'No Assignment Yet',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                            color: Colors.black,
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
