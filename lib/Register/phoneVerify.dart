
import 'package:flutter/material.dart';
import "../Login/login.dart";
import "package:shared_preferences/shared_preferences.dart";
import "package:http/http.dart" as http;
import "package:firebase_auth/firebase_auth.dart";
import "dart:convert";
import "./UserModel/userModel.dart";
import "./sendOtp.dart";
import "package:parking/constants/constants.dart";
class MyPhone extends StatefulWidget {
  const MyPhone({Key? key}) : super(key: key);
  @override
  State<MyPhone> createState() => _MyPhoneState();
}

class _MyPhoneState extends State<MyPhone> {
final _key=GlobalKey<FormState>();
final passwordController=TextEditingController();
final confirmController=TextEditingController();
final otpController=TextEditingController();

bool error=false;
String notMatch="";
String? phone;
String opt_error="";
 
void getPhone() async{
   SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
  Map<String,dynamic>userJson=jsonDecode(sharedPreferences.getString("register")!);
  UserModel user=UserModel.fromJson(userJson);
   
   setState(() {
     phone=user.phone.toString();
   });

}
  void validatePhone() async {
    SharedPreferences sharedPreferences= await SharedPreferences.getInstance();
    String otp=sharedPreferences.getString("otp").toString();
  
  
  {
// Get smsCode
 final FirebaseAuth _auth=FirebaseAuth.instance;
//  get the stored vrId
 String verificationId=await sharedPreferences.getString("verificationId").toString();
String smsCode=otpController.text.trim().toString();
  void register() async{
      Map<String, dynamic> userJson =jsonDecode(sharedPreferences.getString("register")!);
      var urls = url+"/registerU";
                        http.Response response = await http
                        .post(Uri.parse(urls), body: userJson
                       );

                        if (response.statusCode==200)
                        {
                          sharedPreferences.remove("otp");
                          sharedPreferences.remove("register");
                          Navigator.push(
                                context,MaterialPageRoute(builder: (comtext)=>LoginPage())
                          );
                        }
                        else{
                          print("Not register");
                        }
  }
  
 try{

 PhoneAuthCredential  _credential=PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);
 final UserCredential authResult=await FirebaseAuth.instance.signInWithCredential(_credential);
 if(authResult.user!=null)
 {
  register();
 }
 else{
   setState(() {
    opt_error="incorrect  otp";
  });
  print("invalide code");
 }

 }

 catch(e){
  setState(() {
    opt_error="incorrect  otp please try agian";
    
  });
} 


   }
  }

 @override
  void initState() {
    // call send otp
    getPhone();
    sendOtp();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      "Verify $phone",
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "We need to register your phone without getting started!",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
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
                                TextField(
                                  controller: otpController,
                                  keyboardType: TextInputType.phone,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: "OTP",
                                  ),
                                ),
                                Center(
                                child: Text(
                                  opt_error,
                                  style: TextStyle(color: Colors.red),                               
                                ),
                                 
                               ),
                              
                                SizedBox(
                                  height: 6,
                                ),
           
                               
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
                            //  primary: primaryColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)
                                  )
                                  ),
                          onPressed: () {
                            //print(passwordController.text);
                           validatePhone();                          
                          },
                         
                                                      child: Container(
                                decoration: BoxDecoration(
                                    color: primaryColor,
                                    borderRadius: BorderRadius.circular(15)),
                                child: const Center(
                                    child: Padding(
                                  padding: EdgeInsets.all(15.0),
                                  child: Text(
                                    'Verify',
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
                    SizedBox(
                      width: double.infinity,
                      height: 45,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              // primary:primaryColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)
                                  )
                                  ),
                          onPressed: () {
                            //print(passwordController.text);
                           sendOtp();                          
                          },
                         
                          child:Container(
                                decoration: BoxDecoration(
                                    color: primaryColor,
                                    borderRadius: BorderRadius.circular(15)),
                                child: const Center(
                                    child: Padding(
                                  padding: EdgeInsets.all(15.0),
                                  child: Text(
                                    'Resend code',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                )),
                              ),),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      
    );
  }

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
    sharedPreferences.setString("verificationId",code.toString());

   
    // print(sharedPreferences.getString("otp"));
     
    },
    codeAutoRetrievalTimeout: (String verificationId) {},
    
  );

  // PhoneAuthCredential credential=PhoneAuthProvider.credential(
  //   verificationId: code,
     
  // );
  sharedPreferences.setString("otp",code);
 

}

  
}
/*
await FirebaseAuth.instance.verifyPhoneNumber(
                        phoneNumber: '+251 92 762 6158',
                        verificationCompleted:
                            (PhoneAuthCredential credential) {},
                        verificationFailed: (FirebaseAuthException e) {},
                        codeSent: (String verificationId, int? resendToken) {},
                        codeAutoRetrievalTimeout: (String verificationId) {},
                      );
                      Navigator.pushNamed(context, 'verify');

*/