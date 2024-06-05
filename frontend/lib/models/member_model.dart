import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frontend/provider/user_provider.dart';

import "package:http/http.dart" as http;

class MemberModel with ChangeNotifier {

  final UserProvider userProvider;
  MemberModel(this.userProvider);
  String address = dotenv.get('ADDRESS');

  Map<String, dynamic> member = {};

  Future<String> getMemberInfo(String accessToken) async {
    var url = Uri.https(address, "/api/v1/member/info");
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer $accessToken"
    };

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      member = json.decode(utf8.decode(response.bodyBytes))["dataBody"];
      print('응답 $member');
      return "Success";
    } else {
      return "fail";
    }
  }

  Map<String, dynamic> getMember() {
    return member;
  }

  Future<String> updateProfileImage(String accessToken, int profilePetId) async {
    print('프로필 $profilePetId');
    var url = Uri.https(address, "/api/v1/member/updateprofile/$profilePetId");
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer $accessToken"
    };

    final response = await http.post(url, headers: headers);

    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg: '변경이 완료되었습니다!');
      userProvider.setProfileImage(profilePetId);
      return "Success";
    } else {
      Fluttertoast.showToast(msg: '변경 실패하였습니다!');
      return "fail";
    }
  }

  Future<String> finishTutorial(String accessToken) async {
    var url = Uri.https(address, "/api/v1/member/tutorial");
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer $accessToken"
    };

    final response = await http.post(url, headers: headers);

    if (response.statusCode == 200) {
      print("성공");
      return "Success";
    } else {
      return "fail";
    }
  }
}
