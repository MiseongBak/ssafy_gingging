import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frontend/provider/user_provider.dart';

import "package:http/http.dart" as http;

class HistoryModel with ChangeNotifier {

  final UserProvider userProvider;
  HistoryModel(this.userProvider);
  String address = dotenv.get('ADDRESS');

  List<dynamic> histories = [];

  Future<String> getHistory(String accessToken) async {
    var url = Uri.https(address, "/api/v1/history/list");
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer $accessToken"
    };

    final response = await http.get(url, headers: headers);
    // print('응답 ${json.decode(utf8.decode(response.bodyBytes))}');
    if (response.statusCode == 200) {
      histories = json.decode(utf8.decode(response.bodyBytes))["dataBody"];
      print('응답 $histories');
      return "Success";
    } else {
      return "fail";
    }
  }

  List<dynamic> getHistories() {
    return histories;
  }

  Map<String, dynamic> historyDetail = {};

  Future<String> getHistoryDetail(String accessToken, int ploggingId) async {
    var url = Uri.https(address, "/api/v1/history/detail/${ploggingId}");
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer $accessToken"
    };

    final response = await http.get(url, headers: headers);
    // print('응답 ${json.decode(utf8.decode(response.bodyBytes))}');
    if (response.statusCode == 200) {
      historyDetail = json.decode(utf8.decode(response.bodyBytes))["dataBody"];
      print('히스토리 디테일 $historyDetail');
      return "Success";
    } else {
      return "fail";
    }
  }

  Map<String, dynamic> getDetailHistory() {
    return historyDetail;
  }
}
