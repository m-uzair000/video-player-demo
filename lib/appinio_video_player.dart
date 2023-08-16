import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AppinioVideoPlayer extends StatefulWidget {
  String videoURL;

  AppinioVideoPlayer({
    required this.videoURL,
  });

  @override
  State<AppinioVideoPlayer> createState() =>
      _AppinioVideoPlayerState(videoURL: videoURL);
}

class _AppinioVideoPlayerState extends State<AppinioVideoPlayer> {
  String videoURL;

  _AppinioVideoPlayerState({
    required this.videoURL,
  });

  late VideoPlayerController _videoPlayerController;
  late CustomVideoPlayerController _customVideoPlayerController;
  late CustomVideoPlayerWebController _customVideoPlayerWebController;
  final CustomVideoPlayerSettings _customVideoPlayerSettings =
      const CustomVideoPlayerSettings(
          settingsButtonAvailable: false,
          alwaysShowThumbnailOnVideoPaused: true);
  late Future<void> _future;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.network(videoURL);
    _future = initVideoPlayer();
  }

  Future<void> initVideoPlayer() async {
    await _videoPlayerController.initialize();
    _customVideoPlayerController = CustomVideoPlayerController(
      context: context,
      videoPlayerController: _videoPlayerController,
      customVideoPlayerSettings: _customVideoPlayerSettings,
    );
    _customVideoPlayerController.videoPlayerController.setLooping(true);
    _customVideoPlayerController.videoPlayerController.play();
  }

  @override
  void dispose() {
    if(_videoPlayerController.value.isInitialized){
    _customVideoPlayerController.dispose();
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
            return _videoPlayerController.value.isInitialized
                ? kIsWeb
                    ? CustomVideoPlayerWeb(
                        customVideoPlayerWebController:
                            _customVideoPlayerWebController,
                      )
                    : CustomVideoPlayer(
                        customVideoPlayerController:
                            _customVideoPlayerController,
                      )
                : const CupertinoActivityIndicator(
                    color: Colors.grey,
                    radius: 25,
                  );
          }
        });
  }
}
