import 'package:parking/Login/login.dart';
import 'package:parking/components/bookStatus.dart';
import 'package:parking/components/myAccount.dart';
import 'package:parking/map.dart';
import 'package:parking/pickBookPage.dart';
import 'package:parking/profile.dart';
import 'package:flutter/material.dart';
import 'l10n/ln01.dart';



import 'provider/locale_provider.dart';
import 'package:provider/provider.dart';
import 'package:parking/components/hompage.dart';
import 'package:parking/history.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => LocaleProvider(),
        builder: (context, child) {
          final provider = Provider.of<LocaleProvider>(context);

          return MaterialApp(
            debugShowCheckedModeBanner: false,
            locale: provider.locale,
            supportedLocales: L10n.all,
            localizationsDelegates: [
          
              
             
            ],
            home: const MyHomePage(),
            routes: {
              
             
              "/book": (context) => PickBookPage(),
              "/hist": (context) => ParkHistory(),
              "/account": (context) => MyAccount(),
              "/login": (context) => LoginPage(),
              "/map": (context) => MapScreen(),
              "/pickbook": (context) => PickBookPage(),
              "/bookstatus": (context) => MyBookStatus(),
            },
          );
        },
      );
}
