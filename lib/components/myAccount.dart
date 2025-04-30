import 'dart:io';
import 'package:flutter/material.dart';
import 'package:parking/components/buttons/iconTextButton.dart';
import 'package:parking/constants/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyAccount extends StatefulWidget {
  const MyAccount({super.key});

  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  final double coverheight = 10;
  String fullname = "";
  String email = "";
  String navLink = "/editProfile";

  File? _image;
  final imagePicker = ImagePicker();
  String? downloadURL;

  Future imagePickerMethod() async {
    final pick = await imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pick != null) {
        _image = File(pick.path);
      } else {
        showSnackBar("No File selected", Duration(milliseconds: 400));
      }
    });
  }

  showSnackBar(String snackText, Duration d) {
    final snackBar = SnackBar(content: Text(snackText), duration: d);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  getData() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();

    setState(() {
      fullname =
          "${pref.getString('firstname')!} ${pref.getString('lastname')!}";
      email = pref.getString('email')!;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    double x = MediaQuery.of(context).size.width * 0.6;
    return Padding(
      padding: EdgeInsets.only(left: 20, bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  IconButton(
                    alignment: Alignment.topLeft,
                    onPressed: () => {Navigator.pushNamed(context, "/")},
                    icon: Icon(
                      Icons.arrow_back,
                      size: 30,
                    ),
                    color: primaryColor,
                  ),
                  const Text(
                    "My Profile",
                    style: TextStyle(
                      color: fadeBlack,
                      fontSize: 32,
                      fontFamily: "Jost",
                    ),
                  ),
                ],
              ),
              Stack(
                // alignment: Alignment.center,
                // clipBehavior: Clip.none,
                children: [
                  CircleAvatar(
                    radius: x / 3,
                    backgroundImage: _image == null
                        ? AssetImage("assets/icons/ahmed.jpg")
                        : (FileImage(_image!)) as ImageProvider,
                  ),
                  Positioned(
                    top: x * .45,
                    right: 0.20,
                    child: Container(
                      color: primaryColor,
                      padding: EdgeInsets.all(5),
                      child: InkWell(
                        onTap: () {
                          imagePickerMethod();
                        },
                        child: Icon(
                          Icons.create,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: x * 0.1,
              ),
              Text("$fullname",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black,
                    fontFamily: 'Poppins',
                  )),
              const SizedBox(
                height: 13,
              ),
              Text(
                email,
                style: const TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 14,
                  color: Colors.black,
                  fontFamily: 'Poppins',
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          myTextIconButton(
              "Edit Profile",
              primaryColor,
              "/myprofile",
              const Icon(
                Icons.person_outline_rounded,
                color: primaryColor,
              )),
          SizedBox(
            height: 5,
          ),
          myTextIconButton(
              "Logout",
              secondayColor,
              "/login",
              const Icon(
                Icons.logout_outlined,
                color: secondayColor,
              ))
        ],
      ),
    );
  }
}
