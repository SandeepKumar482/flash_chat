import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  RoundedButton(
      {required this.animation,
      required this.color,
      required this.onTap,
      required this.title});

  final Animation animation;
  final Color color;
  final String title;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: animation.value * 16),
      child: Material(
        elevation: 7.0,
        color: color,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: () {
            onTap();
          },
          minWidth: 180.0,
          height: animation.value * 49,
          child: Text(
            title,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
