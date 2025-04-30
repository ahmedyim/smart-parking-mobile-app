import "package:flutter/material.dart";
import "package:email_validator/email_validator.dart";
import "./sendUserData.dart";
import "dart:convert";
import "package:http/http.dart" as http;
import "package:shared_preferences/shared_preferences.dart";
import "UserModel/userModel.dart";
import "phoneVerify.dart";
import "package:parking/constants/constants.dart";
import "package:parking/Login/login.dart";

class RegisterForm extends StatefulWidget{
  @override
  _Register createState()=> _Register();
}
class _Register extends State<RegisterForm>{
   
   _Register(){
      _carRegionVal=_carRegion[0];
      _carCodeVal=_carCode[0];
      _gender=_Gender[0];
   }
    final _formKey = GlobalKey<FormState>();
  // input controllers
  final emailController = TextEditingController();
  final phoneController = TextEditingController(text: "+251");
   final fnameController = TextEditingController();
  final lnameController = TextEditingController();
   final licenceController = TextEditingController();
   final plateController=TextEditingController();
  final carPlate = TextEditingController();
  final password = TextEditingController();
  String email_response="";
  String phone_response="";
  String plate_response="";
  String license_response="";
  String password_response="";


  //  Car regional state and car code
  final  _carRegion=["A A","ORO","A M","S P"];
   String ? _carRegionVal="";

    final  _carCode=["0 1","0 2","0 3","0 4"];
   String ? _carCodeVal="";

   final  _Gender=["Male","Female"];
   String ? _gender="";

  // validate form values
   final LicenseValidation=RegExp(r'^[0-9]{6}$');
   final nameValidation=RegExp(r'^[a-zA-Z]{1,}');
   final phoneValidation=RegExp(r'^((\+[251]{1})([0-9]{11}))$');
   final plateValidation1=RegExp(r'^[0-9]{6}$');
   

late SharedPreferences sharedPreferences;

  @override 
  void initState(){
    saveUserData();
    super.initState();
  }

void saveUserData() async{
  sharedPreferences= await SharedPreferences.getInstance() ;
}

void storeUserData(){
  UserModel userModel=UserModel(
    fnameController.text,lnameController.text,
    emailController.text,phoneController.text,licenceController.text,plateController.text,
    _carRegionVal,_carCodeVal,password.text
    );

    String userData=jsonEncode(userModel);
    print(userData);
    sharedPreferences.setString("register", userData);
}

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
          
        body: Container(
          margin: EdgeInsets.only(left: 15,right:15,top: 15),
          child: Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.always,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        
                        children: <Widget>[
                          // First name texForm field
                         _buildFname(),
                          SizedBox(height: 2),
                                
                          // Last name
                          _buildLname(),
                          SizedBox(height: 2),
    
                      
                          SizedBox(height: 2),
    
                          // Email field
                          _buildEmail(),
                          
                          Text(email_response,style: TextStyle(color: Colors.red,fontSize: 10),),
                          SizedBox(height: 2),
                                
                          // phone
                          _buildPhone(),
                          Text(phone_response,style: TextStyle(color: Colors.red,fontSize: 10),),
                          SizedBox(height: 2),
                         
                        _buildLicense(),
                           Text(license_response,style: TextStyle(color: Colors.red,fontSize: 10),),
                          SizedBox(height: 2),
    
                           _buildCarPlate(),
                          SizedBox(height: 2),
    
                         _carRegions(),
                          SizedBox(height: 2),
                          _carCodes(),
                            Text(plate_response,style: TextStyle(color: Colors.red,fontSize: 10),),
                          SizedBox(height: 2),
                          _buildPassword(),
                            Text(password_response,style: TextStyle(color: Colors.red,fontSize: 10),),
                          SizedBox(height: 2),
                          InkWell(
                            onTap: () async {
                                if (_formKey.currentState!.validate()) {
    

                            String licence=licenceController.text;
                            String email=emailController.text;
                            String phone=phoneController.text;
                            String carPlate=plateController.text;
                            storeUserData();
                            // 
    
                          var urls = url+"/check_register";
                          http.Response response = await http
                          .post(Uri.parse(urls), body: 
                          {"email": email,
                          "phone":phone,"license":licence,
                          "car_code":_carCodeVal.toString(),"car_region":_carRegionVal,"plate":carPlate});
                          
                          // Checking the response code
                          if (response.statusCode==200)
                          {
                            
                             Navigator.push(context,MaterialPageRoute(builder: (context)=>MyPhone()));

                          }
                          else{
                             var decode=jsonDecode(response.body);
                             setState((){
                              email_response=decode['email']!=null? decode['email']:"";
                              phone_response=decode['phone']!=null? decode['phone']:"";
                              plate_response=decode['car']!=null? decode['car']:"";
                              license_response=decode['car']!=null? decode['car']:"";
                              license_response=decode['licence']!=null? decode['licence']:"";
                             });
                                  
                          }
                               
                            }
                           
                           
                            },
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color:primaryColor),
                              child: Center(
                                  child: Text(
                                "Register",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              )),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                            
                              Text(
                                "",
                                style: TextStyle(fontSize: 3),
                              ),
                              TextButton(
                                  onPressed: () {
                                   Navigator.push(context,MaterialPageRoute(builder: (context)=>LoginPage()));
                                  },
                                  child: Text(
                                    "Sign in",
                                    style: TextStyle(
                                        color: Colors.indigo,
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold),
                                  ))
                            ],
                          )
                        ],
                      ),
                    )),
        ),
        ),
    )
;
  }


    Widget _buildFname() {
    return TextFormField(
                  keyboardType: TextInputType.text,
                  controller: fnameController,
                  decoration: InputDecoration(
                  labelText: "First name",
                    
                  ),
                  validator: (value) {
                    if (value!.isEmpty ) {
                      return "Enter first name";}
                 else if(!nameValidation.hasMatch(value)){
                  return "Not Name format";

                 }
                  }
                );
  }


Widget _buildLname() {
    return TextFormField(
                  keyboardType: TextInputType.text,
                  controller: lnameController,
                  decoration: InputDecoration(
                    labelText: "Last name",
                    
                  ),
                 
                   validator: (value) {
                    if (value!.isEmpty ) {
                      return "Enter first name";}
                 else if(!nameValidation.hasMatch(value)){
                  return "Not Name format";
                 }
                 });
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

Widget _buildPhone() {
    return TextFormField(
                  keyboardType: TextInputType.phone,
                  controller: phoneController,
                 
                  decoration: InputDecoration(
                      labelText: "Phone",
                      prefixIcon: Icon(Icons.phone),
                      ),
                  validator: (value) {
                    if (value!.isEmpty || !phoneValidation.hasMatch(phoneController.text.toString())) {
                      return "Enter valide phone Number";
                    }
                  },
                   
                );
}


Widget _buildLicense() {
    return TextFormField(
                  keyboardType: TextInputType.number,
                  controller: licenceController,
                  decoration: InputDecoration(
                    labelText: "Driving License number",
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter driving license number";
                    }
                    else if(!LicenseValidation.hasMatch(licenceController.text.toString())){
                      return "Not Valide License";
                    }
                    
                  },
                   
                );
}
Widget _buildCarPlate() {
    return TextFormField(
                  keyboardType: TextInputType.text,
                  controller: plateController,
                  decoration: InputDecoration(
                    labelText: "Car Plate",
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Plate Number required";
                    }
                     else if(!plateValidation1.hasMatch(plateController.text.toString())){
                      return "Not Valide plate";
                    }
                    
                  },
                   
                );
}

Widget _buildPassword() {
    return TextFormField(
                  keyboardType: TextInputType.text,
                  controller: password,
                  decoration: InputDecoration(
                    labelText: "Password",
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Password required";
                    }
                    if (!(value.isEmpty) && value.length < 6) {
                                  return "minimem password length required is 6";
                                }
                  },
                   
                );
}

Widget _carRegions()
{
return DropdownButtonFormField(
  icon: Icon(
    Icons.arrow_drop_down_circle,
    color: Colors.blue,
  ),
  value:_carRegionVal,
  items: _carRegion.map((e)=>DropdownMenuItem(child:Text(e),value: e,)).toList(),
   onChanged: (val){
    setState(()=>{
     _carRegionVal=val as String
    });
   },
   decoration: InputDecoration(
    labelText: "Car Region",
   ),
   );
}

Widget _carCodes()
{
return DropdownButtonFormField(
  icon: Icon(
    Icons.arrow_drop_down_circle,
    color: Colors.blue,
  ),
  value:_carCodeVal,
  items: _carCode.map((e)=>DropdownMenuItem(child:Text(e),value: e,)).toList(),
   onChanged: (val){
    setState(()=>{
     _carCodeVal=val as String
    });
   },
   decoration: InputDecoration(
    labelText: "Car Code",
   ),
   );
}


}
