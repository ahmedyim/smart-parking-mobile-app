import 'package:flutter/material.dart';

class myButton extends StatelessWidget {
  final String title;
  final Color color;
  Function()? onClick;

  myButton({required this.title, required this.color, this.onClick});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onClick,
      child: Text(title),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        elevation: 0,
        // minimumSize: Size(MediaQuery.of(context).size.width, 40),
      ),
    );
  }
}
