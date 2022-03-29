import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'endpoints.dart';

class HttpClient {
  HttpClient._privateConstructor();

  static final HttpClient _instance = HttpClient._privateConstructor();

  factory HttpClient() {
    return _instance;
  }

  Future<Response> getRequest(String route) async {
    var url11 = Uri.https('${SettingConfig.WEB_URL}', 'api/$route');

    Map<String, String> headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      //"Authorization": "Bearer $token"
    };

    var result = await get(url11, headers: headers);

    return result;
    //await get(route, headers: headers);
  }

  Future<Response> postRequest(
      {required String route, required Map body}) async {
    Map<String, String> headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
    };

    var url = Uri.https('${SettingConfig.WEB_URL}', 'api/$route');
    Response response =
        await post(url, body: jsonEncode(body), headers: headers);

    return response;
  }

  Future<Response> postStringRequest(
      {required String route, required String body}) async {
    Map<String, String> headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
    };
    var url = Uri.https('${SettingConfig.WEB_URL}', 'api/$route');
    Response response =
        await post(url, body: jsonEncode(body), headers: headers);
    return response;
  }

  Future<Response> putRequest(
      {required String route, required Map body}) async {
    Map<String, String> headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
    };
    var url = Uri.https('${SettingConfig.WEB_URL}', 'api/$route');

    Response response =
        await put(url, body: jsonEncode(body), headers: headers);
    debugPrint(response.body);
    return response;
  }

  Future<Response> patchRequest(
      {required String route, required Map body}) async {
    Map<String, String> headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
    };
    var url = Uri.https('${SettingConfig.WEB_URL}', 'api/$route');
    Response response =
        await patch(url, body: jsonEncode(body), headers: headers);
    return response;
  }

  Future<Response> deleteRequest(String route) async {
    Map<String, String> headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      //"Authorization": "Bearer $token"
    };
    var url = Uri.https('${SettingConfig.WEB_URL}', 'api/$route');
    Response response = await delete(url, headers: headers);
    return response;
  }
}
