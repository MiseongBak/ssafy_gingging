import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend/provider/user_provider.dart';

import "package:http/http.dart" as http;

class RankingModel with ChangeNotifier {

  final UserProvider userProvider;
  RankingModel(this.userProvider);
  String address = dotenv.get('ADDRESS');

  List<dynamic> people = [];

  Future<String> getRanking(String accessToken) async {
    var url = Uri.https(address, "/api/v1/ranking");
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer $accessToken"
    };

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      people = json.decode(utf8.decode(response.bodyBytes))["dataBody"];
      print('응답 $people');
      return "Success";
    } else {
      return "fail";
    }
  }

  List getPeople() {
    return people;
  }
}
