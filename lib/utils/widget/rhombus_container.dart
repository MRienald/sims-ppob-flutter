import 'package:flutter/material.dart';

class RhombusContainer extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  final double borderRadius;

  RhombusContainer({
    required this.width,
    required this.height,
    required this.color,
    required this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: RhombusClipper(borderRadius),
      child: Container(
        width: width,
        height: height,
        color: color,
      ),
    );
  }
}

class RhombusClipper extends CustomClipper<Path> {
  final double borderRadius;

  RhombusClipper(this.borderRadius);

  @override
  Path getClip(Size size) {
    final path = Path();

    final w = size.width;
    final h = size.height;

    final dx = w / 2;
    final dy = h / 2;

    final radius = borderRadius;

    path.moveTo(dx, 0);
    path.lineTo(w - radius, dy - radius);
    path.lineTo(dx, h - radius);
    path.lineTo(radius, dy - radius);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
