import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RoomPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Stack(
      children: <Widget>[
        _buildPath(context),
      ],
    );
  }
}

Widget _buildPath(BuildContext context) {
  return new Positioned.fill(
    bottom: MediaQuery.of(context).size.height - 256,
    child: new ClipPath(
      clipper: DialogonalClipper(),
      child: new Container(
        height: 256,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [Colors.yellow, Colors.red])),
        child: Stack(
          children: <Widget>[
            Opacity(
            opacity: 0.3,
            child: Circle(
                center: {"x": MediaQuery.of(context).size.width - 20, "y": 0},
                radius: 100)),
        Opacity(
            opacity: 0.3, child: Circle(center: {"x": 0, "y": 0}, radius: 150)),
        Opacity(
            opacity: 0.3,
            child: Circle(center: {
              "x": MediaQuery.of(context).size.width / 2 - 20,
              "y": 70
            }, radius: 20)),
        Opacity(
            opacity: 0.3,
            child: Circle(center: {
              "x": MediaQuery.of(context).size.width / 2 + 50,
              "y": 90
            }, radius: 35)),

             Opacity(
            opacity: 0.3,
            child: Circle(center: {
              "x": MediaQuery.of(context).size.width / 2 + 50,
              "y": 90
            }, radius: 100)),

          ],
        ),
      ),
    ),
  );
}

class DialogonalClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = new Path();

    path.lineTo(0.0, size.height - 20);

    var firstControlPoint = Offset(size.width / 4, size.height);
    var firstEndPoint = Offset(size.width / 2.25, size.height - 30.0);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondControlPoint =
        Offset(size.width - (size.width / 3.25), size.height - 65);
    var secondEndPoint = Offset(size.width, size.height - 40);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, size.height - 40);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

class Circle extends StatefulWidget {
  final Map<String, double> center;
  final double radius;

  Circle({this.center, this.radius});
  @override
  _CircleState createState() => _CircleState();
}

class _CircleState extends State<Circle> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height),
      painter: DrawCircle(center: widget.center, radius: widget.radius),
    );
  }
}

class DrawCircle extends CustomPainter {
  Map<String, double> center;
  double radius;
  DrawCircle({this.center, this.radius});
  @override
  void paint(Canvas canvas, Size size) {
    Paint brush = new Paint()
      ..color = Colors.white
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill
      ..strokeWidth = 30;
    canvas.drawCircle(Offset(center["x"], center["y"]), radius, brush);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}
