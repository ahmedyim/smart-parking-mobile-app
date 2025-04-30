import "dart:convert";
import 'package:flutter/material.dart';
import "package:parking/homescreen.dart";
import "package:email_validator/email_validator.dart";
import "package:http/http.dart" as http;
import "package:parking/constants/constants.dart";
import "package:shared_preferences/shared_preferences.dart";
import ".././Register/register.dart";
import "package:parking/forget/reset.dart";
class LoginPage extends StatefulWidget {
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  // text editing controller
  String _email = "";
  String _password = "";
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final phone = TextEditingController();
  bool passToggle = true;

  String navLink = "";
  String Incorrect = "";
  
 Future<bool> _onWillPop() async {
  return (await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: new Text('Are you sure?'),
          content: new Text('Do you want to exit an App'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false), //<-- SEE HERE
              child: new Text('No'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true), // <-- SEE HERE
              child: new Text('Yes'),
            ),
          ],
        ),
      )) ??
      false;
}
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Center(
                child: Form(
                  key: _formkey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Padding(
                    padding: EdgeInsets.only(left: 3, right: 3),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const SizedBox(height: 20),
    
                        // welcome back, you've been missed!
                        const Text(
                          "Login",
                          style: TextStyle(
                            color: fadeBlack,
                            fontSize: 48,
                            fontFamily: "Jost",
                          ),
                        ),
    
                        const SizedBox(height: 20),
    
                        // username textfieldF
                        _buildEmail(),
    
                        const SizedBox(height: 20),
    
                        // password textfield
                        _buildPassword(),
    
                        const SizedBox(height: 5),
                        Text(
                          Incorrect,
                          style: TextStyle(color: Colors.red),
                        ),
    
                        const SizedBox(height: 5),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18.0),
                          child: GestureDetector(
                            onTap: (() async {
                               
                              if (_formkey.currentState!.validate()) {
                                String email = emailController.text;
                                String pass = passController.text;
                                //  SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
                                // sharedPreferences.setString("email", email);
    
                                http.Response response = await http.post(
                                    Uri.parse(url+"/api/user-login"),
                                    body: {"email": email, "password": pass});
                                if (response.statusCode == 200) {
                                  var resData = jsonDecode(response.body);
                                   var token = resData['token'];
                                   print(token.toString());
                                  SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
                                  sharedPreferences.setString("email", email);
                                  sharedPreferences.setString("token",token.toString());
                                  setState(() {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => HomeScreen()));
                                  });
                                } else {
                                  var error = jsonDecode(response.body);
                                  setState(() {
                                    Incorrect = error['error'];
                                  });
                                }
                              }
                            }),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.circular(15)),
                              child: const Center(
                                  child: Padding(
                                padding: EdgeInsets.all(15.0),
                                child: Text(
                                  'Sign In',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              )),
                            ),
                          ),
                        ),
    
                        // var data= await fetchUser("ahmed@gmail.com", "12345");
    
                        //  var decode=jsonDecode(data);
                        //       setState((){
                        //        status = decode['output'];
    
                        // });
    
                        const SizedBox(height: 10),
                        // forgot password?
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Don't Have Account? ",
                                style: TextStyle(
                                  color: primaryColor,
                                ),
                              ),
                              TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                RegisterForm()));
                                  },
                                  child: Text(
                                    "Sign Up",
                                    style: TextStyle(
                                        color: secondayColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  )),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 50,
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(color: Colors.black))),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Reset()));
                                },
                                child: Text(
                                  "Forgot Password?",
                                  style: TextStyle(
                                      color: primaryColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                width: 50,
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(color: Colors.black))),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
    
                        // sign in button
    
                        // or continue with
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Divider(
                                  thickness: 0.5,
                                  color: Colors.grey[400],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmail() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        controller: emailController,
        decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
            prefixIcon: Icon(Icons.email),
            fillColor: Colors.grey.shade200,
            filled: true,
            hintText: "Eamil",
            hintStyle: TextStyle(color: Colors.grey[500])),
        validator: (email) {
          if (email != null && !EmailValidator.validate(email)) {
            return "Enter valid Email";
          }
        },
        onSaved: (newValue) {
          _email = newValue.toString();
        },
      ),
    );
  }

  Widget _buildPassword() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        controller: passController,
        obscureText: passToggle,
        decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
            prefixIcon: Icon(Icons.lock),
            fillColor: Colors.grey.shade200,
            filled: true,
            hintText: "Passowrd",
            hintStyle: TextStyle(color: Colors.grey[500]),
            suffix: InkWell(
              onTap: () {
                setState(() {
                  passToggle = !passToggle;
                });
              },
              child: Icon(passToggle ? Icons.visibility : Icons.visibility_off),
            )),
        validator: (value) {
          if (value!.isEmpty) {
            return "Enter password";
          }
        },
      ),
    );
  }
}
