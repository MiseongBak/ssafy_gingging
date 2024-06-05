import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:frontend/core/theme/constant/app_icons.dart';
import 'package:frontend/core/theme/theme_data.dart';
import 'package:frontend/models/achievement_model.dart';
import 'package:frontend/models/auth_model.dart';
import 'package:frontend/models/campaign_model.dart';
import 'package:frontend/models/history_model.dart';
import 'package:frontend/models/member_model.dart';
import 'package:frontend/models/pet_model.dart';
import 'package:frontend/models/plogging_model.dart';
import 'package:frontend/models/quest_model.dart';
import 'package:frontend/models/ranking_model.dart';
import 'package:frontend/models/rescue_model.dart';
import 'package:frontend/provider/plogging_provider.dart';
import 'package:frontend/router/routes.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'provider/main_provider.dart';
import 'provider/user_provider.dart';

void main() async {
  // dotenv 설정
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: "assets/config/.env");

  // 지도 초기화
  await _initialize();

  FlutterBluePlus.setLogLevel(LogLevel.verbose, color: true);
  initializeDateFormatting('ko_KR', null).then((value) {
    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => MainProvider()),
          ChangeNotifierProvider(create: (context) => UserProvider()),
          ChangeNotifierProvider(create: (context) => PloggingProvider()),
          ChangeNotifierProvider(
              create: (context) =>
                  AuthModel(Provider.of<UserProvider>(context, listen: false))),
          ChangeNotifierProvider(
              create: (context) =>
                  PetModel(Provider.of<UserProvider>(context, listen: false))),
          ChangeNotifierProvider(
              create: (context) => RescueModel(
                  Provider.of<UserProvider>(context, listen: false))),
          ChangeNotifierProvider(
              create: (context) => AchievementModel(
                  Provider.of<UserProvider>(context, listen: false))),
          ChangeNotifierProvider(
              create: (context) => QuestModel(
                  Provider.of<UserProvider>(context, listen: false))),
          ChangeNotifierProvider(
              create: (context) => RankingModel(
                  Provider.of<UserProvider>(context, listen: false))),
          ChangeNotifierProvider(
              create: (context) => CampaignModel(
                  Provider.of<UserProvider>(context, listen: false))),
          ChangeNotifierProvider(
              create: (context) => HistoryModel(
                  Provider.of<UserProvider>(context, listen: false))),
          ChangeNotifierProvider(
              create: (context) => MemberModel(
                  Provider.of<UserProvider>(context, listen: false))),
          ChangeNotifierProvider(
              create: (context) => PloggingModel(
                  Provider.of<UserProvider>(context, listen: false))),

          // ChangeNotifierProvider(create: (context) => AuthModel()),
        ],
        child: const MyApp(),
      ),
    );
  });
}

Future<void> _initialize() async {
  String naverMapId = dotenv.get('NAVER_MAP_ID');
  WidgetsFlutterBinding.ensureInitialized();
  print('네이버 맵 인증 시작');
  await NaverMapSdk.instance.initialize(
      clientId: naverMapId, // 클라이언트 ID 설정
      onAuthFailed: (e) => log("네이버맵 인증오류 : $e", name: "onAuthFailed"));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // 앱 시작 시 권한 받기
  Future<void> requestPermissions() async {
    await [
      Permission.location,
      Permission.bluetooth,
      Permission.bluetoothScan,
      Permission.bluetoothConnect,
    ].request();
  }

  @override
  void initState() {
    super.initState();
    requestPermissions();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    return MaterialApp(
      home: const MyHomePage(),
      builder: (context, child) {
        return Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover, image: AssetImage(AppIcons.background)),
          ), // 전체 배경
          child: child, // 앱의 나머지 부분
        );
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: globalRouter,
      // routeInformationParser: globalRouter.routeInformationParser,
      // routerDelegate: globalRouter.routerDelegate,
      theme: CustomThemeData.themeData,
    );
  }
}
