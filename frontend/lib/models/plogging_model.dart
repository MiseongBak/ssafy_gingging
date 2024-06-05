import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frontend/provider/user_provider.dart';

import "package:http/http.dart" as http;

class PloggingModel with ChangeNotifier {
  final UserProvider userProvider;

  PloggingModel(this.userProvider);

  String address = dotenv.get('ADDRESS');

  late int ploggingId;

  Future<String> ploggingStart(String accessToken, int memberPetId) async {
    var url = Uri.https(address, "/api/v1/plogging/start/$memberPetId");
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer $accessToken"
    };
    print('ploggingStart request : $url, headers : $headers');
    final response = await http.post(url, headers: headers);
    print(
        'PloggingStart response : ${json.decode(utf8.decode(response.bodyBytes))}');
    if (response.statusCode == 200) {
      ploggingId = json.decode(utf8.decode(response.bodyBytes))["dataBody"];
      return "Success";
    } else {
      return "fail";
    }
  }

  int getPloggingId() {
    return ploggingId;
  }

  late Map<String, dynamic> classificationData;

  Future<String> classificationTrash(String accessToken, double latitude,
      double longitude, List<int> image) async {
    var url = Uri.https(address, "/api/v1/plogging/trash/$ploggingId");
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer $accessToken"
    };
    final body = jsonEncode(
        {'latitude': latitude, 'longitude': longitude, 'image': image});
    print(
        'classificationTrash request : $url, headers : $headers body : $body');
    final response = await http.post(url, headers: headers, body: body);
    print(
        'classificationTrash response : ${json.decode(utf8.decode(response.bodyBytes))}');
    print('classification ${response.statusCode}');
    if (response.statusCode == 200) {
      classificationData =
          json.decode(utf8.decode(response.bodyBytes))["dataBody"];
      return 'Success';
    } else {
      Fluttertoast.showToast(msg: '몬스터가 아니야!!');
      return 'fail';
    }
  }

  getClassificationData() {
    return classificationData;
  }

  late Map<String, dynamic> noDeviceData;

  Future<String> noDeviceTrash(
      String accessToken, double latitude, double longitude) async {
    var url = Uri.https(address, "/api/v1/plogging/trash/test/$ploggingId");
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer $accessToken"
    };
    final body = jsonEncode({'latitude': latitude, 'longitude': longitude});
    print('noDeviceTrash request : $url, headers : $headers body : $body');
    final response = await http.post(url, headers: headers, body: body);
    print(
        'noDeviceTrash response : ${json.decode(utf8.decode(response.bodyBytes))}');

    if (response.statusCode == 200) {
      noDeviceData = json.decode(utf8.decode(response.bodyBytes))["dataBody"];
      return 'Success';
    } else {
      return 'fail';
    }
  }

  getNoDeviceData() {
    return noDeviceData;
  }

  late Map<String, dynamic> finishData;

  Future<String> finishPlogging(
      String accessToken, List<Map<String, double>> path, int distance) async {
    var url = Uri.https(address, "/api/v1/plogging/finish/$ploggingId");
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer $accessToken"
    };
    final body = jsonEncode({'path': path, 'distance': distance});
    print('finishPlogging request : $url, headers : $headers body : $body');
    final response = await http.post(url, headers: headers, body: body);
    print(
        'finishPlogging response : ${json.decode(utf8.decode(response.bodyBytes))}');

    if (response.statusCode == 200) {
      finishData = json.decode(utf8.decode(response.bodyBytes))["dataBody"];
      return 'Success';
    } else {
      return 'Fail';
    }
  }

  getFinishData() {
    return finishData;
  }

  late Map<String, dynamic> trashLists;

  Future<String> trashList(
      String accessToken, double latitude, double longitude, int radius) async {
    var url = Uri.https(address, "/api/v1/plogging/trash/list");
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer $accessToken"
    };
    final body = jsonEncode(
        {'latitude': latitude, 'longitude': longitude, 'radius': radius});

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      trashLists = json.decode(utf8.decode(response.bodyBytes))["dataBody"];
      print('쓰레기 $trashLists');
      return "Success";
    } else {
      print('안됨');
      return "fail";
    }
  }

  Map<String, dynamic> getTrashLists() {
    return trashLists;
  }
}
