import 'dart:ui';

import 'package:flutter/material.dart';

class DrawScreen extends StatefulWidget {
  @override
  _DrawScreenState createState() => _DrawScreenState();
}

class _DrawScreenState extends State<DrawScreen> {
  List<Offset?> points = [];
  Color _selectedColor = Colors.black;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Drawing Screen'),
        backgroundColor: Colors.orange,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: GestureDetector(
                onPanUpdate: (details) {
                  setState(() {
                    points.add(details.localPosition);
                  });
                },
                onPanEnd: (_) {
                  setState(() {
                    points.add(null);
                  });
                },
                child: CustomPaint(
                  painter: DrawingPainter(points, _selectedColor),
                  size: Size.infinite,
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _ColorButton(Colors.black, selectColor),
                _ColorButton(Colors.red, selectColor),
                _ColorButton(Colors.blue, selectColor),
                _ColorButton(Colors.green, selectColor),
                _ColorButton(Colors.yellow, selectColor),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void selectColor(Color color) {
    setState(() {
      _selectedColor = color;
    });
  }
}

class DrawingPainter extends CustomPainter {
  final List<Offset?> points;
  final Color color;

  DrawingPainter(this.points, this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5.0;

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i]!, points[i + 1]!, paint);
      } else if (points[i] != null && points[i + 1] == null) {
        canvas.drawPoints(PointMode.points, [points[i]!], paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class _ColorButton extends StatelessWidget {
  final Color color;
  final Function(Color) onSelectColor;

  _ColorButton(this.color, this.onSelectColor);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onSelectColor(color);
      },
      child: Container(
        width: 40,
        height: 40,
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.black, width: 2),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    title: 'Pre-School Drawing App',
    home: DrawScreen(),
  ));
}
