import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frontend/core/theme/constant/app_colors.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';
import 'package:frontend/screens/plogging/progressplogging/component/retry_device_tile.dart';

class RetryConnectedDialog extends StatefulWidget {
  final Function onFinish;
  final Function onConnect;
  const RetryConnectedDialog({
    super.key,
    required this.onFinish,
    required this.onConnect,
  });

  @override
  State<RetryConnectedDialog> createState() => _RetryConnectedState();
}

class _RetryConnectedState extends State<RetryConnectedDialog> {
  List<ScanResult> scanResults = [];
  bool isScanning = false;
  bool blueConnect = false;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(3, 3, 3, 3),
                height: MediaQuery.of(context).size.height * 0.04,
                width: MediaQuery.of(context).size.width * 0.65,
                decoration: BoxDecoration(
                  color: AppColors.basicgreen,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    '블루투스 기기 목록',
                    style: CustomFontStyle.getTextStyle(
                      context,
                      CustomFontStyle.yeonSung80_white,
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 0,
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEEEBF5),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              Positioned(
                right: 0,
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: AppColors.basicgreen,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      FontAwesomeIcons.circleXmark,
                      size: 41,
                      color: Color(0xFFEEEBF5),
                    ),
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.4,
            width: MediaQuery.of(context).size.height * 0.4,
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: scanResults.length,
                itemBuilder: (BuildContext context, int idx) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: RetryDeviceTile(
                      device: scanResults[idx].device,
                      func: widget.onConnect,
                    ),
                  );
                }),
          ),
          const Text('서비스와 호환되는 기기만 표시'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    widget.onFinish();
                  },
                  child: const Text('플로깅 종료')),
              ElevatedButton(
                  onPressed: () => isScanning ? null : startScan(),
                  child: Text(isScanning ? '검색 중' : '기기 검색'))
            ],
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    bluetoothSetting();
    initBle();
  }

  // 다이얼로그 끄면 스캔 멈추게
  @override
  void dispose() {
    super.dispose();
    FlutterBluePlus.stopScan();
  }

  void initBle() {
    // BLE 스캔 상태 얻기 위한 리스너
    FlutterBluePlus.isScanning.listen((isScan) {
      isScanning = isScan;
      setState(() {});
    });
  }

  bluetoothSetting() async {
    if (await FlutterBluePlus.isSupported == false) {
      Fluttertoast.showToast(msg: '블루투스가 지원되지 않습니다.');
      return;
    }

    FlutterBluePlus.adapterState.listen((BluetoothAdapterState state) async {
      if (state == BluetoothAdapterState.on) {
      } // 블루투스가 켜져있다면 스캔 시작
      else {
        if (Platform.isAndroid) {
          if (!blueConnect) {
            blueConnect = true;
            await FlutterBluePlus.turnOn();
            Fluttertoast.showToast(msg: '기기 연결됨');
            blueConnect = false;
          }
        }
      } // 블루투스 꺼져있다면 다시 켤 수 있도록
    });
  }

  void startScan() {
    if (!isScanning) {
      scanResults.clear(); // 스캔 중 아니라면 기존 스캔 목록 삭제

      FlutterBluePlus.startScan(
          timeout: const Duration(seconds: 10)); // 새로운 스캔 시작

      var subscription = FlutterBluePlus.scanResults.listen((results) {
        setState(() {
          scanResults = results
              .where((result) => result.device.advName == 'GingStick')
              .toList();
        });
        for (ScanResult result in results) {
          if (result.device.advName.isNotEmpty) {
            print('${result.device.advName} found! rssi: ${result.rssi}');
          }
        }
      });
      FlutterBluePlus.cancelWhenScanComplete(subscription);
    } else {
      FlutterBluePlus.stopScan();
    }
  }
}
