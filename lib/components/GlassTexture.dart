import 'dart:ui';

import 'package:flutter/material.dart';

class GlassTexture extends StatelessWidget {
  final Widget container_child;
  final double width_;
  final double height_;
  final double padding_;
  const GlassTexture(
      {Key? key,
      required this.container_child,
      required this.height_,
      required this.width_,
      required this.padding_})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRect(
        child: BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
      child: Container(
        width: width_,
        height: height_,
        padding: EdgeInsets.all(padding_),
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white.withOpacity(0.05),
              Colors.white.withOpacity(0.0),
            ],
            stops: [0.1, 1],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.all(Radius.circular(10)),
          border: Border.all(
            color: Colors.white.withOpacity(0.1),
            width: 1.5,
          ),
        ),
        child: container_child,
      ),
    ));
  }
}
