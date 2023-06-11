import 'package:e_learning_app/widgets/LecView.dart';
import 'package:flutter/material.dart';

class ManageLec extends StatefulWidget {
  static const String id = 'manageLec';

  @override
  _ManageLecState createState() => _ManageLecState();
}

class _ManageLecState extends State<ManageLec> {
  int _tabIndex = 0;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(children: [
      DefaultTabController(
        length: 4,
        child: Scaffold(
            body: TabBarView(
              children: [
                LecView(
                  lecSubName: 'Maths',
                ),
                LecView(
                  lecSubName: 'Physics',
                ),
                LecView(
                  lecSubName: 'Chemistry',
                ),
                LecView(
                  lecSubName: 'Geography',
                ),
              ],
            ),
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.black,
              title: Text('Lecture Manager'),
              bottom: TabBar(
                tabs: [
                  Text(
                    'Maths',
                    style: TextStyle(fontSize: 11),
                  ),
                  Text(
                    'Physics',
                    style: TextStyle(fontSize: 11),
                  ),
                  Text(
                    'Chemistry',
                    style: TextStyle(fontSize: 11),
                  ),
                  Text(
                    'Geography',
                    style: TextStyle(fontSize: 11),
                  ),
                ],
                indicatorColor: Colors.yellow[700],
                onTap: (value) {
                  setState(() {
                    _tabIndex = value;
                  });
                },
              ),
            )),
      ),
    ]);
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
