import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend/provider/user_provider.dart';

import "package:http/http.dart" as http;

class QuestModel with ChangeNotifier {

  final UserProvider userProvider;
  QuestModel(this.userProvider);
  String address = dotenv.get('ADDRESS');

  List<dynamic> quests = [];

  Future<String> getQuests(String accessToken) async {
    var url = Uri.https(address, "/api/v1/quest/list");
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer $accessToken"
    };

    final response = await http.get(url, headers: headers);
    // print(json.decode(utf8.decode(response.bodyBytes))["dataHeader"]);
    if (response.statusCode == 200) {
      quests = json.decode(utf8.decode(response.bodyBytes))["dataBody"];
      print(quests);
      notifyListeners();
      return "Success";
    } else {
      return "fail";
    }
  }

  late int gging;

  Future<String> completeQuest(String accessToken, int memberQuestId) async {
    var url = Uri.https(address, "/api/v1/quest/$memberQuestId");
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer $accessToken"
    };

    final response = await http.post(url, headers: headers);
    print(json.decode(utf8.decode(response.bodyBytes))["dataBody"]);

    int currency = userProvider.getCurrency();
    if (response.statusCode == 200) {
      gging = json.decode(utf8.decode(response.bodyBytes))["dataBody"];
      userProvider.setCurrency(currency + gging);
      return "Success";
    } else {
      return "fail";
    }
  }

  List getQuest () {
    return quests;
  }

  int getGging () {
    return gging;
  }

}