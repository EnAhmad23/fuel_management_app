import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TripProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController subNameCon = TextEditingController();
  TextEditingController dateCon = TextEditingController();
  TextEditingController reasonCon = TextEditingController();
  List<String>? consumerNames;
  List<String>? subNames;
  String? _subConName;
  String? _conName;
  String? _hintText;
  DateTime? _date;
  DateTime? get date {
    return _date;
  }

  String? get subConName {
    return _subConName;
  }

  String? get conName {
    return _conName;
  }

  String? get hintText {
    return (date) == null
        ? 'yyyy-MM-dd'
        : DateFormat('yyyy-MM-dd').format(date ?? DateTime.now());
  }

  setDate(DateTime? date) {
    if (date != null) {
      _date = date;
      notifyListeners();
    }
  }

  setSubConName(String? name) {
    if (name != null) {
      _subConName = name;
    }
  }

  setConName(String? name) {
    if (name != null) {
      _conName = name;
    }
  }

  setHintText(String? name) {
    if (name != null) {
      _hintText = name;
    }
  }

  void onTapButton() {}
}
