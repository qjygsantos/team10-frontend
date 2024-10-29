import 'package:flutter/material.dart';

class DiamondContainer extends StatelessWidget {
  final Color color;
  final double height;
  final double width;

  const DiamondContainer(
      {super.key,
      required this.height,
      required this.color,
      required this.width});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: DiamondClipper(),
      child: Container(
        width: width,
        height: height,
        color: color,
      ),
    );
  }
}

class DiamondClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(size.width / 2, 0);
    path.lineTo(size.width, size.height / 2);
    path.lineTo(size.width / 2, size.height);
    path.lineTo(0, size.height / 2);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
