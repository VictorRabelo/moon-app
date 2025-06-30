import 'dart:math';
import 'package:flutter/material.dart';

class StarfieldWidget extends StatefulWidget {
  const StarfieldWidget({super.key});

  @override
  State<StarfieldWidget> createState() => _StarfieldWidgetState();
}

class _StarfieldWidgetState extends State<StarfieldWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  final Random _random = Random();
  final List<_Star> _stars = [];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 20))
      ..addListener(() => setState(() {}))
      ..repeat();
    for (int i = 0; i < 100; i++) {
      _stars.add(_Star(
        x: _random.nextDouble(),
        y: _random.nextDouble(),
        size: _random.nextDouble() * 2 + 1,
        speed: _random.nextDouble() * 0.0005 + 0.0002,
      ));
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _StarfieldPainter(_stars, _controller.value),
      child: const SizedBox.expand(),
    );
  }
}

class _Star {
  double x;
  double y;
  double size;
  double speed;

  _Star({required this.x, required this.y, required this.size, required this.speed});
}

class _StarfieldPainter extends CustomPainter {
  final List<_Star> stars;
  final double animationValue;

  _StarfieldPainter(this.stars, this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white.withOpacity(0.8);
    for (final star in stars) {
      final dx = star.x * size.width;
      final dy = (star.y + animationValue * star.speed * size.height) % size.height;
      canvas.drawCircle(Offset(dx, dy), star.size, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _StarfieldPainter oldDelegate) => true;
}
