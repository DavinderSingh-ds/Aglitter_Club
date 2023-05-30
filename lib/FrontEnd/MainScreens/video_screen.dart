import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoScreen extends StatefulWidget {
  final String id;

  const VideoScreen({Key? key, required this.id}) : super(key: key);

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.id,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          YoutubePlayer(
            controller: _controller,
            showVideoProgressIndicator: true,
            onReady: () {
              log('Player is ready.');
            },
          ),
          FittedBox(
            child: Container(
              height: 100,
              width: 200,
              color: Colors.white,
              child: Lottie.network(
                  'https://assets9.lottiefiles.com/private_files/lf30_rlssnwpv.json'),
            ),
          ),
          FittedBox(
            child: Container(
              height: 100,
              width: 200,
              color: Colors.white,
              child: Lottie.network(
                  'https://assets2.lottiefiles.com/packages/lf20_gp8xcujl.json'),
            ),
          ),
        ],
      ),
    );
  }
}
