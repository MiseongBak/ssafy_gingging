import 'package:flutter/material.dart';

class PloggingProvider with ChangeNotifier {
  PloggingProvider();

  int _plastic = 0;
  int _can = 0;
  int _glass = 0;
  int _normal = 0;
  int _value = 0;
  int _box = 0;
  bool _isExp = false;

  void setTrashs(int newPlastic, int newCan, int newGlass, int newNormal,
      int newValue, int newBox, bool newIsExp) {
    _plastic = newPlastic;
    _can = newCan;
    _glass = newGlass;
    _normal = newNormal;
    _value = newValue;
    _box = newBox;
    _isExp = newIsExp;
    notifyListeners(); // 상태 변경 알림
  }

  isPlogging() {
    if (_plastic > 0 || _can > 0 || _glass > 0 || _normal > 0) {
      return true;
    }
    return false;
  }

  getTrashs() {
    return {
      'plastic': _plastic,
      'can': _can,
      'glass': _glass,
      'normal': _normal,
      'value': _value,
      'box': _box,
      'isExp': _isExp
    };
  }
}
