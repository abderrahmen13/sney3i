import 'dart:async';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:snay3i/services/preferences.dart';
import 'package:snay3i/services/authentication.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  SplashScreenstate createState() => SplashScreenstate();
}

class SplashScreenstate extends State<SplashScreen> {
  GlobalKey<ScaffoldState> scaffoldKeyMain = GlobalKey();
  late Duration twenty;
  late Timer t2;
  FirebaseAuths userAuth = FirebaseAuths();

  @override
  void initState() {
    super.initState();
    twenty = const Duration(seconds: 5);
    preferences.setBoolValue("refresh-home", true);
    preferences.setStringValue('token', '');
    t2 = Timer(twenty, () async {
      var user = await userAuth.currentUserObject();
      bool keeplogin = await preferences.getBoolValue('keeplogin');
      var uid = await preferences.getStringValue('uid');
      bool language = await preferences.ifExist('language');
      if (!language) {
        if (kDebugMode) {
          print("0");
        }
        Navigator.pushReplacementNamed(context, '/language');
      } else if (user == null && uid == null) {
        //Pas de user existant
        if (kDebugMode) {
          print("1");
        }
        Navigator.pushReplacementNamed(context, '/login');
      } else if (user == null) {
        //Pas de user existant
        if (kDebugMode) {
          print("2");
        }
        Navigator.pushReplacementNamed(context, '/login');
      } else if (keeplogin == true && uid != null) {
        //User
        var userElastic = await userAuth.getCurrentUser();
        if (userElastic == null) {
          if (kDebugMode) {
            print("3");
          }
          Navigator.pushReplacementNamed(context, '/login');
        } else {
          if (kDebugMode) {
            print("5");
          }
          await preferences.setUser(userElastic);
          Navigator.pushReplacementNamed(context, '/home');
        }
      } else {
        if (kDebugMode) {
          print("6");
          print(user);
          print(keeplogin);
          print(uid);
        }
        Navigator.pushReplacementNamed(context, '/login');
      }
    });
  }

  @override
  void dispose() {
    //internetconnection!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return Scaffold(
      key: scaffoldKeyMain,
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/welcome.jpg"), 
              fit: BoxFit.cover),
        ),
      ),
    );
  }
}
