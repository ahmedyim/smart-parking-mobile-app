import 'package:parking/components/pickPark.dart';
import 'package:flutter/material.dart';
import 'package:parking/constants/constants.dart';
import "package:http/http.dart" as http;
import "package:shared_preferences/shared_preferences.dart";
import "dart:convert";

class PickBookPage extends StatefulWidget {
  const PickBookPage({super.key});

  @override
  State<PickBookPage> createState() => _PickBookPageState();
}

class _PickBookPageState extends State<PickBookPage> {
  List booked = [];
  List free = [];
  List reserved = [];
  bool fetch = false;
  final bookedList = [];
  var urls = url+"/slots";
  

  

  Future fetchSlotData() async {
   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
   String token=sharedPreferences.getString("token").toString();
   http.Response response = await http.get(Uri.parse(urls),
   headers: {"token":token}
   );
    if (response.statusCode == 200) {
      var resData = jsonDecode(response.body);
      var book = resData['booked'];
      var slotTime = resData['bookedTime'];
      setState(() {
        // Setting the booked slots
        if (booked.isNotEmpty) {
          booked = [];
        }
        int index = 0;
        for (var slot in book) {
          booked.add(slot);
          String userData = jsonEncode(slotTime[index]);
          sharedPreferences.setString("slot" + slot, userData);
          index = index + 1;
        }
        // final userjson=json.decode(slotTime) as List<dynamic>;
        // print(userjson.map((e) => SlotModel.fromJson(e)).toList());

        // Setting the free slots
        var freeSlots = resData['free'];
        if (free.isNotEmpty) {
          free = [];
        }
        for (var fslot in freeSlots) {
          free.add(fslot);
        }

        var reserveds = resData['reserved'];
        if (reserved.isNotEmpty) {
          reserved = [];
        }
        for (var reserv in reserveds) {
          reserved.add(reserv);
        }
      });
    }
    return [booked, free, reserved];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    padding: EdgeInsets.all(0),
                    alignment: Alignment.centerLeft,
                    onPressed: () => {Navigator.pushNamed(context, "/")},
                    icon: const Icon(
                      Icons.arrow_back,
                      size: 35,
                    ),
                    color: primaryColor,
                  ),
                  const Text(
                    "Pick Parking Slot",
                    style: TextStyle(
                      color: fadeBlack,
                      fontSize: 32,
                      fontFamily: "Jost",
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Select Parking Space",
                style: TextStyle(
                  color: fadeBlack,
                  fontFamily: "Jost",
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              FutureBuilder(
                  future: fetchSlotData(),
                  builder: (context, data) {
                    if (data.hasError) {
                      return Center(child: Text('Error:${data.error}'));
                    }
                    var slotss = data.data.toString();

                    return GridView.count(
                      physics: ScrollPhysics(),
                      shrinkWrap: true,
                      crossAxisSpacing: 0,
                      mainAxisSpacing: 0,
                      crossAxisCount: 2,
                      children: [
                        for (var i = 1;
                            i <
                                booked.length +
                                    free.length +
                                    reserved.length +
                                    1;
                            i++)
                          if (free.contains(i.toString()))
                            PickPark(i.toString(), lightGreen)
                          else if (reserved.contains(i.toString()))
                            PickPark(i.toString(), secondayColor)
                          else if (booked.contains(i.toString()))
                            PickPark(i.toString(), orange),

                        // Container(child: Text("HEllo"),),
                      ],
                    );
                  }),
              const SizedBox(
                height: 2,
              ),
              Center(
                child: Image.asset(
                  "assets/icons/car3.png",
                  height: MediaQuery.of(context).size.height * 0.3,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
