import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geoofficeclock/constant/svg_image.dart';
import 'package:get/get.dart';

class NetworkConnect extends GetxController {
  bool isConnected = false;
  @override
  void onInit() async {
    //// TODO: implement onInit  ////
    super.onInit();
  }

  Future<bool> checkInternetConnectivity() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  ////// -------------------- No Internet  -------------------//////

  void showNetworkErrorMessage(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(0)),
          backgroundColor: Colors.transparent,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(networkerror),
              // Add spacing
            ],
          ),
        );
      },
    );
  }
}
