import 'package:flutter/material.dart';
import 'package:quizz_app/app/common/widgets/app_colors.dart';

class BackgroundDecoration extends StatelessWidget {
  final Widget child;
  final bool showGradient;
  const BackgroundDecoration(
      {Key? key, required this.child, this.showGradient = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              color: showGradient ? null :const Color.fromARGB(255, 248, 97, 140),
              gradient: showGradient ? mainGradient(context) : null,
            ),
            child: CustomPaint(
              painter: BackgroudPainter(),
            ),
          ),
        ),
        Positioned(child: SafeArea(child: child))
      ],
    );
  }
}

class BackgroudPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Colors.white.withOpacity(0.1);
    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width * 0.2, 0);
    path.lineTo(0, size.height * 0.4);
    path.close();

    final path1 = Path();
    path1.moveTo(size.width, 0);
    path1.lineTo(size.width * 0.8, 0);
    path1.lineTo(size.width * 0.2, size.height);
    path1.lineTo(size.width, size.height);
    path1.close();

    canvas.drawPath(path, paint);
    canvas.drawPath(path1, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegata) {
    return false;
  }
}
