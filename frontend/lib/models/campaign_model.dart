import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend/provider/user_provider.dart';

import "package:http/http.dart" as http;

class CampaignModel with ChangeNotifier {

  final UserProvider userProvider;
  CampaignModel(this.userProvider);
  String address = dotenv.get('ADDRESS');

  List<dynamic> campaigns = [];

  Future<String> getCampaigns(String accessToken) async {
    var url = Uri.https(address, "/api/v1/notice/list");
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer $accessToken"
    };

    final response = await http.get(url, headers: headers);
    // print('응답 ${json.decode(utf8.decode(response.bodyBytes))}');
    if (response.statusCode == 200) {
      campaigns = json.decode(utf8.decode(response.bodyBytes))["dataBody"];
      print('응답 $campaigns');
      return "Success";
    } else {
      return "fail";
    }
  }

  List getCampaign() {
    return campaigns;
  }
}
