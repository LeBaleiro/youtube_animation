import 'package:flutter/material.dart';

class PlayPauseWidget extends StatelessWidget {
  final Animation<Color?> animationColor;

  const PlayPauseWidget({Key? key, required this.animationColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: animationColor,
        builder: (context, child) {
          return Row(
            children: [
              Icon(
                Icons.play_arrow,
                color: animationColor.value,
              ),
              Icon(
                Icons.skip_next,
                color: animationColor.value,
              ),
            ],
          );
        });
  }
}
