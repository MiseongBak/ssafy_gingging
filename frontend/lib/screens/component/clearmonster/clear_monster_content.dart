import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/core/theme/constant/app_colors.dart';
import 'package:frontend/core/theme/constant/app_icons.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';

class ClearMonsterContent extends StatefulWidget {
  final Color color;
  final String content;
  final int count;
  final Image monster;

  const ClearMonsterContent({
    super.key,
    required this.color,
    required this.content,
    required this.count,
    required this.monster,
  });

  @override
  State<ClearMonsterContent> createState() => _ClearMonsterContentState();
}

class _ClearMonsterContentState extends State<ClearMonsterContent>
    with TickerProviderStateMixin {
  AnimationController? _animationController_monster;
  Animation<double>? _rotateAnimation_monster;

  bool _isPressed = false;

  void _onTapDown(TapDownDetails details) {
    setState(() {
      _isPressed = true;
    });
  }

  void _onTapUp(TapUpDetails details) {
    setState(() {
      _isPressed = false;
    });
  }

  void _onTapCancel() {
    setState(() {
      _isPressed = false;
    });
  }

  @override
  void initState() {
    super.initState();

    _animationController_monster = AnimationController(
        duration: const Duration(milliseconds: 800), vsync: this);
    _rotateAnimation_monster = Tween<double>(begin: -0.15, end: 0.15)
        .animate(_animationController_monster!);

    _animationController_monster!.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController_monster!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Container(
              // color: Colors.yellow,
              child: Stack(
                children: [
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.5,
                    left: MediaQuery.of(context).size.width * 0.1,
                    child: AnimatedBuilder(
                      animation: _animationController_monster!,
                      builder: (context, widget) {
                        if (_rotateAnimation_monster != null) {
                          return Transform.rotate(
                            angle: _rotateAnimation_monster!.value,
                            child: widget,
                          );
                        } else {
                          return Container();
                        }
                      },
                      child: Container(
                        // color: Colors.white,
                        child: Image.asset(widget.content == '플라몽'
                            ? AppIcons.plamong
                            : widget.content == '포 캔몽'
                                ? AppIcons.pocanmong
                                : widget.content == '율몽'
                                    ? AppIcons.yulmong
                                    : AppIcons.mizzomon),
                      ),
                    ),
                  ),
                  Container(
                    child: Stack(
                      children: [
                        Positioned(
                          top: MediaQuery.of(context).size.height * 0.24,
                          right: MediaQuery.of(context).size.height * 0,
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.7,
                            child: Image.asset(AppIcons.intro_speak_bubble),
                          ),
                        ),
                        widget.content == '플라몽'
                            ? Positioned(
                                top: MediaQuery.of(context).size.height * 0.29,
                                right: MediaQuery.of(context).size.width * 0.08,
                                child: Column(
                                  children: [
                                    Text(
                                      '플라스틱으로',
                                      style: CustomFontStyle.getTextStyle(
                                        context,
                                        CustomFontStyle.yeonSung100,
                                      ),
                                    ),
                                    Text(
                                      '온 지구를 점령 해주지!',
                                      style: CustomFontStyle.getTextStyle(
                                        context,
                                        CustomFontStyle.yeonSung100,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : widget.content == '포 캔몽'
                                ? Positioned(
                                    top: MediaQuery.of(context).size.height *
                                        0.27,
                                    right: MediaQuery.of(context).size.width *
                                        0.19,
                                    child: Column(
                                      children: [
                                        Text(
                                          '후후후..',
                                          style: CustomFontStyle.getTextStyle(
                                            context,
                                            CustomFontStyle.yeonSung100,
                                          ),
                                        ),
                                        Text(
                                          '이제 지구는',
                                          style: CustomFontStyle.getTextStyle(
                                            context,
                                            CustomFontStyle.yeonSung100,
                                          ),
                                        ),
                                        Text(
                                          '캔 세상이야!',
                                          style: CustomFontStyle.getTextStyle(
                                            context,
                                            CustomFontStyle.yeonSung100,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : widget.content == '율몽'
                                    ? Positioned(
                                        top:
                                            MediaQuery.of(context).size.height *
                                                0.265,
                                        right:
                                            MediaQuery.of(context).size.width *
                                                0.1,
                                        child: Column(
                                          children: [
                                            Text(
                                              '흐흐',
                                              style:
                                                  CustomFontStyle.getTextStyle(
                                                context,
                                                CustomFontStyle.yeonSung100,
                                              ),
                                            ),
                                            Text(
                                              '지구를 유리 세상으로',
                                              style:
                                                  CustomFontStyle.getTextStyle(
                                                context,
                                                CustomFontStyle.yeonSung100,
                                              ),
                                            ),
                                            Text(
                                              '만들어 볼까?',
                                              style:
                                                  CustomFontStyle.getTextStyle(
                                                context,
                                                CustomFontStyle.yeonSung100,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    : Positioned(
                                        top:
                                            MediaQuery.of(context).size.height *
                                                0.3,
                                        right:
                                            MediaQuery.of(context).size.width *
                                                0.16,
                                        child: Column(
                                          children: [
                                            Text(
                                              '일반 쓰레기도',
                                              style:
                                                  CustomFontStyle.getTextStyle(
                                                context,
                                                CustomFontStyle.yeonSung100,
                                              ),
                                            ),
                                            Text(
                                              '만만치 않을걸~',
                                              style:
                                                  CustomFontStyle.getTextStyle(
                                                context,
                                                CustomFontStyle.yeonSung100,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        );
      },
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: Container(
        padding: EdgeInsets.fromLTRB(10, 3, 10, 3),
        width: MediaQuery.of(context).size.width * 0.42,
        height: MediaQuery.of(context).size.height * 0.11,
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.circular(10),
          boxShadow: _isPressed
              ? []
              : [
                  BoxShadow(
                    color: AppColors.basicgray.withOpacity(0.5),
                    offset: Offset(0, 4),
                    blurRadius: 1,
                    spreadRadius: 1,
                  )
                ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.07,
                  child: widget.monster,
                ),
                Text(
                  widget.content,
                  style: CustomFontStyle.getTextStyle(
                      context, CustomFontStyle.yeonSung60_white),
                ),
              ],
            ),
            Column(
              children: [
                Row(
                  // crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${widget.count}',
                      style: CustomFontStyle.getTextStyle(
                          context, CustomFontStyle.yeonSung140_white),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.02,
                    ),
                    Text(
                      '마리',
                      style: CustomFontStyle.getTextStyle(
                          context, CustomFontStyle.yeonSung60_white),
                    ),
                  ],
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.02,
                ),
                Text(
                  '처치 완료',
                  style: CustomFontStyle.getTextStyle(
                      context, CustomFontStyle.yeonSung60_white),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
