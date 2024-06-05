import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frontend/core/theme/constant/app_colors.dart';
import 'package:frontend/core/theme/constant/app_icons.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';
import 'package:frontend/models/campaign_model.dart';
import 'package:frontend/models/history_model.dart';
import 'package:frontend/models/pet_model.dart';
import 'package:frontend/models/quest_model.dart';
import 'package:frontend/models/ranking_model.dart';
import 'package:frontend/provider/main_provider.dart';
import 'package:frontend/provider/user_provider.dart';
import 'package:frontend/screens/component/clearmonster/clear_monster.dart';
import 'package:frontend/screens/component/menu.dart';
import 'package:frontend/screens/component/topbar/top_bar.dart';
import 'package:frontend/screens/main/component/evolution_bar.dart';
import 'package:frontend/screens/main/component/exp_bar.dart';
import 'package:frontend/screens/main/component/nickname_bar.dart';
import 'package:frontend/screens/main/dialog/weekly_quest_dialog.dart';
import 'package:frontend/screens/main/openbox/open_box_dialog.dart';
import 'package:frontend/screens/main/partner/partner.dart';
import 'package:frontend/screens/tutorial/box_open_tutorial_dialog.dart';
import 'package:frontend/screens/tutorial/go_plogging_tutorial_dialog.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  AnimationController? _animationController_evolution_button;
  Animation<double>? _rotateAnimation_evolution_button;
  late MainProvider mainProvider;
  late UserProvider userProvider;
  late String accessToken;
  late PetModel petModel;
  late Map currentPet;
  late bool tutorial;
  late bool memberTutorial;
  late bool isTutorialPloggingFinish;
  bool _isButtonDisabled = false;
  bool isDataLoading = false;

  @override
  void initState() {
    super.initState();
    mainProvider = Provider.of<MainProvider>(context, listen: false);
    userProvider = Provider.of<UserProvider>(context, listen: false);
    accessToken = userProvider.getAccessToken();
    tutorial = userProvider.getTutorial();
    memberTutorial = userProvider.getMemberTutorial();
    isTutorialPloggingFinish = mainProvider.getIsTutorialPloggingFinish();
    getData();

    _animationController_evolution_button = AnimationController(
        duration: const Duration(milliseconds: 800), vsync: this);
    _rotateAnimation_evolution_button = Tween<double>(begin: -0.1, end: 0.1)
        .animate(_animationController_evolution_button!);

    _animationController_evolution_button!.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController_evolution_button!.dispose();
    super.dispose();
  }

  getData() async {
    petModel = Provider.of<PetModel>(context, listen: false);
    petModel.getAllPets(accessToken);
    await petModel.getPetDetail(accessToken, -1).then(
          (value) => setState(() {
            isDataLoading = true;
          }),
        );
    currentPet = petModel.getCurrentPet();

    // 튜토리얼 판별
    if (memberTutorial == false && isTutorialPloggingFinish == false) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return const GoPloggingTutorialDialog();
          },
        ).then(
          (value) {
            setState(() {});
            context.go('/ploggingReady');
          },
        );
      });
    }

    // 플로깅 끝내고 main 왔는지
    if (memberTutorial == false && isTutorialPloggingFinish) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return const BoxOpenTutorialDialog();
            }).then((value) {
          petModel.openBox(accessToken, -1);
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return OpenBoxDialog(
                image: currentPet['image'],
              );
            },
          ).then(
            (value) {
              setState(() {});
            },
          );
        });
      });
    }
  }

  void selectedMenu(String selected) {
    mainProvider.menuSelected(selected);
  }

  bool _isQuestPressed = false;
  bool _isRankingPressed = false;
  bool _isHistoryPressed = false;
  bool _isCampaignPressed = false;
  bool _isReadyPressed = false;

  void _onQuestTapDown(TapDownDetails details) {
    setState(() {
      _isQuestPressed = true;
    });
  }

  void _onQuestTapUp(TapUpDetails details) {
    setState(() {
      _isQuestPressed = false;
    });
  }

  void _onQuestTapCancel() {
    setState(() {
      _isQuestPressed = false;
    });
  }

  void _onRankingTapDown(TapDownDetails details) {
    setState(() {
      _isRankingPressed = true;
    });
  }

  void _onRankingTapUp(TapUpDetails details) {
    setState(() {
      _isRankingPressed = false;
    });
  }

  void _onRankingTapCancel() {
    setState(() {
      _isRankingPressed = false;
    });
  }

  void _onHistoryTapDown(TapDownDetails details) {
    setState(() {
      _isHistoryPressed = true;
    });
  }

  void _onHistoryTapUp(TapUpDetails details) {
    setState(() {
      _isHistoryPressed = false;
    });
  }

  void _onHistoryTapCancel() {
    setState(() {
      _isHistoryPressed = false;
    });
  }

  void _onCampaignTapDown(TapDownDetails details) {
    setState(() {
      _isCampaignPressed = true;
    });
  }

  void _onCampaignTapUp(TapUpDetails details) {
    setState(() {
      _isCampaignPressed = false;
    });
  }

  void _onCampaignTapCancel() {
    setState(() {
      _isCampaignPressed = false;
    });
  }

  void _onReadyTapDown(TapDownDetails details) {
    setState(() {
      _isReadyPressed = true;
    });
  }

  void _onReadyTapUp(TapUpDetails details) {
    setState(() {
      _isReadyPressed = false;
    });
  }

  void _onReadyTapCancel() {
    setState(() {
      _isReadyPressed = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final pet = Provider.of<PetModel>(context, listen: true).getCurrentPet();
    final currentTutorial =
        Provider.of<UserProvider>(context, listen: true).getTutorial();
    final tutorial =
        Provider.of<UserProvider>(context, listen: true).getMemberTutorial();

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover, image: AssetImage(AppIcons.background)),
          ),
          child: isDataLoading
              ? Column(
                  children: [
                    const TopBar(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            if (!_isButtonDisabled) {
                              setState(() {
                                _isButtonDisabled = true; // 버튼 비활성화
                              });
                              final quests = Provider.of<QuestModel>(context,
                                  listen: false);
                              await quests.getQuests(accessToken);
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return const WeeklyQuestDialog();
                                },
                              ).then(
                                (value) => setState(() {
                                  _isButtonDisabled = false;
                                }),
                              );
                            }
                          },
                          onTapDown: _onQuestTapDown,
                          onTapUp: _onQuestTapUp,
                          onTapCancel: _onQuestTapCancel,
                          child: Menu(
                            color: AppColors.basicpink,
                            shadowColor: AppColors.basicShadowPink,
                            icon: Icon(
                              FontAwesomeIcons.calendarCheck,
                              color: Colors.white,
                              size: MediaQuery.of(context).size.width * 0.07,
                            ),
                            content: '주간 퀘스트',
                            isPressed: _isQuestPressed,
                          ),
                        ),
                        // SizedBox(
                        //   width: MediaQuery.of(context).size.width * 0.04,
                        // ),
                        GestureDetector(
                          onTap: () async {
                            if (!_isButtonDisabled) {
                              setState(() {
                                _isButtonDisabled = true; // 버튼 비활성화
                              });
                              final ranking = Provider.of<RankingModel>(context,
                                  listen: false);
                              await ranking.getRanking(accessToken);
                              context.push('/ranking').then((value) {
                                // 페이지 이동이 완료되면 버튼을 다시 활성화합니다.
                                setState(() {
                                  _isButtonDisabled = false;
                                });
                              });
                              selectedMenu('ranking');
                            }
                          },
                          onTapDown: _onRankingTapDown,
                          onTapUp: _onRankingTapUp,
                          onTapCancel: _onRankingTapCancel,
                          child: Menu(
                            color: AppColors.basicgray,
                            shadowColor: AppColors.basicShadowGray,
                            icon: Icon(
                              FontAwesomeIcons.trophy,
                              color: Colors.white,
                              size: MediaQuery.of(context).size.width * 0.07,
                            ),
                            content: '랭킹',
                            isPressed: _isRankingPressed,
                          ),
                        ),
                        // SizedBox(
                        //   width: MediaQuery.of(context).size.width * 0.04,
                        // ),
                        GestureDetector(
                          onTap: () async {
                            if (!_isButtonDisabled) {
                              setState(() {
                                _isButtonDisabled = true; // 버튼 비활성화
                              });
                              final history = Provider.of<HistoryModel>(context,
                                  listen: false);
                              await history.getHistory(accessToken);
                              context.push('/history').then((value) {
                                // 페이지 이동이 완료되면 버튼을 다시 활성화합니다.
                                setState(() {
                                  _isButtonDisabled = false;
                                });
                              });
                              selectedMenu('history');
                            }
                          },
                          onTapDown: _onHistoryTapDown,
                          onTapUp: _onHistoryTapUp,
                          onTapCancel: _onHistoryTapCancel,
                          child: Menu(
                            color: AppColors.basicgreen,
                            shadowColor: AppColors.basicShadowGreen,
                            icon: Icon(
                              FontAwesomeIcons.clipboardList,
                              color: Colors.white,
                              size: MediaQuery.of(context).size.width * 0.07,
                            ),
                            content: '히스토리',
                            isPressed: _isHistoryPressed,
                          ),
                        ),
                        // SizedBox(
                        //   width: MediaQuery.of(context).size.width * 0.04,
                        // ),
                        GestureDetector(
                          onTap: () async {
                            if (!_isButtonDisabled) {
                              setState(() {
                                _isButtonDisabled = true; // 버튼 비활성화
                              });
                              final campaign = Provider.of<CampaignModel>(
                                  context,
                                  listen: false);
                              await campaign.getCampaigns(accessToken);
                              context.push('/campaign').then((value) {
                                // 페이지 이동이 완료되면 버튼을 다시 활성화합니다.
                                setState(() {
                                  _isButtonDisabled = false;
                                });
                              });
                              selectedMenu('campaign');
                            }
                          },
                          onTapDown: _onCampaignTapDown,
                          onTapUp: _onCampaignTapUp,
                          onTapCancel: _onCampaignTapCancel,
                          child: Menu(
                            color: AppColors.basicnavy,
                            shadowColor: AppColors.basicShadowNavy,
                            icon: Icon(
                              FontAwesomeIcons.users,
                              color: Colors.white,
                              size: MediaQuery.of(context).size.width * 0.07,
                            ),
                            content: '캠페인',
                            isPressed: _isCampaignPressed,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    tutorial == true
                        ? Partner(
                            image: pet['active']
                                ? Image.network(
                                    pet['image'],
                                  )
                                : Image.asset(
                                    AppIcons.intro_box,
                                  ),
                            isPet: pet['active'],
                          )
                        : Container(
                            height: MediaQuery.of(context).size.height * 0.32,
                          ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        pet['active']
                            ? NickNameBar(
                                nickName: pet['nickname'],
                              )
                            : pet['exp'] >= 1000
                                ? AnimatedBuilder(
                                    animation:
                                        _animationController_evolution_button!,
                                    builder: (context, widget) {
                                      if (_rotateAnimation_evolution_button !=
                                          null) {
                                        return Transform.rotate(
                                          angle:
                                              _rotateAnimation_evolution_button!
                                                  .value,
                                          child: widget,
                                        );
                                      } else {
                                        return Container();
                                      }
                                    },
                                    child: const EvolutionBar(),
                                  )
                                : currentTutorial == false
                                    ? const NickNameBar(nickName: '')
                                    : ExpBar(exp: pet['exp']),
                        GestureDetector(
                          onTap: () {
                            context.push('/ploggingReady');
                          },
                          onTapDown: _onReadyTapDown,
                          onTapUp: _onReadyTapUp,
                          onTapCancel: _onReadyTapCancel,
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.05,
                            width: MediaQuery.of(context).size.width * 0.3,
                            decoration: BoxDecoration(
                              color: AppColors.readyButton,
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(width: 3, color: Colors.white),
                              boxShadow: _isReadyPressed
                                  ? []
                                  : [
                                      BoxShadow(
                                          color: AppColors.basicgray
                                              .withOpacity(0.5),
                                          offset: const Offset(0, 4),
                                          blurRadius: 1,
                                          spreadRadius: 1)
                                    ],
                            ),
                            child: Stack(
                              children: [
                                Positioned(
                                  top: MediaQuery.of(context).size.height *
                                      0.003,
                                  left:
                                      MediaQuery.of(context).size.width * 0.015,
                                  child: Container(
                                    child: const Icon(
                                      Icons.directions_run_sharp,
                                      size: 30,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    '   준비하기',
                                    style: CustomFontStyle.getTextStyle(context,
                                        CustomFontStyle.yeonSung80_white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    ClearMonster(pet: pet),
                  ],
                )
              : Container(
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
        ),
      ),
    );
  }
}
