import 'package:parking/constants/constants.dart';
import 'package:flutter/material.dart';

class MyOutlinedButton extends StatelessWidget {
  final String title;
  final Color color;
  Function()? onClick;
  MyOutlinedButton({required this.title, required this.color, this.onClick});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onClick,
      child: Text(title),
      style: OutlinedButton.styleFrom(
          foregroundColor: color,
          side: BorderSide(
            color: primaryColor,
          )),
    );
  }
}
