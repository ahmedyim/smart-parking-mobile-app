
import "dart:convert";

import 'package:flutter/material.dart';
import "package:parking/Login/login.dart";
import "package:shared_preferences/shared_preferences.dart";
import "package:http/http.dart" as http;
import "package:parking/constants/constants.dart";



class UpdatePassword extends StatefulWidget {
  const UpdatePassword({Key? key}) : super(key: key);
  @override
  State<UpdatePassword> createState() => _UpdatePasswordState();
}

class _UpdatePasswordState extends State<UpdatePassword> {
final _key=GlobalKey<FormState>();
final otpController = TextEditingController();
final passwordController=TextEditingController();
String respo="";
 @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body:
      Container(
          margin: EdgeInsets.only(left: 25, right: 25),         
          child: Center(
            child: Form(
              key: _key,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 25,
                    ),
                    Text(
                      "Update your password",
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                   
                    SizedBox(
                      height: 30,
                    ),
                     
                      Container(
                        decoration: BoxDecoration(
                            border: null, borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                              width: 2,
                            ),
                            Expanded(
                                child: Column(
                              children: [
                               _buildOTP(),
                             
                                SizedBox(
                                  height: 10,
                                ),
           
                               _buildPassword(),
                                SizedBox(
                                  height: 10,
                                ),
                                Center(
                                  child: Text(respo,style: TextStyle(color: Colors.red),),
                                )
                              ],
                            ))
                          ],
                        ),
                      ),
                    
                    SizedBox(
                      width: double.infinity,
                      height: 45,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                           
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)
                                  )
                                  ),
                          onPressed: () {
                            if (_key.currentState!.validate()) {
                           updatePassword();
                            }              
                          },
                          
                         
                           child: Container(
                                decoration: BoxDecoration(
                                    color: primaryColor,
                                    borderRadius: BorderRadius.circular(15)),
                                child: const Center(
                                    child: Padding(
                                  padding: EdgeInsets.all(15.0),
                                  child: Text(
                                    'Update Passowrd',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                )),
                              ),
                          ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    
                  ],
                ),
              ),
            ),
          ),
        ),
      
    );
  }

Widget _buildOTP() {
    return TextFormField(
                  keyboardType: TextInputType.text,
                  controller: otpController,
                  
                  decoration: InputDecoration(
                    labelText: "OTP",

                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "required";
                    }
                   
                  },
                  
                );
}
Widget _buildPassword() {
    return TextFormField(
                  keyboardType: TextInputType.text,
                  controller: passwordController,
                  
                  decoration: InputDecoration(
                    labelText: "New Password",

                  ),
                 validator: (value) {
                    if (value!.isEmpty) {
                      return "required";
                    }
                    if (!(value.isEmpty) && value.length < 6) {
                                  return "minimem password length required is 6";
                                }
                  },
                  
                );
}

 void updatePassword() async {

SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
String email=sharedPreferences.getString("emailUpdate").toString();

 http.Response response = await http.post(
    Uri.parse(url+"/reset_password"),body: {"email": email,"otp":otpController.text,"password":passwordController.text});
    var resData=jsonDecode(response.body);
  if (response.statusCode == 200)
  {
  Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
  }
else
{
  setState(() {
    respo=resData['error'];
  });

}

  
}
}
