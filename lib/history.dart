import "package:flutter/material.dart";
import "package:http/http.dart" as http;
import "dart:convert";
import 'package:parking/models/UserModel/bookingHistory.dart';
import 'package:parking/constants/constants.dart';
import "package:parking/components/buttons/button.dart";
import "package:parking/components/buttons/myOutlinedButton.dart";
import "package:parking/components/myHistoryCard.dart";

class ParkHistory extends StatefulWidget {
  const ParkHistory({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ParkHistoryState createState() => _ParkHistoryState();
}

class _ParkHistoryState extends State<ParkHistory> {
  void onClickPending() {}

  void onClickCompleted() {}
  bool buttonChoice = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                IconButton(
                  padding: EdgeInsets.all(0),
                  alignment: Alignment.centerLeft,
                  onPressed: () => {Navigator.pushNamed(context, "/")},
                  icon: Icon(
                    Icons.arrow_back,
                    size: 35,
                  ),
                  color: primaryColor,
                ),
                const Text(
                  "My History",
                  style: TextStyle(
                    color: fadeBlack,
                    fontSize: 32,
                    fontFamily: "Jost",
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            const Text(
              "Four Recent booking history",
              style: TextStyle(
                color: fadeBlack,
                fontFamily: "Jost",
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                !buttonChoice
                    ? MyOutlinedButton(
                        title: "Pending",
                        color: primaryColor,
                        onClick: () {
                          setState(() {
                            buttonChoice = true;
                          });
                        },
                      )
                    : myButton(
                        title: "Pending",
                        color: primaryColor,
                        onClick: () {
                          setState(() {
                            buttonChoice = true;
                          });
                        },
                      ),
                !buttonChoice
                    ? myButton(
                        title: "Completed",
                        color: primaryColor,
                        onClick: () {
                          setState(() {
                            buttonChoice = false;
                          });
                        },
                      )
                    : MyOutlinedButton(
                        title: "Completed",
                        color: primaryColor,
                        onClick: () {
                          setState(() {
                            buttonChoice = false;
                          });
                        },
                      )
              ],
            ),
            FutureBuilder(
              future:
                  buttonChoice ? fectPendingHistory() : fectCompletedHistory(),
              builder: (context, data) {
                if (data.hasError) {
                  return Center(
                    child: Text("${data.error}"),
                  );
                } else if (data.hasData) {
                  var history = data.data as List<History>;
                  return Expanded(
                    child: ListView.builder(
                      itemCount: history.length,
                      itemBuilder: (context, index) {
                        var row = history[index];
                        return MyHistoryCard(
                          finalDate: "${row.time_end!.toString()}",
                          initialDate: "${row.time_start.toString()}",
                          isCompleted: !buttonChoice,
                        );
                      },
                    ),
                  );
                } else
                  return Center(
                    child: CircularProgressIndicator(),
                  );
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<List<dynamic>> fectCompletedHistory() async {
    var response = await http.post(
        Uri.parse(url+"/getcompletedHistory"),
        body: {"car_id": "11111"});

    List userjson = json.decode(response.body);
    return userjson.map((e) => History.fromJson(e)).toList();
  }

  Future<List<dynamic>> fectPendingHistory() async {
    var response = await http.post(
        Uri.parse(url+"/getPendingHistory"),
        body: {"car_id": "11111"});

    List userjson = json.decode(response.body);
    return userjson.map((e) => History.fromJson(e)).toList();
  }
}
