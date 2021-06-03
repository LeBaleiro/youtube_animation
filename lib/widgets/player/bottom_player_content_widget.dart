import 'package:flutter/material.dart';
import 'package:youtube_animation/widgets/player/bottom_music_info_widget.dart';
import 'package:youtube_animation/widgets/player/play_next_widgets.dart';

class BottomPlayerContentWidget extends StatelessWidget {
  final String musicName;
  final String artistName;
  final Animation<Color?> animationColor;
  final double topPadding;

  const BottomPlayerContentWidget({
    Key? key,
    required this.musicName,
    required this.artistName,
    required this.animationColor,
    required this.topPadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        BottomMusicInfoWidget(
          animationColor: animationColor,
          musicName: musicName,
          artistName: artistName,
          topPadding: topPadding,
        ),
        PlayPauseWidget(animationColor: animationColor),
      ],
    );
  }
}
