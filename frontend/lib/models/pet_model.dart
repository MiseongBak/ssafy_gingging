import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend/provider/user_provider.dart';

import "package:http/http.dart" as http;

class PetModel with ChangeNotifier {
  final UserProvider userProvider;

  PetModel(this.userProvider);

  String address = dotenv.get('ADDRESS');

  List<dynamic> pets = [];

  Future<String> getPets(String accessToken) async {
    var url = Uri.https(address, "/api/v1/pet/my/list");
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer $accessToken"
    };

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      pets = json.decode(utf8.decode(response.bodyBytes))["dataBody"];
      print(pets);
      return "Success";
    } else {
      return "fail";
    }
  }

  List getPet() {
    return pets;
  }

  Map<String, dynamic> pet = {};

  Future<String> getPetDetail(String accessToken, int memberPetId) async {
    var url = Uri.https(address, "/api/v1/pet/$memberPetId");
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer $accessToken"
    };

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      pet = json.decode(utf8.decode(response.bodyBytes))["dataBody"];
      print('펫 $pet');
      notifyListeners();
      return "Success";
    } else {
      return "fail";
    }
  }

  Map<String, dynamic> getCurrentPet() {
    return pet;
  }

  List<dynamic> allPets = [];

  Future<String> getAllPets(String accessToken) async {
    var url = Uri.https(address, "/api/v1/pet/list");
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer $accessToken"
    };

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      allPets = json.decode(utf8.decode(response.bodyBytes))["dataBody"];
      print('올펫 $allPets');
      return "Success";
    } else {
      return "fail";
    }
  }

  List getAllPet() {
    return allPets;
  }

  Future<String> openBox(String accessToken, int memberPetId) async {
    print('멤버펫아이디 $memberPetId');
    var url = Uri.https(address, "/api/v1/pet/active/$memberPetId");
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer $accessToken"
    };

    final response = await http.post(url, headers: headers);

    if (response.statusCode == 200) {
      print('성공');
      return "Success";
    } else {
      print('실패');
      return "fail";
    }
  }

  Future<String> updateNickName(
      String accessToken, int memberPetId, String nickName) async {
    var url = Uri.https(address, "/api/v1/pet/update/nickname/$memberPetId");
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer $accessToken"
    };
    final body = jsonEncode({"nickname": nickName});

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      print('닉네임 $nickName');
      return "Success";
    } else {
      return "fail";
    }
  }
}
