import 'package:flutter/material.dart';
import 'package:video_player_demo/chewie_video_player.dart';
import 'package:video_player_demo/main.dart';

class PageViewWithChiewie extends StatefulWidget {
  const PageViewWithChiewie({super.key});

  @override
  State<PageViewWithChiewie> createState() => _PageViewWithChiewieState();
}

class _PageViewWithChiewieState extends State<PageViewWithChiewie> {
  List<String> videos = [videoUrlLandscape,videoUrlPortrait,longVideo];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: PageView.builder(
          itemCount:videos.length,
          itemBuilder: (_,index){
            return ChewieVideoPlayer(videoURL: videos[index],);
          },
        ),
      ),
    );
  }
}
