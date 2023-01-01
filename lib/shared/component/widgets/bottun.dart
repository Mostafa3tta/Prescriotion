import 'package:flutter/material.dart';

myButton({
  required Function() onPressed,
  double? circleRadius,
  double? elevation,
  Color? color,
  double? inButtonSpace,
  required Widget child,
}) {
  return MaterialButton(
    onPressed: onPressed,
    elevation: elevation,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(circleRadius!),
    ),
    color: color,
    child: Row(
      children: [
        SizedBox(
          width: inButtonSpace,
        ),
        child
      ],
    ),
  );
}
