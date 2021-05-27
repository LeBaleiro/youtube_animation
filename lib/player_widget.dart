import 'package:flutter/material.dart';

import 'package:youtube_animation/models/music_model.dart';

class PlayerWidget extends StatefulWidget {
  final MusicModel music;

  const PlayerWidget({
    Key? key,
    required this.music,
  }) : super(key: key);
  @override
  _PlayerWidgetState createState() => _PlayerWidgetState();
}

class _PlayerWidgetState extends State<PlayerWidget> with TickerProviderStateMixin {
  double defaultHeight = 50.0;
  final duration = Duration(milliseconds: 500);
  late AnimationController animationController;
  late Animation<double> animation;
  late double lowerBound;
  late Animation<double> paddingAnimation;
  late Animation<double> imageAnimation;
  AnimationStatus animationStatus = AnimationStatus.completed;
  double currentAnimationValue = 0.0;
  double lastestAnimationValue = 0.0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    animationController = AnimationController(
      vsync: this,
      duration: duration,
    );
    animation = Tween<double>(begin: defaultHeight, end: MediaQuery.of(context).size.height).animate(animationController);
    paddingAnimation = Tween<double>(begin: 12, end: 0.0).animate(animationController);
    imageAnimation = Tween<double>(begin: defaultHeight, end: MediaQuery.of(context).size.width).animate(animationController);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragUpdate: (details) {
        final newValue =
            (animationController.value * MediaQuery.of(context).size.height - details.delta.dy) / MediaQuery.of(context).size.height;
        lastestAnimationValue = currentAnimationValue;
        animationController.value = newValue;
        currentAnimationValue = newValue;
      },
      onVerticalDragEnd: (details) {
        bool isForward = currentAnimationValue > lastestAnimationValue;
        bool isAfter1per4FromScreen = animationController.value > 1 / 4;
        bool isAfter3per4FromScreen = animationController.value > 3 / 4;
        if ((isForward && isAfter1per4FromScreen) || isAfter3per4FromScreen) {
          animationController.forward();
        } else {
          animationController.reverse();
        }
      },
      child: AnimatedBuilder(
        animation: animation,
        builder: (context, child) {
          return Container(
            padding: EdgeInsets.only(left: paddingAnimation.value),
            width: MediaQuery.of(context).size.width,
            height: animation.value,
            color: Color(0xFF010101),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  widget.music.imageUrl,
                  height: imageAnimation.value,
                  fit: BoxFit.cover,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
