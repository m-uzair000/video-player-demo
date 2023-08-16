import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ChewieVideoPlayer extends StatefulWidget {
  String videoURL;

  ChewieVideoPlayer({
    required this.videoURL,
  });

  @override
  State<ChewieVideoPlayer> createState() =>
      _ChewieVideoPlayerState(videoURL: videoURL);
}

class _ChewieVideoPlayerState extends State<ChewieVideoPlayer> {
  String videoURL;
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;
  late Future<void> _future;

  _ChewieVideoPlayerState({required this.videoURL});

  Future<void> initVideoPlayer() async {
    await _videoPlayerController.initialize();
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      aspectRatio: _videoPlayerController.value.aspectRatio,
      autoInitialize: true,
      showOptions: false,
      showControlsOnInitialize: false,
      autoPlay: true,
      looping: true,
    );
  }

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.network(videoURL);
    _future = initVideoPlayer();
  }

  @override
  void dispose() {
    if (_videoPlayerController.value.isInitialized) {
      _videoPlayerController.dispose();
      _chewieController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CupertinoActivityIndicator(
              color: Colors.grey,
              radius: 25,
            );
          } else {
            return Center(
              child: _videoPlayerController.value.isInitialized
                  ? AspectRatio(
                      aspectRatio: _videoPlayerController.value.aspectRatio,
                      child: Chewie(
                        controller: _chewieController,
                      ),
                    )
                  : const CupertinoActivityIndicator(
                      color: Colors.grey,
                      radius: 25,
                    ),
            );
          }
        });
  }
}
