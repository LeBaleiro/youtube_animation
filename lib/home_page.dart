import 'package:flutter/material.dart';
import 'package:youtube_animation/models/music_model.dart';
import 'package:youtube_animation/player_widget.dart';

import 'models/music_mock.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Spacer(),
          PlayerWidget(music: MusicModel.fromJson(musicMock)),
        ],
      ),
    );
  }
}
