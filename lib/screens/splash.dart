import 'dart:async';
import 'package:flutter/material.dart';
import 'package:siminfo/network/endpoints.dart';
import 'package:siminfo/network/storageLocal.dart';

import 'Home.dart';
import 'login_screen.dart';


class SplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
    {
 
 getuser() async {
    var respone = await LocalStorage.getPermission();

    if (respone != null) {
      SettingConfig.userIDS = respone['id'];
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (_) => Home(respone)), (route) => false);
    }
    else
    {
       Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (_) => LoginScreen() ), (route) => false);
    }
  }
  
 

  @override
  void initState() {
    super.initState();

   getuser();
   
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // backgroundColor: Colors.white,
      body: Center(child: new Image.asset(
                'assets/logos/ch.png',
               // width: animation.value * 250,
               // height: animation.value * 250,
              ),)
    );
  }
}
