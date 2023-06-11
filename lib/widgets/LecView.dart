import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_learning_app/constants.dart';
import 'package:e_learning_app/models/lec.dart';
import 'package:e_learning_app/screens/admin/editLec.dart';
import 'package:e_learning_app/services/store.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LecView extends StatefulWidget {
  String lecSubName;
  LecView({@required this.lecSubName});
  @override
  _LecViewState createState() => _LecViewState(lecSubName: lecSubName);
}

class _LecViewState extends State<LecView> {
  Store _store = Store();
  List<Lectures> _lec = [];
  String img;
  String lecSubName;
  _LecViewState({@required this.lecSubName});
  String url;
  bool isLoading = false;

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
            return ModalProgressHUD(
              inAsyncCall: isLoading,
              child: GridView.builder(
                  itemCount: lec.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (context, int index) {
                    return GestureDetector(
                      onTapUp: (details) {
                        double dx = details.globalPosition.dx;
                        double dy = details.globalPosition.dy;
                        double dx2 = size.width - details.globalPosition.dx;
                        double dy2 = size.width - details.globalPosition.dy;
                        showMenu(
                            context: context,
                            position: RelativeRect.fromLTRB(dx, dy, dx2, dy2),
                            items: [
                              MyPopupMenuItem(
                                  onClick: () {
                                    Navigator.pushNamed(context, EditLec.id,
                                        arguments: lec[index]);
                                  },
                                  child: Text('Edit')),
                              MyPopupMenuItem(
                                  onClick: () {
                                    _store.deleteLec(lec[index].id);
                                    Navigator.pop(context);
                                  },
                                  child: Text('delete')),
                            ]);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: size.height * .4,
                          width: size.width,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: lec[index].sub == 'Maths'
                                      ? AssetImage('images/maths.png')
                                      : lec[index].sub == 'Physics'
                                          ? AssetImage('images/physics.png')
                                          : lec[index].sub == 'Cemistry'
                                              ? AssetImage(
                                                  'images/chemitry.png')
                                              : AssetImage('images/geo.png'),
                                  fit: BoxFit.fill)),
                          child: Column(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 110, 0, 0),
                                  child: Text(
                                    lec[index].name,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            );
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
