import 'dart:async';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ClockView extends StatefulWidget {
  const ClockView({Key? key}) : super(key: key);

  @override
  State<ClockView> createState() => _ClockViewState();
}

class _ClockViewState extends State<ClockView> {
  @override
  void initState() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: -pi / 2,
      child: Container(
          height: 200,
          width: 200,
          child: CustomPaint(
            painter: ClockPainter(),
          )),
    );
  }
}

class ClockPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var time = DateTime.now();
    //if 60sec = 360 degrees, 1sec = 6 degrees
    // if 60min = 360 degrees, 1min = 6 degrees
    // if 12hours = 360 degrees, 1hour = 30 degrees

    var centerX = size.width / 2;
    var centerY = size.height / 2;
    var center = Offset(centerX, centerY);
    var radius = min(centerX, centerY);

    //X coordinate is X cost angle
    //Y coordinate is X sin angle

    var secHandX =
        centerX + (size.height * 0.25) * cos(time.second * 6 * pi / 180);
    var secHandY =
        centerX + (size.height * 0.25) * sin(time.second * 6 * pi / 180);
    var mintHandX =
        centerX + (size.height * 0.2) * cos(time.minute * 6 * pi / 180);
    var mintHandY =
        centerX + (size.height * 0.2) * sin(time.minute * 6 * pi / 180);
    var hourHandX =
        centerX + (size.height * 0.15) * cos(time.hour * 30 * pi / 180);
    var hourHandY =
        centerX + (size.height * 0.15) * sin(time.hour * 30 * pi / 180);

    var fillBrush = Paint()..color = CupertinoColors.white;
    var innerBrush = Paint()..color = CupertinoColors.black;
    var outlineBrush = Paint()
      ..color = CupertinoColors.black
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke;

    var secBrush = Paint()
      ..shader =
      const RadialGradient(colors: [Colors.black, Colors.grey])
          .createShader(Rect.fromCircle(center: center, radius: radius))
      ..strokeCap = StrokeCap.round
      ..color = CupertinoColors.systemYellow
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke;

    var mintBrush = Paint()
      ..color = CupertinoColors.black
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 7
      ..style = PaintingStyle.stroke;

    var hourBrush = Paint()
      ..color = CupertinoColors.black
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(center, radius - (size.height * 0.2), fillBrush);
    canvas.drawCircle(center, radius - (size.height * 0.2), outlineBrush);
    canvas.drawLine(center, Offset(secHandX, secHandY), secBrush);
    canvas.drawLine(center, Offset(mintHandX, mintHandY), mintBrush);
    canvas.drawLine(center, Offset(hourHandX, hourHandY), hourBrush);
    canvas.drawCircle(center, radius - (size.height * 0.45), innerBrush);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}