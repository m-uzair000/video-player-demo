import 'package:flutter/material.dart';
import 'package:video_player_demo/appinio_video_player.dart';
import 'package:video_player_demo/main.dart';

class PageViewWithAppinio extends StatefulWidget {
  const PageViewWithAppinio({super.key});

  @override
  State<PageViewWithAppinio> createState() => _PageViewWithAppinioState();
}

class _PageViewWithAppinioState extends State<PageViewWithAppinio> {
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
          return AppinioVideoPlayer(videoURL: videos[index],);
        },
        ),
      ),
    );
  }
}
