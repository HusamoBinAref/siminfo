import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:keyboard_visibility/keyboard_visibility.dart'
    show KeyboardVisibilityNotification;
import 'package:location/location.dart';
import 'package:siminfo/Model/search_model.dart';
import 'package:siminfo/Services/Search.dart';
import 'package:siminfo/Services/locationService.dart';
import 'package:vibration/vibration.dart';

import '../style.dart';
import 'login_screen.dart';
import 'sherdView/TextField.dart';

class FormView extends StatefulWidget {
  @override
  _FormViewState createState() => _FormViewState();
}

class _FormViewState extends State<FormView> {
  //PlateNumberModel _model = PlateNumberModel();
  bool isVisibilKey = false;
  Alignment childAlignment = Alignment.center;

  FocusNode char1Foucs = FocusNode();
  FocusNode char2Foucs = FocusNode();
  FocusNode char3Foucs = FocusNode();
  FocusNode numsFoucs = FocusNode();

  TextEditingController char1controller = TextEditingController();
  TextEditingController char2controller = TextEditingController();
  TextEditingController char3controller = TextEditingController();
  TextEditingController numscontroller = TextEditingController();
  TextEditingController notecontroller = TextEditingController();

  final arabics = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];

  var actionDone = TextInputAction.none;

  void initState() {
    super.initState();

    // var keyboardVisibilityController = KeyboardVisibilityController();
    // Query

    // Subscribe
    /* keyboardVisibilityController.onChange.listen((bool visible) {
      setState(() {
        isVisibilKey = visible;
        childAlignment = visible ? Alignment.topCenter : Alignment.bottomCenter;
      });
      print('Keyboard visibility update. Is visible: ${visible}');
    });*/

    KeyboardVisibilityNotification().addNewListener(
      onChange: (bool visible) {
        setState(() {
          isVisibilKey = visible;
          childAlignment =
              visible ? Alignment.topCenter : Alignment.bottomCenter;
        });

        print('keyboard $visible');
      },
    );
  }

  @override
  void dispose() {
    char1Foucs.dispose();
    char2Foucs.dispose();
    char3Foucs.dispose();
    numsFoucs.dispose();

    super.dispose();
  }

  void clearFields() {
    setState(() {
      //_model = PlateNumberModel();
      char1controller.clear();
      char2controller.clear();
      char3controller.clear();
      ;
      numscontroller.clear();
      //notecontroller.clear();
      numsFoucs.unfocus();
      FocusScope.of(context).requestFocus(char1Foucs);
    });
  }

  onFieldSubmSummit(String term) async {
    SearchService _searchService = SearchService();

    final LocationData? dataLocation = await LocationService.getLocation();
    print("lat: " +
        dataLocation!.latitude.toString() +
        "      log:" +
        dataLocation.longitude.toString());

    if (dataLocation != null) {
      String sumNum = char1controller.text +
          char2controller.text +
          char3controller.text +
          numscontroller.text;

      SearchRequestModel valueSend = SearchRequestModel(
          plateNumber: sumNum,
          date: "DateTime.now().toString()",
          lat: dataLocation.latitude,
          log: dataLocation.longitude,
          note: notecontroller.text);

      var respone = await _searchService.search(valueSend);
      print(respone);
      if (respone['status'] == true) {
        Vibration.vibrate(duration: 500000);
        showAlertDialog1(
            cancelActionText: 'Ok',
            content: respone["message"],
            context: context,
            defaultActionText: 'Okey',
            title: 'ALTER');
      } else {
        clearFields();
      }
    } else {
      Future.delayed(Duration(seconds: 3), () {
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (_) => LoginScreen()), (route) => false);
      });
    }
  }

  Future showAlertDialog1({
    required BuildContext context,
    required String title,
    required String content,
    required String cancelActionText,
    required String defaultActionText,
  }) async {
    if (!Platform.isIOS) {
      return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            if (cancelActionText != null)
              FlatButton(
                child: Text(cancelActionText),
                onPressed: () {
                  Vibration.cancel();
                  Navigator.of(context).pop(false);
                  clearFields();
                },
              ),
            /* FlatButton(
              child: Text(defaultActionText),
              onPressed: () => Navigator.of(context).pop(true),
            ),*/
          ],
        ),
      );
    }

    // todo : showDialog for ios
    return showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          if (cancelActionText != null)
            CupertinoDialogAction(
              child: Text(cancelActionText),
              onPressed: () => Navigator.of(context).pop(false),
            ),
          CupertinoDialogAction(
            child: Text(defaultActionText),
            onPressed: () => Navigator.of(context).pop(true),
          ),
        ],
      ),
    );
  }

  var kTextFieldDecorationCircular = InputDecoration(
    contentPadding: EdgeInsets.all(2.0),
    border: InputBorder.none,
    filled: true,
    fillColor: Colors.transparent,

    /*border: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.purpleAccent, width: 5.0),
      borderRadius: BorderRadius.all(
        Radius.circular(0.0),
      ),
    ),*/
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          bottom: !isVisibilKey ? 50 : 140, left: 70, right: 70),
      alignment: childAlignment,
      child: Form(
        child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: !isVisibilKey
                ? MainAxisAlignment.end
                : MainAxisAlignment.center,
            children: <Widget>[
              SingleChildScrollView(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            alignment: Alignment.center,
                            decoration: kBoxDecorationStyle1,
                            //  height: 100.0,
                            width: 50,
                            child: Column(children: [
                              Text(
                                'حرف${arabics[1]}',
                                style: kfiledStyle,
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Container(
                                child: Padding(
                                  padding: const EdgeInsets.all(0.0),
                                  child: Container(
                                    height: 35.0,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(0)),
                                        border: Border.all(
                                          color: Colors.purpleAccent,
                                        )),
                                    child: Material(
                                      elevation: 0.0,
                                      color: Colors.transparent,
                                      child: MyTextField.textFormWithNode(
                                        controller: char1controller,
                                        context: context,
                                        focusNode: char1Foucs,
                                        /* onSaved: (String? value) {
                                          _model.char1 = value;
                                        },*/
                                        autofocse: true,
                                        onChange: (String newVal) {
                                          if (newVal.length == 1) {
                                            //_model.char1 = newVal;
                                            char1Foucs.unfocus();
                                            FocusScope.of(context)
                                                .requestFocus(char2Foucs);
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ])),
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                            alignment: Alignment.center,
                            decoration: kBoxDecorationStyle1,
                            // height: 100.0,
                            width: 50,
                            child: Column(children: [
                              Text(
                                'حرف${arabics[2]}',
                                style: kfiledStyle,
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Container(
                                height: 35.0,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(0)),
                                    border: Border.all(
                                      color: Colors.purpleAccent,
                                    )),
                                child: Material(
                                  elevation: 0.0,
                                  color: Colors.transparent,
                                  child: MyTextField.textFormWithNode(
                                    controller: char2controller,
                                    context: context,
                                    focusNode: char2Foucs,
                                    /*onSaved: (String? value) {
                                      _model.char2 = value;
                                    },*/
                                    autofocse: false,
                                    onChange: (String newVal) {
                                      if (newVal.length == 1) {
                                        // _model.char2 = newVal;
                                        char2Foucs.unfocus();
                                        FocusScope.of(context)
                                            .requestFocus(char3Foucs);
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ])),
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                            alignment: Alignment.center,
                            decoration: kBoxDecorationStyle1,

                            /// height: 100.0,
                            width: 50,
                            child: Column(
                              children: [
                                Text(
                                  'حرف${arabics[3]}',
                                  style: kfiledStyle,
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  height: 35.0,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(0)),
                                      border: Border.all(
                                        color: Colors.purpleAccent,
                                      )),
                                  child: Material(
                                    elevation: 0.0,
                                    color: Colors.transparent,
                                    child: MyTextField.textFormWithNode(
                                      controller: char3controller,
                                      context: context,
                                      focusNode: char3Foucs,
                                      /* onSaved: (String? value) {
                                        _model.char3 = value;
                                      },*/
                                      onChange: (String newVal) {
                                        if (newVal.length == 1) {
                                          // _model.char3 = newVal;
                                          char3Foucs.unfocus();
                                          FocusScope.of(context)
                                              .requestFocus(numsFoucs);
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            )),
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                          alignment: Alignment.center,
                          decoration: kBoxDecorationStyle1,
                          // height: 100.0,
                          width: 100,
                          child: Column(children: [
                            Text(
                              'ارقام اللوحة',
                              style: kfiledStyle,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              color: Colors.transparent,
                              child: Container(
                                height: 35.0,
                                width: 100,
                                decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(0)),
                                    border: Border.all(
                                      color: Colors.purpleAccent,
                                    )),
                                child: Material(
                                  elevation: 0.0,
                                  color: Colors.transparent,
                                  child: TextField(
                                    autofocus: false,
                                    focusNode: numsFoucs,
                                    autocorrect: false,

                                    /* onSaved: (String? value) {
                                  _model.number = int.parse(value!);
                                },*/
                                    textAlign: TextAlign.center,
                                    onSubmitted: onFieldSubmSummit,
                                    controller: numscontroller,

                                    textInputAction:
                                        TextInputAction.done, // actionDone,

                                    keyboardType: TextInputType.number,
                                    // onFieldSubmitted: onFieldSubmSummit,
                                    decoration: kTextFieldDecorationCircular,
                                    onChanged: (newVal) {
                                      if (newVal.length == 4) {
                                        // _model.number = int.tryParse(newVal);
                                        /*  setState(() {
                                          actionDone = TextInputAction.done;
                                        });

                                        char3Foucs.unfocus();
                                        FocusScope.of(context)
                                            .requestFocus(numsFoucs);*/
                                      }
                                    },
                                  ),
                                ),
                              ),
                            )
                          ]),
                        ),
                      ]),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                      height: 35.0,
                      width: 250,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(0)),
                          border: Border.all(
                            color: Colors.purpleAccent,
                          )),
                      child: new TextField(
                        controller: notecontroller,
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'OpenSans',
                        ),
                        textAlign: TextAlign.center,
                        textInputAction: TextInputAction.none,
                        autocorrect: false,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                        /*onSaved: (String? value) {
        onSaved(value);
      },*/
                        onChanged: (String newVal) {
                          // onChange(newVal);
                        },
                      ))
                ],
              )), // Example
            ]),
      ),
    );
  }
}
