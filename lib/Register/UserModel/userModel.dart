import "package:flutter/material.dart";
class UserModel {
  String? firstname;
  String? lastname;
 
  String? email;
  String? phone;
  String? licence;
  String? plate;
  String? car_region;
  String? car_code;
  String?password;
  
UserModel(
   this.firstname,
   this.lastname,
   this.email,
   this.phone,
   this.licence,
   this.plate,
   this.car_region,
   this.car_code,
    this.password,

);

UserModel.fromJson(Map<String,dynamic> json)
{
  firstname=json['firstname'];
  lastname=json['lastname'];
  password=json['password'];
  email=json['email'];
  phone=json['phone'];
  licence=json['license'];
  plate=json['plate'];
  car_region=json['car_region'];
  car_code=json['car_code'];
}

Map<dynamic,String>toJson()=>{
  "firstname":firstname.toString(),
  "lastname":lastname.toString(),
  "email":email.toString(),
  "phone":phone.toString(),
  "license":licence.toString(),
  "plate":plate.toString(),
  "car_region":car_region.toString(),
  "car_code":car_code.toString(),
  "password":password.toString()
};

}
