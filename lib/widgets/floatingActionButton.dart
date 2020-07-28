import 'package:flutter/material.dart';

class CustomFabButton extends StatefulWidget {
  final IconData icon;
  final Color color;
  final VoidCallback onPressed;

  const CustomFabButton({Key key, this.icon, this.color, this.onPressed})
      : super(key: key);

  @override
  _CustomFabButtonState createState() => _CustomFabButtonState();
}

class _CustomFabButtonState extends State<CustomFabButton> {
  int _currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    if (_currentIndex == 0) {
      return GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedContainer(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.blue,
          ),
          duration: Duration(seconds: 1),
          height: 50.0,
          width: 50.0,
          child: Icon(widget.icon),
        ),
      );
    } else {
      return GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedContainer(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.yellow,
          ),
          duration: Duration(seconds: 1),
          height: 50.0,
          width: 50.0,
          child: Icon(widget.icon),
        ),
      );
    }
  }
}
