
import 'package:flutter/material.dart';
import "package:parking/forget/updatePassword.dart";

import "package:shared_preferences/shared_preferences.dart";
import "package:http/http.dart" as http;
import "package:email_validator/email_validator.dart";
import "package:parking/constants/constants.dart";

class Reset extends StatefulWidget {
  const Reset({Key? key}) : super(key: key);
  @override
  State<Reset> createState() => _ResetState();
}

class _ResetState extends State<Reset> {
final _key=GlobalKey<FormState>();
final emailController = TextEditingController();
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
                      "Forget your password",
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
                               _buildEmail(),
                             
                                SizedBox(
                                  height: 50,
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
                            
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)
                                  )
                                  ),
                          onPressed: () {
                          //  sendOtp(emailController.text);
                          if (_key.currentState!.validate()) {
                           sendOtp(emailController.text);
                          
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
                                    'Reset',
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

Widget _buildEmail() {
    return TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: "Email",
                    
                    prefixIcon: Icon(Icons.email),
                  ),
                  validator: (value) {
                    if (value!=null && !EmailValidator.validate(emailController.text.toString())) {
                      return "Not Valide Email";
                    }
                   
                  },
                  
                );
}

 void sendOtp(String email) async {
 
 http.Response response = await http.post(
    Uri.parse(url+"/forget-password"),body: {"email": email});
  if (response.statusCode == 200)
  {
SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
sharedPreferences.setString("emailUpdate", email);
Navigator.push(context, MaterialPageRoute(builder: (context)=>UpdatePassword()));
  }
else{

}

  
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