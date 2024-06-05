import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frontend/provider/user_provider.dart';

import "package:http/http.dart" as http;

class RescueModel with ChangeNotifier {
  final UserProvider userProvider;

  RescueModel(this.userProvider);

  String address = dotenv.get('ADDRESS');

  late bool isBox;

  Future<String> rescuePet(
      String accessToken, int currency, Function(String) onResult) async {
    var url = Uri.https(address, "/api/v1/pet/rescue");
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer $accessToken"
    };

    final response = await http.post(url, headers: headers);
    var checkMessage = json
        .decode(utf8.decode(response.bodyBytes))["dataHeader"]["resultMessage"];
    print('체크 $checkMessage');

    if (response.statusCode == 200) {
      onResult("Success");
      var check = json.decode(utf8.decode(response.bodyBytes))["dataBody"];
      print('응답 $check');
      if (check) {
        isBox = true;
      } else {
        isBox = false;
      }
      userProvider.setCurrency(currency - 1000);
      notifyListeners();
      return "Success";
    } else {
      if (checkMessage == "보유 통화 부족") {
        Fluttertoast.showToast(msg: '낑이 부족합니다!');
      } else if (checkMessage == "이미 모든 펫을 보유하고 있습니다") {
        Fluttertoast.showToast(msg: '이미 모든 펫을 보유하고 있습니다!');
      }
      onResult("fail");
      return "fail";
    }
  }

  bool getIsBox() {
    return isBox;
  }
}
