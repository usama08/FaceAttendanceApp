import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  Future<SharedPreferences> prefs = SharedPreferences.getInstance();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  void onInit() {
    super.onInit();
    saveCredentials;
    prefs = SharedPreferences.getInstance();
  }

  //// ------------------- remeber me ----------------------///////
  saveCredentials(String username, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', username);
    await prefs.setString('password', password);
  }

  //// -------------------- No Internet  -------------------//////
}
