import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as math;

class CustomMusicProgressPainter extends CustomPainter {
  var progressInDegrees;

  CustomMusicProgressPainter(this.progressInDegrees);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.black12
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;

    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = size.width / 2;
    canvas.drawCircle(center, radius, paint);

    paint = Paint()
      ..shader = LinearGradient(
              colors: [Color(0xFF2c159e), Color(0xFF4025b5), Color(0xFF2c159e)])
          .createShader(Rect.fromCircle(center: center, radius: radius))
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8.0;

    canvas.drawArc(Rect.fromCircle(center: center, radius: radius),
        math.radians(-65), math.radians(progressInDegrees), false, paint);
//    canvas.drawDRRect(RRect., RRect.zero, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class CustomCurvedMenuClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    Paint paint = Paint();
    final width = size.width;
    final height = size.height;

    paint.color = Colors.white;

    path.quadraticBezierTo(0, 10, 10, 16);
    path.quadraticBezierTo(width - 1, height / 2 - 20, width, height / 2);
    path.quadraticBezierTo(width + 1, height / 2 + 20, 10, height - 16);
    path.quadraticBezierTo(0, height - 10, 0, height);

//   path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
