import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:parking/components/buttons/iconButton.dart';
import 'package:parking/constants/constants.dart';
import "package:http/http.dart" as http;
import "dart:convert";
import "package:shared_preferences/shared_preferences.dart";

class BookingPage extends StatefulWidget {
  String slot = '';
  String status;
  String endTime;
  String startTime;
  BookingPage(this.slot, this.status, this.startTime, this.endTime);

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  _BookingPageState() {
    initialPlate = '';
  }
  DateTime _entrydateTime = DateTime.now();
  DateTime _exitdateTime = DateTime.now();
  var formatter = DateFormat('d-MM-yyyy');
  TimeOfDay? entyTime = TimeOfDay.now();
  TimeOfDay? exitTime = TimeOfDay.now();
  final myCars = [];
  String? initialPlate;
  String error = '';

  void getUserCar() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String token=pref.getString("token").toString();
    String email = pref.getString("email").toString();
    http.Response response = await http.post(
        Uri.parse(url+"/getMyCar"),
        body: {"email": email},
        headers: {"token":token}
        );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      var plates = data['plate'];
      setState(() {
        for (var plate in plates) {
          myCars.add(plate);
        }
        initialPlate = myCars[0];
      });
    }
  }

  @override
  void initState() {
    getUserCar();
    super.initState();
  }

  void _updateEntryTime() async {
    TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: entyTime!,
    );
    if (newTime != null) {
      setState(() {
        entyTime = newTime;
      });
    }

    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day),
      lastDate: DateTime(DateTime.now().year, DateTime.now().month + 1, 1),
    ).then((value) {
      setState(() {
        _entrydateTime = value!;
      });
    });
  }

  void _updateExitTime() async {
    TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: exitTime!,
    );
    if (newTime != null) {
      setState(() {
        exitTime = newTime;
      });
    }
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day),
      lastDate: DateTime(DateTime.now().year, DateTime.now().month + 1, 1),
    ).then((value) {
      setState(() {
        _exitdateTime = value!;
      });
    });
  }

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
              height: 20,
            ),
            IconButton(
              alignment: Alignment.topLeft,
              onPressed: () => {Navigator.pushNamed(context, "/")},
              icon: Icon(
                Icons.arrow_back,
                size: 30,
              ),
              color: primaryColor,
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                const Text(
                  "Book",
                  style: TextStyle(
                    fontSize: 32,
                    fontFamily: "Jost",
                    color: primaryColor,
                  ),
                ),
                const Text(
                  " Right Now!",
                  style: TextStyle(
                    color: fadeBlack,
                    fontSize: 32,
                    fontFamily: "Jost",
                  ),
                ),
                Stack(
                  children: [
                    Container(),
                    Positioned(
                      top: 5,
                      left: 5,
                      child: Image.asset(
                        "assets/icons/Vector.png",
                        width: 100,
                        height: 100,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const Text(
              "For better Service",
              style: TextStyle(
                color: fadeBlack,
                fontFamily: "Jost",
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(
                      color: primaryColor.withOpacity(0.2),
                      width: 2,
                    ),
                    color: Color.fromARGB(255, 240, 239, 239),
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Row(children: [
                    Container(
                      height: 60,
                      width: 60,
                      child: Image.asset("assets/icons/car.png"),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: primaryColor.withOpacity(0.3),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                            "Vehicle Plate number",
                            style: TextStyle(
                              color: fadeBlack,
                              fontSize: 20,
                            ),
                          ),
                          Container(
                              width: 200,
                              height: 80,
                              padding: EdgeInsets.all(2),
                              child: plate())
                        ]),
                  ]),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(
                      color: primaryColor.withOpacity(0.2),
                      width: 2,
                    ),
                    color: Color.fromARGB(255, 240, 239, 239),
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Row(children: [
                    Container(
                      height: 60,
                      width: 60,
                      child: Center(
                        child: Text(
                          "Slot " + widget.slot,
                          style: TextStyle(
                            color: fadeBlack,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      // child: Icon(
                      //   Icons.location_on,
                      //   size: 35,
                      //   color: primaryColor,
                      // ),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: primaryColor.withOpacity(0.3),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          widget.status == "booked"
                              ? Column(children: [
                                  Text(
                                    "booked start time " + widget.startTime,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 17,
                                    ),
                                  ),
                                  Text(
                                    "booked end time " + widget.endTime,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 17,
                                    ),
                                  )
                                ])
                              : Padding(
                                  padding: EdgeInsets.only(left: 30),
                                  child: Text(
                                    "Free",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                    ),
                                  ),
                                )
                        ]),
                  ]),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            const Text(
              "Select Start Date",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            myIconButton(
              "${entyTime!.format(context).toString()}       ${formatter.format(_entrydateTime).toString()}",
              primaryColor,
              _updateEntryTime,
              const Icon(Icons.access_time),
            ),
            SizedBox(
              height: 10,
            ),
            const Text(
              "Select End Date",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            myIconButton(
              "${exitTime!.format(context).toString()}       ${formatter.format(_exitdateTime).toString()}",
              secondayColor,
              _updateExitTime,
              const Icon(Icons.access_time),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async => {book()},
              child: Text("Book Now"),
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                elevation: 0,
                minimumSize: Size(MediaQuery.of(context).size.width, 40),
              ),
            ),
            Text(
              error,
              style: TextStyle(
                  color: Colors.red, fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  void book() async {
    String entryPeriod = "${entyTime!.period.toString().split('.')[1]}";
    String exitPeriod = "${exitTime!.period.toString().split('.')[1]}";
    int exithour = exitTime!.hour;

    double entryTotalTime = entyTime!.hour + entyTime!.minute / 60;
    double exitTotalTime = exitTime!.hour + exitTime!.minute / 60;

    if (entryPeriod == "pm") {
      setState(() {
        error = "No Booking at night check time period";
      });
    } else if (exitPeriod == "pm" && exithour != 12) {
      setState(() {
        error = "No Booking at night check time period";
      });
    } else if (entryTotalTime + 1 >= exitTotalTime) {
      setState(() {
        error = "Time setting error";
      });
    } else if (widget.status == "booked") {
      String entryBookTime = widget.startTime;
      String endBookTime = widget.endTime;
      DateFormat formats = DateFormat("HH:mm");
      DateTime bookEntryParser = formats.parse(entryBookTime);
      DateTime bookEndParser = formats.parse(endBookTime);

      double book_entry_hourse =
          bookEntryParser.hour + bookEntryParser.hour / 60;
      double book_end_hourse = bookEndParser.hour + bookEndParser.minute / 60;

      if (entryTotalTime >= book_end_hourse + 1) {
        sendBookeData();
      } else if (exitTotalTime + 1 <= book_entry_hourse) {
        sendBookeData();
      } else {
        setState(() {
          error = "Slot is reserved at This time";
        });
      }
    } else {
      sendBookeData();
    }
  }

  void sendBookeData() async {
    SharedPreferences prefs=await SharedPreferences.getInstance();
    String token=prefs.getString("token").toString();
    String entryPeriod = "${entyTime!.period.toString().split('.')[1]}";
    String exitPeriod = "${exitTime!.period.toString().split('.')[1]}";
    http.Response response =
        await http.post(Uri.parse(url+"/reserve"), body: {
      "slotNum": widget.slot,
      "day_start": _entrydateTime.toString(),
      "day_end": _exitdateTime.toString(),
      "time_start":
          "${entyTime!.hour.toString()}:${entyTime!.minute.toString()} ${entryPeriod}",
      "time_end":
          "${exitTime!.hour.toString()}:${exitTime!.minute.toString()} ${exitPeriod}",
      "car_plate": initialPlate
    },
    headers: {"token":token}
    );

    if (response.statusCode == 200) {
      setState(() {
        error = "Booked Successfully";
      });
    } else {
      var decode = jsonDecode(response.body);
      setState(() {
        error = decode['error'] != null ? decode['error'] : "";
      });
    }
  }

  Widget plate() {
    return DropdownButtonFormField(
      icon: Icon(
        Icons.arrow_drop_down_circle,
        color: Colors.grey,
      ),
      value: initialPlate,
      items: myCars
          .map((e) => DropdownMenuItem(
                child: Text(e),
                value: e,
              ))
          .toList(),
      onChanged: (val) {
        setState(() => initialPlate = val as String);
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(),
      ),
    );
  }
}
