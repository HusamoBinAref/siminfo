import 'dart:convert';

import 'package:siminfo/Model/signin_model.dart';
import 'package:siminfo/network/endpoints.dart';
import 'package:siminfo/network/http_client.dart';

class SigninService {
  HttpClient _api = HttpClient();

  // SimService simService = SimService();
  Future<Map> login(LoginRequestModel value) async {
    //var sim = await simService.getSIM();
    value.sim = SettingConfig.sim;
    try {
      var response = await _api.postRequest(
          route: '${SettingConfig.login}', body: value.toJson());

      print(response);
      int statusCode = response.statusCode;

      var body = json.decode(response.body);
      // setMessage('${body['message']}');
      if (statusCode == 201 || statusCode == 200) {
        SettingConfig.userIDS = body['id'];
        return body;
      } else {}
    } catch (onError) {}
    return {};
  }
}
