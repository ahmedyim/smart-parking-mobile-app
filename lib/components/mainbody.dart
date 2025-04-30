import 'package:flutter/material.dart';
import 'package:parking/Services/remote_service.dart';
import 'package:parking/components/gridDashboard.dart';
import 'package:parking/provider/locale_provider.dart';
import 'package:provider/provider.dart';
import 'package:parking/l10n/ln01.dart';
import 'package:parking/constants/constants.dart';

import 'package:parking/models/UserModel/user.dart';

class MainBody extends StatefulWidget {
  final double width;

  const MainBody({super.key, required this.width});

  @override
  State<MainBody> createState() => _MainBodyState();
}

class _MainBodyState extends State<MainBody> {
  String dropdownvalue = 'አማርኛ';

  var items = ['አማርኛ', 'Eng'];

  User user = User(uid: "", firstname: "", lastname: "", email: "");

  int space = 0;

  getData() async {
    user = (await RemoteService().getMyInfo("free"))!;
    space = (await RemoteService().getFreeSpaceInfo("checkCamera"))!;
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LocaleProvider>(context);
    final locale = provider.locale ?? Locale('en');
    return Scaffold(
      body: FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
              child: Column(children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text("Hello",
                              // AppLocalizations.of(context)!.hello,
                              style: const TextStyle(
                                color: primaryColor,
                                fontSize: 32,
                                fontFamily: "Poppins",
                              ),
                            ),
                            Text(
                              "${user.firstname}",
                              style: const TextStyle(
                                color: fadeBlack,
                                fontSize: 32,
                                fontFamily: "Jost",
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    DropdownButtonHideUnderline(
                      child: DropdownButton(
                        value: locale,
                        // icon: Container(width: 12),
                        items: L10n.all.map(
                          (locale) {
                            final flag = L10n.getName(locale.languageCode);
                            return DropdownMenuItem(
                              child: Text(
                                flag,
                                style: const TextStyle(
                                    fontSize: 20,
                                    color: fadeBlack,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Poppins"),
                              ),
                              value: locale,
                              onTap: () {
                                final provider = Provider.of<LocaleProvider>(
                                    context,
                                    listen: false);

                                provider.setLocale(locale);
                              },
                            );
                          },
                        ).toList(),
                        onChanged: (_) {},
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      
                      "Good day",
                      style: const TextStyle(
                          color: fadeBlack,
                          fontSize: 20,
                          fontFamily: "Jost",
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                GridDashboard(),
                Container(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.2,
                    width: MediaQuery.of(context).size.height * 0.5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          image: AssetImage("assets/icons/Rectangle.png"),
                          fit: BoxFit.cover),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      height: 30,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Text(
                                        "r",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Dan Smart",
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: primaryColor,
                                              fontFamily: "Jost"),
                                        ),
                                        Text(
                                          "Dan Smart",
                                          style: TextStyle(
                                            color: primaryColor,
                                            fontFamily: "Poppins",
                                            fontSize: 10,
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    Container(
                                      height: 30,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Text(
                                        "r",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Dan Smart",
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: primaryColor,
                                              fontFamily: "Jost"),
                                        ),
                                        Text(
                                          "Dan Smart",
                                          style: TextStyle(
                                            color: primaryColor,
                                            fontFamily: "Poppins",
                                            fontSize: 10,
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ]),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.4,
                            width: MediaQuery.of(context).size.width * 0.4,
                            alignment: Alignment.center,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "2",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 32,
                                    fontWeight: FontWeight.w900,
                                    fontFamily: "Jost",
                                  ),
                                ),
                                Text(
                                  "free",
                                
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontFamily: "Jost",
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ]),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
