import 'package:e_learning_app/models/lec.dart';
import 'package:e_learning_app/services/store.dart';
import 'package:e_learning_app/services/videoPlayer.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:video_player/video_player.dart';

class LecPage extends StatefulWidget {
  static const String id = 'lecPage';
  final Lectures lec;
  LecPage({@required this.lec});
  @override
  _LecPageState createState() => _LecPageState(lec: lec);
}

class _LecPageState extends State<LecPage> {
  bool isLoading = true;
  final Lectures lec;
  _LecPageState({@required this.lec});
  Store _store = Store();
  String url;

  loadData() async {
    try {
      url = await _store.loadImage('Lectures', lec.sub, lec.name);
      if (url == null) {
        setState(() {
          isLoading = true;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        print(url);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: lec.sub == 'Maths'
            ? Colors.red[200]
            : lec.sub == 'Physics'
                ? Colors.blue[100]
                : lec.sub == 'Geography'
                    ? Colors.deepOrange[100]
                    : Colors.green[300],
        title: Center(child: Text('${lec.name}')),
      ),
      body: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: url == null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text('${lec.name}')],
              )
            : VideoPlay(
                videoPlayerController: VideoPlayerController.network(url),
                isLoop: false),
      ),
    );
  }
}
