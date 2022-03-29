import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
static  Future saveUser({
    required String idUser,
    required String sim,
   required Map<dynamic, dynamic>  response

  }) async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    sharedPreferences.setString('idUser', idUser);
    sharedPreferences.setString('sim', idUser);

    String per=json.encode(response);

     sharedPreferences.setString('userPermission', per);


  }

 static Future clearUser() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    sharedPreferences.clear();
  }

 static Future<String?> getidUser() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    String? idu =  sharedPreferences.getString('idUser');
    return idu;
  }

  static Future<String?> getsim() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    String? idu =  sharedPreferences.getString('sim');
    return idu;
  }

  static Future< Map<dynamic, dynamic>?> getPermission() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    String str =  sharedPreferences.getString('userPermission').toString();

    var ddd = json.decode(str);

    return ddd;
  }
}
