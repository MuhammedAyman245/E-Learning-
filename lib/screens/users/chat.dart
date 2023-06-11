import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_learning_app/services/store.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'chatRoom.dart';

class Chat extends StatefulWidget {
  static const String id = 'chat';
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> with WidgetsBindingObserver {
  bool isLoading = false;
  Map<String, dynamic> userMap;
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<ListTile> chats = [];
  int index = 0;
  TextEditingController _search = TextEditingController();
  List<String> shit = [];
  Store _store = Store();
  String url;
  Future<String> loadData() async {
    try {
      String img;
      img = await _store.loadImage('Users', 'Profile Pictures', _search.text);
      if (url == null) {
        print('wait');
      } else {
        print(url);
      }
      setState(() {
        url = img;
      });
      return url;
    } catch (e) {}
  }

  void onSearch() async {
    setState(() {
      isLoading = true;
    });
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    await _firestore
        .collection('users')
        .where('email', isEqualTo: _search.text)
        .get()
        .then((value) {
      setState(() {
        userMap = value.docs[0].data();
        print(userMap);
        isLoading = false;
      });
      loadData();
      chats.add(ListTile(
        onTap: () {
          print(_auth.currentUser.email);
          String roomId =
              chatRoomId(_auth.currentUser.displayName, userMap['name']);
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return ChatRoom(charRoomId: roomId, userMap: userMap);
          }));
        },
        leading: url != null
            ? CircleAvatar(
                backgroundImage: NetworkImage(url),
              )
            : CircleAvatar(backgroundImage: AssetImage('images/pp.png')),
        title: Text(userMap['name'],
            style: TextStyle(color: Colors.black, fontSize: 18)),
        subtitle: Text(userMap['email'],
            style: TextStyle(color: Colors.grey, fontSize: 15)),
        trailing: Icon(Icons.chat, color: Colors.black),
      ));
    });
  }

  String chatRoomId(String user1, String user2) {
    if (user1[0].toLowerCase().codeUnits[0] >
        user2.toLowerCase().codeUnits[0]) {
      return '$user1$user2';
    } else {
      return '$user2$user1';
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    setStatus('online');
  }

  void setStatus(String status) async {
    await _firestore
        .collection('users')
        .doc(_auth.currentUser.uid)
        .update({'status': status});
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      // online
      setStatus('online');
    } else {
      //offline
      setStatus('offline');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: isLoading
              ? Center(
                  child: Container(
                    height: 70.0,
                    width: 70.0,
                    child: CircularProgressIndicator(),
                  ),
                )
              : ListView(
                  children: [
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      children: [
                        GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(Icons.arrow_back_ios),
                            )),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            'Chat',
                            style: TextStyle(
                                fontSize: 30.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(12.0, 10, 0.0, 10),
                          child: Container(
                            height: 40.0,
                            width: 300,
                            child: CupertinoTextField(
                              controller: _search,
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
                              placeholder: "Search",
                              placeholderStyle: TextStyle(
                                color: Color(0xFFADADAD),
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                            icon: Icon(Icons.search),
                            onPressed: () {
                              onSearch();
                            })
                      ],
                    ),
                    SizedBox(
                      height: 6.0,
                    ),
                    chats == null
                        ? Container(
                            width: 100,
                            child: Column(
                              children: [
                                Image.asset('images/noMess.png'),
                                Text(
                                  'No Chats',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic),
                                ),
                              ],
                            ),
                          )
                        : Column(
                            children: chats,
                          )
                  ],
                ),
        ),
      ),
    );
  }
}
