import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:siminfo/network/storageLocal.dart';
import 'package:siminfo/screens/sherdView/animationBottom.dart';

import 'farze_screen.dart';
import 'login_screen.dart';
import 'myrecorder_screen.dart';
import 'new_record_screen.dart';

class Home extends StatelessWidget {
  final Map<dynamic, dynamic> userPermission;
  Home(this.userPermission);

  Widget _buildNewRecordBtn(BuildContext context) {
    bool isNewregister = userPermission['isNewregister'];

    return isNewregister
        ? Container(
            //padding: EdgeInsets.symmetric(vertical: 50.0),
            width: double.infinity,
            // ignore: deprecated_member_use
            child: 
            
            RaisedButton(
              elevation: 5.0,
              onPressed: () {
                HapticFeedback.vibrate();
                routToNewRecord(context);
              },
              padding: EdgeInsets.all(15.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              color: Colors.blue,
              child: Text(
                'تسجيل جديد',
                style: TextStyle(
                  color: Colors.white,
                  //Color(0xFF527DAA),
                  letterSpacing: 1.5,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'OpenSans',
                ),
              ),
            ),
          )
        : Container();
  }

  Future<LocationData?> _getLocation() async {
    LocationData? currentLocation;
    try {
      currentLocation = await location.getLocation();
    } catch (e) {
      currentLocation = null;
    }
    return currentLocation;
  }

  Future<void> stateService1(BuildContext context) async {
    var loca = await _getLocation();
    if (loca != null) {
      dataLocation = loca;
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => NewRecordScreen2(
                  dataLocation: dataLocation,
                )),
      );
    } else {
      stateService1(context);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text(' الرجاء تفعيل خدمة الموقع '),
        duration: const Duration(seconds: 5),
        action: SnackBarAction(
          label: 'Enable',
          onPressed: () async {
            routToNewRecord(context);
          },
        ),
      ));
      var loca = await _getLocation();
    }
  }

  Future<void> routToNewRecord(BuildContext context) async {
    bool stateService = await location.serviceEnabled();

    if (stateService) {
      stateService1(context);
    } else {
      stateService1(context);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text(' الرجاء تفعيل خدمة الموقع '),
        duration: const Duration(seconds: 5),
        action: SnackBarAction(
          label: 'Enable',
          onPressed: () async {
            routToNewRecord(context);
          },
        ),
      ));
      var loca = await _getLocation();
    }
  }

  Widget _buildMyRecordBtn(BuildContext context) {
    bool isRegister = userPermission['isRegister'];
    return isRegister
        ? Container(
            // padding: EdgeInsets.symmetric(vertical: 50.0),
            width: double.infinity,
            child: RaisedButton(
              elevation: 5.0,
              onPressed: () async {
                HapticFeedback.vibrate();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => MyRecorderView()),
                );
              },
              padding: EdgeInsets.all(15.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              color: Colors.blue,
              child: Text(
                'عرض تسجيلاتي',
                style: TextStyle(
                  color: Colors.white,
                  //Color(0xFF527DAA),
                  letterSpacing: 1.5,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'OpenSans',
                ),
              ),
            ),
          )
        : Container();
  }

  Widget _buildFarzdBtn(BuildContext context) {
    bool isFarz = userPermission['isFarz'];

    return isFarz
        ? Container(
            // padding: EdgeInsets.symmetric(vertical: 50.0),
            width: double.infinity,
            child: RaisedButton(
              elevation: 5.0,
              onPressed: () {
                //MyCheckNewView
                HapticFeedback.vibrate();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => MyCheckNewView()),
                );
              },
              padding: EdgeInsets.all(15.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              color: Colors.blue,
              child: Text(
                'فرز تسجيلاتي',
                style: TextStyle(
                  color: Colors.white,
                  //Color(0xFF527DAA),
                  letterSpacing: 1.5,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'OpenSans',
                ),
              ),
            ),
          )
        : Container();
  }

  Widget _buildLogoutBtn(BuildContext context) {
    return Container(
      //  padding: EdgeInsets.symmetric(vertical: 50.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () {
          HapticFeedback.vibrate();
          LocalStorage.clearUser();
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => LoginScreen()),
              (route) => false);
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        color: Colors.blue,
        child: Text(
          ' تسجيل خروج ',
          style: TextStyle(
            color: Colors.white,
            //Color(0xFF527DAA),
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  var location = new Location();

  late LocationData dataLocation;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

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
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
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
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFFFFFFFF),
                      Color(0xFFFFFFFF),
                      Color(0xFFFFFFFF),
                      Color(0xFFFFFFFF),
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
                          height: 180,
                          width: 180,
                        ),
                      ),
                      new SizedBox(height: 30.0),
                      SizedBox(height: 4.0),
                      WidgetAnimator( _buildNewRecordBtn(context)),
                      SizedBox(height: 4.0),
                      WidgetAnimator(_buildMyRecordBtn(context)),
                      SizedBox(height: 4.0),
                      WidgetAnimator( _buildFarzdBtn(context)),
                      SizedBox(height: 4.0),
                      WidgetAnimator( _buildLogoutBtn(context))
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
}
//

///////
///
///
///
///
///
