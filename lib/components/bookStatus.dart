
import 'package:flutter/material.dart';
import 'package:parking/constants/constants.dart';
import "package:http/http.dart" as http;
import "dart:convert";
import 'package:parking/models/UserModel/bookingHistory.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:timezone/standalone.dart' as tz;
import "package:parking/constants/constants.dart";
import "package:shared_preferences/shared_preferences.dart";



class MyBookStatus extends StatefulWidget {
  const MyBookStatus({super.key});

  @override
  State<MyBookStatus> createState() => _MyBookStatusState();
}

class _MyBookStatusState extends State<MyBookStatus> {

  int? length;
  List booking=[];
  
    int _seconds = 0;
  int _minutes = 0;
  int _hours = 0;

  // The state of the timer (running or not)
  bool _isRunning = false;
   Timer? _timer;

  // This function will be called when the user presses the start button
  // Start the timer
  // The timer will run every second
  // The timer will stop when the hours, minutes and seconds are all 0
  void _startTimer() {
    setState(() {
      _isRunning = true;
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_seconds > 0) {
          _seconds--;
        } else {
          if (_minutes > 0) {
            _minutes--;
            _seconds = 59;
          } else {
            if (_hours > 0) {
              _hours--;
              _minutes = 59;
              _seconds = 59;
            } else {
              _isRunning = false;
              _timer?.cancel();
            }
          }
        }
      });
    });
    
  }

    @override 
  void initState(){
    getBookingData();
    _startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
        
          for(int i=0;i<1;i++)
          booking.length==0?Text(""):bookingWidget(booking[i].toString(),booking[i+1].toString(),booking[i+2].toString(),booking[i+3].toString()),
          Text(_hours.toString())

          
         
        ],
      ),
    );
  }

//   Future<List<dynamic>> fectCompletedHistory() async {
//     var response = await http.post(
//         Uri.parse("http://192.168.67.10:5000/getcompletedHistory"),
//         body: {"car_id": "11111"});

//     List userjson = json.decode(response.body);
//     return userjson.map((e) => History.fromJson(e)).toList();
//   }

//   Future<List<dynamic>> fectPendingHistory() async {
//     var response = await http.post(
//         Uri.parse("http://192.168.67.10:5000/getPendingHistory"),
//         body: {"car_id": "11111"});

//     List userjson = json.decode(response.body);
//     return userjson.map((e) => History.fromJson(e)).toList();
//   }

Future getBookingData() async{

  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token=prefs.getString("token").toString();
   var response = await http.post(Uri.parse(url+"/booking-history"),
   body: {"email": prefs.getString("email")},
   headers:{"token":token}
   
   );
               if(response.statusCode==200)
               {
                 var responseData=jsonDecode(response.body);
                 String totalData=responseData['length'];
                 var bookinData=responseData['0'];
                 
                setState(() {
                
                if(totalData.isNotEmpty){
                    for(var book in bookinData){
                   booking.add(book);
                   }

        // final detroit = tz.getLocation('Africa/Addis_Ababa');  
        // final localizedDt = tz.TZDateTime.from(DateTime.now(), detroit); 
        
         
        String endBookTime= booking[1];
         DateFormat formats=DateFormat("HH:mm");
        DateTime bookEntryParser=formats.parse(endBookTime);
        _hours=bookEntryParser.hour;
        _minutes=bookEntryParser.minute;

                  
                }
                 
                });
               
                  
               }
               return booking;

   
  }

  bookingWidget(String date,String time,String plate,String slot)=>
  Column(
    children:[

  

     const SizedBox(
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
            child:  Text(
              '${_hours.toString().padLeft(2, '0')}:${_minutes.toString().padLeft(2, '0')}:${_seconds.toString().padLeft(2, '0')}',
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
                             Text(
                              "Plate Number ",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontFamily: "Jost",
                              ),
                            ),
                             Text(
                              plate,
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
                       Text(
                        date,
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
                       Text(
                        "Slot number "+slot,
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
    ]
  );
}
