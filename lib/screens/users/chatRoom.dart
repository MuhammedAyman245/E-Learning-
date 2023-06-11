import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatRoom extends StatelessWidget {
  final TextEditingController _message = TextEditingController();
  final Map<String, dynamic> userMap;
  final String charRoomId;
  ChatRoom({this.charRoomId, this.userMap});

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void onSend() async {
    if (_message.text.isNotEmpty) {
      Map<String, dynamic> messages = {
        'sendBy': _auth.currentUser.displayName,
        'message': _message.text,
        'time': FieldValue.serverTimestamp()
      };
      await _firestore
          .collection('chatRoom')
          .doc(charRoomId)
          .collection('chats')
          .add(messages);
      _message.clear();
      print(_auth.currentUser.displayName);
    } else {
      print('enter anything');
    }
  }

  Widget message(Size size, Map<String, dynamic> map) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Container(
        width: size.width,
        alignment: map['sendBy'] == _auth.currentUser.displayName
            ? Alignment.topRight
            : Alignment.topLeft,
        child: Container(
          decoration: BoxDecoration(
            color: map['sendBy'] == _auth.currentUser.displayName
                ? Colors.grey[800]
                : Colors.grey,
            borderRadius: BorderRadius.only(
              topRight: map['sendBy'] == _auth.currentUser.displayName
                  ? Radius.circular(0)
                  : Radius.circular(15),
              topLeft: map['sendBy'] == _auth.currentUser.displayName
                  ? Radius.circular(15)
                  : Radius.circular(0),
              bottomLeft: map['sendBy'] == _auth.currentUser.displayName
                  ? Radius.circular(15)
                  : Radius.circular(15),
              bottomRight: map['sendBy'] == _auth.currentUser.displayName
                  ? Radius.circular(15)
                  : Radius.circular(15),
            ),
          ),
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 18),
          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
          child: Text(
            map['message'],
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white10,
      appBar: AppBar(
        backgroundColor: Colors.white10,
        title: StreamBuilder<DocumentSnapshot>(
          stream:
              _firestore.collection('users').doc(userMap['uid']).snapshots(),
          builder: (context, snapshots) {
            if (snapshots.data != null) {
              return Container(
                child: Column(
                  children: [
                    Text(userMap['name']),
                    Text(
                      userMap['status'],
                      style: TextStyle(fontSize: 14),
                    )
                  ],
                ),
              );
            } else {
              return Text('fuck');
            }
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
                height: size.height / 1.25,
                width: size.width,
                child: StreamBuilder<QuerySnapshot>(
                  stream: _firestore
                      .collection('chatRoom')
                      .doc(charRoomId)
                      .collection('chats')
                      .orderBy('time', descending: false)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.data != null) {
                      return ListView.builder(
                          itemCount: snapshot.data.docs.length,
                          itemBuilder: (context, index) {
                            Map<String, dynamic> map =
                                snapshot.data.docs[index].data();
                            return message(size, map);
                          });
                    } else {
                      return Container();
                    }
                  },
                )),
            Row(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(12.0, 10, 0.0, 10),
                      child: Container(
                        height: 40.0,
                        width: 300,
                        child: CupertinoTextField(
                          controller: _message,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 25,
                                  offset: Offset(0, 10),
                                  color: Color(0x1A636363),
                                ),
                              ]),
                          padding: EdgeInsets.all(10),
                          style: TextStyle(
                            color: Color(0xFF343434),
                            fontSize: 18,
                          ),
                          enableInteractiveSelection: true,
                          expands: false,
                          textInputAction: TextInputAction.search,
                          textCapitalization: TextCapitalization.words,
                          placeholder: "Send Message",
                          placeholderStyle: TextStyle(
                            color: Color(0xFFADADAD),
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                        icon: Icon(
                          Icons.send,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          onSend();
                        })
                  ],
                ),
              ],
            ),
          ],
        )),
      ),
    );
  }
}
