import 'package:flutter/material.dart';

class myIconButton extends StatelessWidget {
  final String title;
  final Color color;
  final Icon icon;
  VoidCallback onClick;

  myIconButton(this.title, this.color, this.onClick, this.icon);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onClick,
      label: Text(title),
      icon: icon,
      style: ElevatedButton.styleFrom(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: 90),
          backgroundColor: color,
          elevation: 0,
          minimumSize: Size(MediaQuery.of(context).size.width, 44)),
    );
  }
}
