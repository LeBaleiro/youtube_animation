import 'package:flutter/material.dart';

import 'package:youtube_animation/models/music_model.dart';
import 'package:youtube_animation/widgets/player/bottom_player_content_widget.dart';
import 'package:youtube_animation/widgets/player/image_widget.dart';

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
  double initialLeftImagePadding = 12.0;
  double initialVerticalImagePadding = 5.0;
  double endTopImagePadding = 100.0;
  final duration = Duration(milliseconds: 500);
  late AnimationController animationController;
  late Animation<double> animation;
  late double lowerBound;
  late Animation<double> leftImagePaddingAnimation;
  late Animation<double> topImagePaddingAnimation;
  late Animation<double> imageAnimation;
  late Animation<Color?> animationItemsColor;
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
    leftImagePaddingAnimation = Tween<double>(begin: initialLeftImagePadding, end: 0.0).animate(animationController);
    topImagePaddingAnimation = Tween<double>(begin: initialVerticalImagePadding, end: endTopImagePadding).animate(animationController);
    imageAnimation = Tween<double>(begin: defaultHeight, end: MediaQuery.of(context).size.width).animate(animationController);
    animationItemsColor = ColorTween(begin: Colors.white, end: Colors.transparent).animate(animationController);
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
        child: Stack(
          children: [
            Positioned(
              left: defaultHeight + initialLeftImagePadding,
              child: BottomPlayerContentWidget(
                animationColor: animationItemsColor,
                musicName: widget.music.name,
                artistName: widget.music.artist,
                topPadding: initialVerticalImagePadding,
              ),
            ),
            ImageWidget(
              leftImagePaddingAnimation: leftImagePaddingAnimation,
              topImagePaddingAnimation: topImagePaddingAnimation,
              bottomPadding: initialVerticalImagePadding,
              imageAnimation: imageAnimation,
              imageUrl: widget.music.imageUrl,
            ),
          ],
        ),
        builder: (context, child) {
          return Container(
            width: MediaQuery.of(context).size.width,
            height: animation.value,
            color: Color(0xFF010101),
            child: child,
          );
        },
      ),
    );
  }
}
