import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SubProvider extends ChangeNotifier {
  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();
  String? dropdownValue;
  changeDropdownValue(String? newValue) {
    dropdownValue = newValue;
    notifyListeners();
  }
}
