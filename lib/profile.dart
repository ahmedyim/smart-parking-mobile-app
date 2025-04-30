import 'dart:io';
import 'package:parking/components/buttons/primayButton.dart';
import 'package:parking/components/myTextField.dart';
import 'package:flutter/material.dart';

import 'package:parking/constants/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final double coverheight = 10;
  final _usernameController = TextEditingController();
  final _drivingLicenceController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
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
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: 20, right: 20),
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
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                  ],
                ),
                Stack(
                  alignment: Alignment.center,
                  clipBehavior: Clip.none,
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
                        ))
                  ],
                ),
                SizedBox(
                  height: x * 0.1,
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            myTextField("Username", _usernameController),
            const SizedBox(
              height: 10,
            ),
            myTextField("Driving Licence Number", _drivingLicenceController),
            const SizedBox(
              height: 10,
            ),
            myTextField("Phone Number", _phoneController),
            const SizedBox(
              height: 10,
            ),
            myTextField("email", _emailController),
            const SizedBox(
              height: 10,
            ),
            myPrimaryButton("Update", () => {})
          ],
        ),
      ),
    );
  }
}
