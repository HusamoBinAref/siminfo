import 'dart:convert';

import 'package:siminfo/Model/search_model.dart';
import 'package:siminfo/network/endpoints.dart';
import 'package:siminfo/network/http_client.dart';

import 'simService.dart';

class SearchService {
  HttpClient _api = HttpClient();
 // SimService simService = SimService();

  Future<Map> search(SearchRequestModel value) async {
   // value.sim = await simService.getSIM();
   value.sim = SettingConfig.sim;
    value.userid = SettingConfig.userIDS;
    try {

    var response = await _api.putRequest(
        route: '${SettingConfig.sreach}', body: value.toJson());

    print(response);
    int statusCode = response.statusCode;

    var body = json.decode(response.body);
    // setMessage('${body['message']}');
    if (statusCode == 201 || statusCode == 200) {
      return body;
    } else {}
    } catch (onError) {}
    return {};
  }
}

////
///////
///
//////////////
///
///
///
//////////////
///
///
///
///
///
///
///
///