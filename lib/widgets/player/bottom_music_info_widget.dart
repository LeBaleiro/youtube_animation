import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BottomMusicInfoWidget extends StatelessWidget {
  final String musicName;
  final String artistName;
  final Animation<Color?> animationColor;
  final double topPadding;

  const BottomMusicInfoWidget({
    Key? key,
    required this.musicName,
    required this.artistName,
    required this.animationColor,
    required this.topPadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationColor,
      builder: (context, child) {
        return Container(
          padding: EdgeInsets.only(top: topPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                musicName,
                style: TextStyle(color: animationColor.value, fontSize: 10),
              ),
              Text(
                artistName,
                style: TextStyle(color: animationColor.value!.withOpacity(0.5), fontSize: 8),
              ),
            ],
          ),
        );
      },
    );
  }
}
