import 'package:flutter/material.dart';
import 'package:parking/constants/constants.dart';

class myPrimaryButton extends StatelessWidget {
  final String title;
  final Function()? onClick;

  const myPrimaryButton(this.title, this.onClick);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => {},
      child: Text(title),
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        elevation: 0,
        minimumSize: Size(MediaQuery.of(context).size.width, 40),
      ),
    );
  }
}
