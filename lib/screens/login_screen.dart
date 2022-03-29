import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:siminfo/Model/signin_model.dart';
import 'package:siminfo/Services/SigninService.dart';
import 'package:siminfo/network/endpoints.dart';
import 'package:siminfo/network/storageLocal.dart';

import '../style.dart';
import 'Home.dart';
import 'sherdView/formErrorHelp.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  

  

  LoginRequestModel _userModel = LoginRequestModel();

  GlobalKey<FormState> _key = new GlobalKey();
  bool _validate = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  Widget _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        /*Text(
          'اسم المستخدم',
          style: kLabelStyle,
        ),*/
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 50.0,
          child: TextFormField(
            keyboardType: TextInputType.text,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            initialValue: '',
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 10.0),
              /*prefixIcon: Icon(
                Icons.person,
                color: Colors.black,
              ),*/
              hintText: ' اسم المستخدم',
              hintStyle: kHintTextStyle,
            ),
            validator: FormValidator().validateisEmptyLoginUser,
            onSaved: (String? value) {
              _userModel.username = value;
            },
          ),
        ),
      ],
    );
  }

  bool _obscureText = true;
  Widget _buildPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        /*Text(
          'كلمة السر',
          style: kLabelStyle,
        ),*/
        SizedBox(height: 20.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 50.0,
          child: TextFormField(
            //  obscureText: true,
            obscureText: _obscureText,
            obscuringCharacter: '▪',

            style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            initialValue: '',
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              /*  prefixIcon: Icon(
                Icons.lock,
                color: Colors.black,
              ),*/
              hintText: ' كلمة المرور',
              hintStyle: kHintTextStyle,
              // labelText: 'كلمة السر',
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
                child: Icon(
                  _obscureText ? Icons.visibility : Icons.visibility_off,
                  semanticLabel:
                      _obscureText ? 'show password' : 'hide password',
                ),
              ),
            ),
            validator: FormValidator().validateisEmptyLoginPass,
            onSaved: (String? value) {
              _userModel.password = value;
            },
          ),
        ),
      ],
    );
  }

  bool stausLoad = false;

  Widget _buildLoginBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 50.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () {
          //HapticFeedback.vibrate();
          print('ddd');
          setState(() {
            stausLoad = true;
          });
          _sendToServer();
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        color: Colors.blue,
        child: Text(
          'تسجيل الدخول',
          style: TextStyle(
            color: Colors.white,
            //Color(0xFF527DAA),
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.normal,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        //centerTitle: true,
        backgroundColor: Colors.white,
        title: Container(
          //  padding: EdgeInsets.symmetric(vertical: 20),
          //color: Colors.white70,
          child: Text(
            'كراش',
            textAlign: TextAlign.start,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
              fontSize: 25.0,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  //color: Colors.white70,
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFFFFFFFF),
                      Color(0xFFFFFFF9),
                      Colors.white70,
                      Colors.white60,
                    ],
                    stops: [0.1, 0.4, 0.7, 0.9],
                  ),
                ),
              ),
              Container(
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 0.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        //margin: EdgeInsets.only(top: 20),
                        child: Image.asset(
                          'assets/logos/logo.png',
                          height: 200,
                          width: 200,
                        ),
                      ),
                      new SizedBox(height: 30.0),
                      Text(
                        'تسجيل الدخول',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'OpenSans',
                          fontSize: 33.0,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      SizedBox(height: 4.0),
                      new Form(
                        key: _key,
                        autovalidate: _validate,
                        child: Column(
                          children: [
                            _buildEmailTF(),
                            SizedBox(
                              height: 1.0,
                            ),
                            _buildPasswordTF(),
                            SizedBox(
                              height: 10,
                            ),
                            stausLoad
                                ? CircularProgressIndicator.adaptive()
                                : _buildLoginBtn(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void showSnack(String? messag) {
    if (messag == null) {
      messag = "الرجاء الاتصال بالانترنت";
    }
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(messag),
      duration: const Duration(seconds: 10),
      action: SnackBarAction(
        label: 'ok',
        onPressed: () {},
      ),
    ));
  }

  _sendToServer() async {
    if (_key.currentState!.validate()) {
      // No any error in validation
      _key.currentState!.save();
      SigninService userService = SigninService();

      var respone = await userService.login(_userModel);
      print(respone);
      if (respone['status'] == true) {
        bool isLogin = respone['isLogin'];
        if (isLogin) {
          await LocalStorage.saveUser(
              idUser: respone['id'].toString(),
              sim: SettingConfig.sim,
              response: respone);

          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => Home(respone)),
              (route) => false);
        } else {
          showSnack("لا تملك صلاحية الدخول الرجاء التواصل مع المشرف");
          setState(() {
            stausLoad = false;
          });
        }
      } else {
        showSnack(respone["message"]);
        setState(() {
          stausLoad = false;
        });
      }
    } else {
      // validation error
      // setState(() {
      //_validate = true;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text(' الرجاء ادخال اسم المستخدم وكلمة السر'),
        duration: const Duration(seconds: 1),
        /*action: SnackBarAction(
          label: 'ACTION',
          onPressed: () {},
        ),*/
      ));
      setState(() {
        stausLoad = false;
      });

      // });
    }
  }
}

///
///
