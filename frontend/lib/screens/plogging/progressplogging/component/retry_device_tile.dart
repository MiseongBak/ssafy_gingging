import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frontend/core/theme/constant/app_colors.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';
import 'package:frontend/provider/main_provider.dart';
import 'package:provider/provider.dart';

class RetryDeviceTile extends StatefulWidget {
  final BluetoothDevice device;
  final Function func;

  const RetryDeviceTile({
    super.key,
    required this.device,
    required this.func,
  });

  @override
  State<RetryDeviceTile> createState() => _RetryDeviceTileState();
}

class _RetryDeviceTileState extends State<RetryDeviceTile>
    with TickerProviderStateMixin {
  final int maxRetries = 7; // 최대 재시도 횟수
  int retryCount = 0; // 현재 재시도 횟수
  bool isConnected = false;

  AnimationController? _animationController_dot1;
  Animation<double>? _scaleAnimation_dot1;
  AnimationController? _animationController_dot2;
  Animation<double>? _scaleAnimation_dot2;
  AnimationController? _animationController_dot3;
  Animation<double>? _scaleAnimation_dot3;

  @override
  void initState() {
    super.initState();

    _animationController_dot1 = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    _scaleAnimation_dot1 =
        Tween<double>(begin: 0, end: 1).animate(_animationController_dot1!);

    _animationController_dot2 = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    _scaleAnimation_dot2 =
        Tween<double>(begin: 0, end: 1).animate(_animationController_dot2!);

    _animationController_dot3 = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    _scaleAnimation_dot3 =
        Tween<double>(begin: 0, end: 1).animate(_animationController_dot3!);

    _animationController_dot1!.repeat(reverse: true);
    Future.delayed(const Duration(milliseconds: 500), () {
      _animationController_dot2!.repeat(reverse: true);
    });
    Future.delayed(const Duration(milliseconds: 1000), () {
      _animationController_dot3!.repeat(reverse: true);
    });
  }

  @override
  void dispose() {
    _animationController_dot1!.dispose();
    _animationController_dot2!.dispose();
    _animationController_dot3!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            connectToDevice(widget.device);
          },
          child: Container(
            width: MediaQuery.of(context).size.width * 0.7,
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
            decoration: BoxDecoration(
              color: AppColors.basicgray,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.white, width: 2),
              boxShadow: [
                BoxShadow(
                    color: AppColors.basicgray.withOpacity(0.5),
                    offset: const Offset(0, 4),
                    blurRadius: 1,
                    spreadRadius: 1)
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.device.advName.length > 15
                      ? '${widget.device.advName.substring(0, 15)}...'
                      : widget.device.advName,
                  style: CustomFontStyle.getTextStyle(
                      context, CustomFontStyle.yeonSung60_white),
                ),
                isConnected
                    ? Row(
                        children: [
                          Text(
                            '연결중',
                            style: CustomFontStyle.getTextStyle(
                                context, CustomFontStyle.yeonSung60_white),
                          ),
                          AnimatedBuilder(
                            animation: _scaleAnimation_dot1!,
                            builder: (context, widget) {
                              if (_scaleAnimation_dot1 != null) {
                                return Transform.scale(
                                  scale: _scaleAnimation_dot1!.value,
                                  child: widget,
                                );
                              } else {
                                return Container();
                              }
                            },
                            child: Text(
                              '.',
                              style: CustomFontStyle.getTextStyle(
                                  context, CustomFontStyle.yeonSung60_white),
                            ),
                          ),
                          AnimatedBuilder(
                            animation: _scaleAnimation_dot2!,
                            builder: (context, widget) {
                              if (_scaleAnimation_dot2 != null) {
                                return Transform.scale(
                                  scale: _scaleAnimation_dot2!.value,
                                  child: widget,
                                );
                              } else {
                                return Container();
                              }
                            },
                            child: Text(
                              '.',
                              style: CustomFontStyle.getTextStyle(
                                  context, CustomFontStyle.yeonSung60_white),
                            ),
                          ),
                          AnimatedBuilder(
                            animation: _scaleAnimation_dot3!,
                            builder: (context, widget) {
                              if (_scaleAnimation_dot3 != null) {
                                return Transform.scale(
                                  scale: _scaleAnimation_dot3!.value,
                                  child: widget,
                                );
                              } else {
                                return Container();
                              }
                            },
                            child: Text(
                              '.',
                              style: CustomFontStyle.getTextStyle(
                                  context, CustomFontStyle.yeonSung60_white),
                            ),
                          ),
                        ],
                      )
                    : Text(
                        '',
                        style: CustomFontStyle.getTextStyle(
                            context, CustomFontStyle.yeonSung60_white),
                      )
              ],
            ),
          ),
        ),
      ],
    );
  }

  connectToDevice(BluetoothDevice device) async {
    if (device.isConnected) {
      return;
    }
    setState(() {
      isConnected = true;
      retryCount += 1;
    });
    if (retryCount == maxRetries) {
      retryCount = 0;
      isConnected = false;
      Fluttertoast.showToast(msg: '연결에 실패했습니다. 다시 한번 시도 해주세요');
    }
    try {
      await device.connect();
    } catch (e) {
      connectToDevice(device);
    }
    if (device.isConnected && mounted) {
      Fluttertoast.showToast(msg: '${device.advName} 연결됨');
      var main = Provider.of<MainProvider>(context, listen: false);
      main.setDevice(device);
      Navigator.of(context).pop(); // 대화상자 닫기
      widget.func();
      // context.go('/ploggingProgress');
      // Navigator.of(context).push(MaterialPageRoute(
      //   builder: (context) => const ProgressPlogging(),
      // ));
    }
  }
}
