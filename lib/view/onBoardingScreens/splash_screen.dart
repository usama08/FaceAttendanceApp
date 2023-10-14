import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geoofficeclock/constant/common%20_image.dart';
import 'package:geoofficeclock/controller/shared_preference.dart';
import 'package:geoofficeclock/provider_service/apis_services/login_Apis.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  final VoidCallback onBoardingCompleted;

  const SplashScreen({Key? key, required this.onBoardingCompleted})
      : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initializeSplashScreen();
  }

  var loginController = Get.put(LoginApis());

  void _initializeSplashScreen() async {
    var loggedIn = await SharedPref.getLoggedIn();
    // print("IS LOGGED IN ====== $loggedIn");

    if (loggedIn != null || loggedIn == true) {
      loginController.getLocation();
      loginController.initDeviceInfo();
      // ignore: use_build_context_synchronously
      loginController.fetchLoginData(context);
    } else {
      Timer(const Duration(seconds: 2), () {
        widget.onBoardingCompleted(); // Call the onBoardingCompleted function
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Image(
          image: AssetImage(splash),
          fit: BoxFit.cover,
          height: double.infinity,
          width: double.infinity,
          alignment: Alignment.center,
        ),
      ),
    );
  }
}
