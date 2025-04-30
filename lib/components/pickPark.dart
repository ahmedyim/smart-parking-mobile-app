import 'package:parking/components/pickParkCard.dart';
import 'package:flutter/material.dart';
import 'package:parking/constants/constants.dart';

class PickPark extends StatelessWidget {
  String txt;
  Color firstColor;
  PickPark(
    this.txt,
    this.firstColor,
  );

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Column(
        children: [
          PickParkCard(
            firstColor,
            txt,
            Border(
              top: BorderSide(color: fadeBlack),
              bottom: BorderSide(color: fadeBlack),
              right: BorderSide(color: fadeBlack),
            ),
          ),
        ],
      ),
    ]);
  }
}
