import 'package:flutter/material.dart';

class MoonWidget extends StatelessWidget {
  final double illumination; // 0-100
  const MoonWidget({super.key, required this.illumination});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
      width: 200,
      height: 200,
      child: CustomPaint(
        painter: _MoonPainter(illumination / 100),
      ),
    );
  }
}

class _MoonPainter extends CustomPainter {
  final double value; // 0-1
  _MoonPainter(this.value);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final paint = Paint()..color = Colors.white;
    canvas.drawCircle(center, radius, paint);

    final clipPath = Path();
    if (value < 0.5) {
      final theta = (1 - (value * 2)) * 3.14159;
      clipPath.addOval(Rect.fromCircle(center: center, radius: radius));
      canvas.saveLayer(Rect.fromLTWH(0, 0, size.width, size.height), Paint());
      canvas.drawCircle(center, radius, paint);
      paint.blendMode = BlendMode.dstOut;
      canvas.drawArc(Rect.fromCircle(center: center, radius: radius),
          -3.14159 / 2, theta, true, paint);
      canvas.restore();
    } else {
      final theta = ((value - 0.5) * 2) * 3.14159;
      clipPath.addOval(Rect.fromCircle(center: center, radius: radius));
      canvas.saveLayer(Rect.fromLTWH(0, 0, size.width, size.height), Paint());
      canvas.drawCircle(center, radius, paint);
      paint.color = Colors.black;
      canvas.drawArc(Rect.fromCircle(center: center, radius: radius),
          3.14159 / 2, theta, true, paint);
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant _MoonPainter oldDelegate) => oldDelegate.value != value;
}
