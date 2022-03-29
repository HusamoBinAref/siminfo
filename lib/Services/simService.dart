import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_number/mobile_number.dart';

class SimService {
  String _mobileNumber = '';
  List<SimCard> _simCard = <SimCard>[];

  Future<String> getSIM() async {
    MobileNumber.listenPhonePermission((isPermissionGranted) {
      if (isPermissionGranted) {
        _initMobileNumberState();
      } else {}
    });
    _mobileNumber = await _initMobileNumberState();
    return _mobileNumber;
  }

  Future<String> _initMobileNumberState() async {
    if (!await MobileNumber.hasPhonePermission) {
      await MobileNumber.requestPhonePermission;
      return "null";
    }
    String mobileNumber = '';
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      mobileNumber = (await MobileNumber.mobileNumber)!;
      _simCard = (await MobileNumber.getSimCards)!;
      if (_simCard.length > 0) {
        return _simCard[0].number!;
      }
    } on PlatformException catch (e) {
      debugPrint("Failed to get mobile number because of '${e.message}'");
    }

    return mobileNumber;
  }

  /*Widget _fillCards() {
    List<Widget> widgets = _simCard
        .map((SimCard sim) => Text(
            'Sim Card Number: (${sim.countryPhonePrefix}) - ${sim.number}\nCarrier Name: ${sim.carrierName}\nCountry Iso: ${sim.countryIso}\nDisplay Name: ${sim.displayName}\nSim Slot Index: ${sim.slotIndex}\n\n'))
        .toList();
    return Column(children: widgets);
  }*/
}
