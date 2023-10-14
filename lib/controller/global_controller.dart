import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class Globalfunctions extends GetxController {
  @override
  void onInit() {
    super.onInit();
    showAboutDialog;
    showDatePickerIitial;
  }

////////  inital datapicker ///////////
  DateTime dateTime = DateTime.now();
  // ignore: prefer_typing_uninitialized_variables
  var formattedDate = "31 May 2023".obs;
  void showDatePickerIitial(BuildContext context) {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2025))
        .then((value) {
      dateTime = value!;
      formattedDate = DateFormat('d MMM  yyyy').format(dateTime).obs;
      print(formattedDate);
    });
  }
}
