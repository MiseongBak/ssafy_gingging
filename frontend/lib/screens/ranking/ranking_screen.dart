import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/core/theme/constant/app_icons.dart';
import 'package:frontend/models/ranking_model.dart';
import 'package:frontend/provider/user_provider.dart';
import 'package:frontend/screens/component/custom_back_button.dart';
import 'package:frontend/screens/component/topbar/top_bar.dart';
import 'package:frontend/screens/ranking/component/ranking_bar.dart';
import 'package:frontend/screens/ranking/component/ranking_lists.dart';
import 'package:frontend/screens/ranking/component/ranking_name_bar.dart';
import 'package:provider/provider.dart';

class RankingScreen extends StatefulWidget {
  const RankingScreen({super.key});

  @override
  State<RankingScreen> createState() => _RankingState();
}

class _RankingState extends State<RankingScreen> {
  late UserProvider userProvider;
  late String accessToken;

  @override
  void initState() {
    super.initState();
    userProvider = Provider.of<UserProvider>(context, listen: false);
    accessToken = userProvider.getAccessToken();
  }

  @override
  Widget build(BuildContext context) {
    final people = Provider.of<RankingModel>(context, listen: true).getPeople();
    late List rankings = [];

    if (people.length >= 3) {
      for (int i = 3; i < people.length; i++) {
        rankings.add(people[i]);
      }
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover, image: AssetImage(AppIcons.background)),
          ), // 전체 배경
          child: Stack(
            children: [
              Column(
                children: [
                  const TopBar(),
                  Container(
                    color: Colors.transparent,
                    width: MediaQuery.of(context).size.width * 0.85,
                    height: MediaQuery.of(context).size.width * 0.75,
                    child: Stack(
                      children: [
                        Positioned(
                          left: MediaQuery.of(context).size.width * 0.295,
                          child: Column(
                            children: [
                              RankingNameBar(
                                nickName: people[0]["nickname"],
                                profile: people[0]['profile_pet_id'],
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.02,
                              ),
                              RankingBar(
                                heightSize: 0.2,
                                exp: people[0]["exp"],
                              ),
                            ],
                          ),
                        ),
                        people.length >= 2
                            ? Positioned(
                                top: MediaQuery.of(context).size.height * 0.08,
                                left: MediaQuery.of(context).size.width * 0.005,
                                child: Column(
                                  children: [
                                    RankingNameBar(
                                      nickName: people.length >= 2
                                          ? people[1]["nickname"]
                                          : '',
                                      profile: people.length >= 2
                                          ? people[1]['profile_pet_id']
                                          : 0,
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.02,
                                    ),
                                    RankingBar(
                                      heightSize: 0.12,
                                      exp: people.length >= 2
                                          ? people[1]["exp"]
                                          : 0,
                                    ),
                                  ],
                                ),
                              )
                            : Container(),
                        people.length >= 3
                            ? Positioned(
                                right:
                                    MediaQuery.of(context).size.width * 0.005,
                                top: MediaQuery.of(context).size.height * 0.12,
                                child: Column(
                                  children: [
                                    RankingNameBar(
                                      nickName: people.length >= 3
                                          ? people[2]["nickname"]
                                          : '',
                                      profile: people.length >= 3
                                          ? people[2]['profile_pet_id']
                                          : 0,
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.02,
                                    ),
                                    RankingBar(
                                      heightSize: 0.08,
                                      exp: people.length >= 3
                                          ? people[2]["exp"]
                                          : 0,
                                    ),
                                  ],
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  ),
                  RankingLists(
                    people: rankings,
                  ),
                ],
              ),
              Positioned(
                left: MediaQuery.of(context).size.width * 0.03,
                bottom: MediaQuery.of(context).size.height * 0.02,
                child: const CustomBackButton(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
