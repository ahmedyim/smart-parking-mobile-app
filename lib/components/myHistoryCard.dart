import 'package:flutter/material.dart';
import 'package:parking/constants/constants.dart';

class MyHistoryCard extends StatelessWidget {
  final String initialDate;
  String finalDate;
  bool isCompleted;
  MyHistoryCard({
    required this.initialDate,
    required this.finalDate,
    required this.isCompleted,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Container(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Row(
            children: [
              Image.asset("assets/icons/pendingCar.png"),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "01155 AA",
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: "JOst",
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    "${initialDate} - ${finalDate}",
                    style: TextStyle(
                      color: fadeBlack,
                      fontFamily: "JOst",
                      fontSize: 14,
                    ),
                  ),
                  Row(
                    children: [
                      const Text(
                        "10hr",
                        style: TextStyle(
                          color: primaryColor,
                          fontFamily: "JOst",
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 3,
                          horizontal: 6,
                        ),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(width: 1, color: primaryColor)),
                        child: Text(
                          isCompleted ? "Completed" : "Pending",
                          style: TextStyle(
                            color: primaryColor,
                            fontFamily: "JOst",
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
        color: Colors.white70,
      ),
    );
  }
}
