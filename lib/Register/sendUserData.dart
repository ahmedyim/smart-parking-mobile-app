
import 'package:http/http.dart' as http;
 var urls = "http://192.168.43.161:5000/registerU";

sendUserData(String fname, String lname,String gender,String email,String phone,String license,String carPlate,String carRegion,String carCode) async {
  http.Response response = await http
      .post(Uri.parse(urls), body: 
      {"firstname":fname,"lastname":lname,"gender":gender,"email": email,
      "phone":phone,"license":license,
      "car_code":carCode,"car_Region":carRegion,"plate":carPlate});
  return (response.body);
}
