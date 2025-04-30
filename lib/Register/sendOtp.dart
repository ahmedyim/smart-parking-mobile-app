import 'package:flutter/material.dart';
import "package:firebase_auth/firebase_auth.dart";
import "package:pinput/pinput.dart";
import "package:shared_preferences/shared_preferences.dart";
import "dart:convert";
import "./UserModel/userModel.dart";



 String? otp;
String code="";
 Future sendOtp() async {
  SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
  Map<String,dynamic>userJson=jsonDecode(sharedPreferences.getString("register")!);
  UserModel user=UserModel.fromJson(userJson);
  String phone;
   phone=user.phone.toString();
   
 
  await FirebaseAuth.instance.verifyPhoneNumber(
    phoneNumber: phone,
    verificationCompleted: (PhoneAuthCredential credential) {},
    verificationFailed: (FirebaseAuthException e) {
       print("From Otp send eror rrrrrrrrrrrrrrrrr");
      sharedPreferences.setString("otpError", e.toString());
    },
    codeSent: (String verificationId, int? resendToken) {
      
      code=verificationId;
     print("From Otp send file lllllllllllllllllllllllllll");
      print(verificationId);
    sharedPreferences.setString("verificationId",code);
    // print(sharedPreferences.getString("otp")); 
    },
    
    codeAutoRetrievalTimeout: (String verificationId) {},
    
  );

  // PhoneAuthCredential credential=PhoneAuthProvider.credential(
  //   verificationId: code,
     
  // );
  sharedPreferences.setString("otp",code);
 

}