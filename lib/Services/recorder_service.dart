import 'dart:convert';

import 'package:siminfo/Model/farzeModel.dart';
import 'package:siminfo/Model/recorder_model.dart';
import 'package:siminfo/network/endpoints.dart';
import 'package:siminfo/network/http_client.dart';

import 'simService.dart';

class RecorderService {
  HttpClient _api = HttpClient();
  // SimService simService = SimService();

  Future<List<RecorderResponseModel>> getRecorder() async {
    RecorderRequestModel value = RecorderRequestModel();
    //var sim = await simService.getSIM();
    value.sim = SettingConfig.sim;
    value.userid = SettingConfig.userIDS;
    //try {

    var response = await _api.patchRequest(
        route: '${SettingConfig.myrecorder}', body: value.toJson());

    List<RecorderResponseModel>? data = [];
    print(response);
    int statusCode = response.statusCode;
    if (statusCode == 201 || statusCode == 200) {
      var body = json.decode(response.body) as List;
      for (int i = 0; i < body.length; i++) {
        var model = RecorderResponseModel.fromJson(body[i]);

        data.add(model);
      }
      return data;
    } else {}

    //} catch (onError) {}
    return [];
  }

  Future<List<Farze1Model>> getFarzy() async {
    RecorderRequestModel value = RecorderRequestModel();
    //var sim = await simService.getSIM();
    value.sim = SettingConfig.sim;
    value.userid = SettingConfig.userIDS;
    //try {

    var response = await _api.patchRequest(
        route: '${SettingConfig.myfarze}', body: value.toJson());

    List<Farze1Model>? data = [];
    print(response);
    int statusCode = response.statusCode;
    if (statusCode == 201 || statusCode == 200) {
      var body = json.decode(response.body) as List;
      for (int i = 0; i < body.length; i++) {
        var model = Farze1Model.fromJson(body[i]);

        data.add(model);
      }
      return data;
    } else {}

    //} catch (onError) {}
    return [];
  }
}



///
//////
///
///
///