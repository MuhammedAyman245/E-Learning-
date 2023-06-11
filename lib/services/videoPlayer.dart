import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

class VideoPlay extends StatefulWidget {
  final VideoPlayerController videoPlayerController;
  final bool isLoop;
  VideoPlay({@required this.videoPlayerController, @required this.isLoop});

  @override
  _VideoPlayState createState() => _VideoPlayState();
}

class _VideoPlayState extends State<VideoPlay> {
  ChewieController chewieController;
  @override
  void initState() {
    chewieController = ChewieController(
        videoPlayerController: widget.videoPlayerController,
        looping: widget.isLoop,

        // aspectRatio: 16 / 2,
        autoInitialize: true);
    super.initState();
  }

  void dispose() {
    chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Chewie(
      controller: chewieController,
    );
  }
}
