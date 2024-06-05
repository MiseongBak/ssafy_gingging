import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frontend/provider/user_provider.dart';
import "package:http/http.dart" as http;
import 'package:provider/provider.dart';

enum AuthStatus {
  registerSuccess,
  registerFail,
  loginSuccess,
  loginFail,
  logoutSuccess,
  logoutFail,
  signOutSuccess,
  signOutFail,
  inputError,
}

class AuthModel with ChangeNotifier {
  final UserProvider userProvider;

  AuthModel(this.userProvider);

  String address = dotenv.get('ADDRESS');

  Future<AuthStatus> signUp(
      String email, String password, String nickName) async {
    var url = Uri.https(address, "/api/v1/member/signup");
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode(
        {"email": email, "password": password, "nickname": nickName});

    final response = await http.post(url, headers: headers, body: body);
    print(json.decode(utf8.decode(response.bodyBytes))['dataHeader']);
    // print('응답 ${response.body}');

    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg: '회원가입이 완료되었습니다.');
      login(email, password);
      return AuthStatus.loginSuccess;
    } else {
      Fluttertoast.showToast(msg: '회원가입에 실패하였습니다.');
      return AuthStatus.loginFail;
    }
  }

  Future<AuthStatus> login(String email, String password) async {
    final storage = FlutterSecureStorage();
    var url = Uri.https(address, "/api/v1/member/signin");
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({"email": email, "password": password});

    final response = await http.post(url, headers: headers, body: body);
    print('응답 ${response.body}');

    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg: '로그인이 완료되었습니다.');

      String accessToken =
          json.decode(utf8.decode(response.bodyBytes))['jwtAccess'];
      String refreshToken =
          json.decode(utf8.decode(response.bodyBytes))['jwtRefresh'];
      String nickName =
          json.decode(utf8.decode(response.bodyBytes))['responseUserInfoData']
              ['nickname'];
      int userId =
          json.decode(utf8.decode(response.bodyBytes))['responseUserInfoData']
              ['id'];
      int profile =
          json.decode(utf8.decode(response.bodyBytes))['responseUserInfoData']
              ['profilePetId'];
      int level =
          json.decode(utf8.decode(response.bodyBytes))['responseUserInfoData']
              ['level'];
      int currency =
          json.decode(utf8.decode(response.bodyBytes))['responseUserInfoData']
              ['currency'];
      bool memberTutorial =
          json.decode(utf8.decode(response.bodyBytes))['responseUserInfoData']
              ['tutorial'];

      storage.write(key: 'token', value: accessToken);
      storage.write(key: 'email', value: email);
      storage.write(key: 'password', value: password);

      userProvider.setEmail(email);
      userProvider.setAccessToken(accessToken);
      userProvider.setRefreshToken(refreshToken);
      userProvider.setNickName(nickName);
      userProvider.setUserId(userId);
      userProvider.setProfileImage(profile);
      userProvider.setLevel(level);
      userProvider.setCurrency(currency);
      userProvider.setMemberTutorial(memberTutorial);
      userProvider.setTutorial(memberTutorial);

      notifyListeners();
      return AuthStatus.loginSuccess;
    } else {
      Fluttertoast.showToast(msg: '로그인에 실패하였습니다.');
      return AuthStatus.loginFail;
    }
  }
}
