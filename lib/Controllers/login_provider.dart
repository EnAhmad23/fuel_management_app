import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  final GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController userName = TextEditingController();
  TextEditingController password = TextEditingController();
}
