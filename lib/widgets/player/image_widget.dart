import 'package:flutter/material.dart';

class ImageWidget extends StatelessWidget {
  final Animation<double> imageAnimation;
  final Animation<double> leftImagePaddingAnimation;
  final Animation<double> topImagePaddingAnimation;
  final double bottomPadding;

  final String imageUrl;

  const ImageWidget({
    Key? key,
    required this.imageAnimation,
    required this.leftImagePaddingAnimation,
    required this.imageUrl,
    required this.topImagePaddingAnimation,
    required this.bottomPadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: imageAnimation,
      builder: (context, child) {
        return Container(
          padding: EdgeInsets.only(
            left: leftImagePaddingAnimation.value,
            top: topImagePaddingAnimation.value,
            bottom: bottomPadding,
          ),
          child: Image.network(
            imageUrl,
            height: imageAnimation.value,
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }
}
