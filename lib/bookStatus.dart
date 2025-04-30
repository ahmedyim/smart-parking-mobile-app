import 'package:flutter/material.dart';
import 'package:parking/constants/constants.dart';
import "package:http/http.dart" as http;
import "dart:convert";
import 'package:parking/models/UserModel/bookingHistory.dart';

class MyBookStatus extends StatefulWidget {
  const MyBookStatus({super.key});

  @override
  State<MyBookStatus> createState() => _MyBookStatusState();
}

class _MyBookStatusState extends State<MyBookStatus> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 40,
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, top: 20),
            child: Row(
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
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Center(child: Image.asset("assets/icons/carstat.png")),
          SizedBox(
            height: 10,
          ),
          Center(
            child: const Text(
              "05:24:45",
              style: TextStyle(
                color: fadeBlack,
                fontSize: 32,
                fontFamily: "Jost",
              ),
            ),
          ),
          Container(
            // decoration: BoxDecoration(
            //   color: primaryColor,
            // ),
            child: Stack(
              children: [
                Container(
                  color: primaryColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Plate Number",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontFamily: "Jost",
                              ),
                            ),
                            const Text(
                              "A12456",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontFamily: "Jost",
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.040,
                  left: MediaQuery.of(context).size.width * 0.4,
                  child: Image.asset(
                    "assets/icons/car5.png",
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.date_range_rounded,
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      const Text(
                        "2023-06-22",
                        style: TextStyle(
                          color: fadeBlack,
                          fontSize: 18,
                          fontFamily: "Jost",
                        ),
                      ),
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: primaryColor),
                ),
              ),
              Container(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "P",
                        style: TextStyle(
                          color: fadeBlack,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Jost",
                        ),
                      ),
                      const Text(
                        "Slot number 1",
                        style: TextStyle(
                          color: fadeBlack,
                          fontSize: 18,
                          fontFamily: "Jost",
                        ),
                      ),
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: primaryColor),
                ),
              ),
            ],
          )
        ],
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
