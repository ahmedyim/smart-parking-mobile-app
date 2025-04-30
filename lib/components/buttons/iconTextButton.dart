import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import "package:parking/constants/constants.dart";
import "package:shared_preferences/shared_preferences.dart";
class myTextIconButton extends StatelessWidget {
  final String title;
  final Color color;
  final Icon icon;
  final String onClick;

  myTextIconButton(this.title, this.color, this.onClick, this.icon);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
      SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
      String email=sharedPreferences.getString("email").toString();
        if(onClick=="/login"){
          http.Response response=await http.post(
                                    Uri.parse(url+"/api/user-logout"),
                                    body: {"email": email});
        }
        sharedPreferences.remove('email');
        sharedPreferences.remove('token');
        Navigator.pushNamed(context, onClick);
      },
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            icon,
            Text(
              title,
              style: TextStyle(fontSize: 20, fontFamily: "Jost", color: color),
            )
          ],
        ),
      ),
    );
  }
}
// TextButton.icon(
//       onPressed: () => {
//         Navigator.pushNamed(context, onClick),
//       },
//       label: Text(title),
//       icon: icon,
//       style: ElevatedButton.styleFrom(
//           foregroundColor: color,
//           elevation: 0,
//           textStyle: TextStyle(fontSize: 20, fontFamily: "Jost")),
//     )
