// ignore_for_file: prefer_const_constructors

import 'package:dept_com/utils/consttants.dart';
import 'package:flutter/material.dart';

class TwoSideRoundedButton extends StatelessWidget {
  final String text;
  final double radius;
  final void Function()? press;

  const TwoSideRoundedButton({
    required Key key,
    required this.text,
    this.radius = 29,
    required this.press, required int radious,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: deepblue,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(radius),
            bottomRight: Radius.circular(radius),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
