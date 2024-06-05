import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class MainProvider with ChangeNotifier {
  MainProvider();

  late String isMenuSelected = 'main';

  void menuSelected(String SelectedMenu) {
    isMenuSelected = SelectedMenu;
    notifyListeners();
  }

  late BluetoothDevice _device;

  void setDevice(BluetoothDevice device) {
    _device = device;
    notifyListeners();
  }

  BluetoothDevice getDevice() {
    return _device;
  }

  bool _isTutorialPloggingFinish = false;

  void setIsTutorialPloggingFinish() {
    _isTutorialPloggingFinish = true;
    notifyListeners();
  }

  bool getIsTutorialPloggingFinish() {
    return _isTutorialPloggingFinish;
  }
}
