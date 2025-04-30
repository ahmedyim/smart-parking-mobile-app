import 'package:flutter/material.dart';
import 'package:parking/constants/constants.dart';
import "package:shared_preferences/shared_preferences.dart";
import "dart:convert";

import '../book.dart';

class PickParkCard extends StatefulWidget {
  Color color;
  String text;
  Border border;
  PickParkCard(this.color, this.text, this.border);
  PickParkCardState createState() => PickParkCardState();
}

class PickParkCardState extends State<PickParkCard> {
  String etime = '';
  String stime = '';
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width * 0.5 - 10,
      decoration: BoxDecoration(
        border: widget.border,
      ),
      child: Column(
        children: [
          Container(
            width: 120,
            height: 105,
            // ignore: sort_child_properties_last
            child: widget.color == orange
                ? InkWell(
                    onTap: () async {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BookingPage(
                                  widget.text, "booked", stime, etime)));
                    },
                    child: myWidgets(widget.text))
                : widget.color == secondayColor
                    ? InkWell(
                        onTap: () {},
                        child: Image.asset(
                          "assets/icons/car2.png",
                          // width: 42,
                        ),
                      )
                    : InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BookingPage(
                                      widget.text, "free", "", "")));
                        },
                        child: Container()),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: widget.color,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          Text(
            "Slot " + widget.text,
            style: const TextStyle(),
          ),
        ],
      ),
    );
  }

  Future fectSlotTime(String slotNum) async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    final userJson = jsonDecode(sharedPreference.getString("slot" + slotNum)!);
    setState(() {
      etime = userJson['endTime'];
      stime = userJson['startTime'];
    });

    print("Booked");
    print(userJson);

    return [etime, stime];
  }

  myWidgets(String slotNum) => FutureBuilder(
      future: fectSlotTime(slotNum),
      builder: (context, data) {
        return Column(
          children: [
            Text("start " + stime),
            Image.asset(
              "assets/icons/car2.png",
            ),
            Text("end " + etime),
          ],
        );
      });
}
