import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geoofficeclock/Loading/animation_loading.dart';
import 'package:geoofficeclock/constant/app_colors.dart';
import 'package:geoofficeclock/provider_service/apis_services/login_Apis.dart';
import 'package:geoofficeclock/services/servicepath.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:status_alert/status_alert.dart';

class DashboardController extends GetxController {
  RxBool isChecked = false.obs;
  SharedPreferences? prefs;
  bool isLoading = true;
  bool Loading = false;
  bool showLoading = false;
  // ignore: prefer_typing_uninitialized_variables
  File? image;

  RxBool button = false.obs;
  RxBool button2 = false.obs;

  // ignore: prefer_typing_uninitialized_variables
  var latitude;
  // ignore: prefer_typing_uninitialized_variables
  var longitude;
  // ignore: prefer_typing_uninitialized_variables
  var altitude;
  // ignore: prefer_typing_uninitialized_variables
  var address;
  // ignore: prefer_typing_uninitialized_variables
  var currentFormattedDateTime;
  bool isloading = false;
  // ignore: prefer_typing_uninitialized_variables
  var currentDate;
  // ignore: prefer_typing_uninitialized_variables
  var currentTime;
  // ignore: prefer_typing_uninitialized_variables
  RxDouble workingHour = 0.0.obs;
  // ignore: prefer_typing_uninitialized_variables
  var latemin = 0.obs;
  RxString status = "".obs;

  RxBool isAttendanceMarked = false.obs;
  RxBool isCheckoutMarked = false.obs;
  RxBool isStatus = false.obs;

  ////// initlized empid /////////
  // ignore: prefer_typing_uninitialized_variables
  var empid;

  @override
  bool initialized = false;
  @override
  void onInit() {
    super.onInit();

    getLocation();
    initPrefs();
    cureentdatetime();
    checkmarkAttendanceAPI();
    getcheckStatus();
    currentDate = getCurrentFormattedDate();
    currentTime = getCurrentFormattedTime();
    currentFormattedDateTime = getCurrentFormattedDateTime();
  }

  Future<void> initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    empid = prefs?.getInt('empid');
    print("here is emp id $empid");

    initialized = true;
  }

  ////////////////    Get location    ////////////////

  Future<void> getLocation() async {
    try {
      LocationPermission permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      latitude = position.latitude;
      longitude = position.longitude;
      altitude = position.altitude;

      List<Placemark> placemarks = await placemarkFromCoordinates(
        latitude,
        longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks[0];
        String country = placemark.country ?? '';
        String city = placemark.locality ?? '';
        var address = placemark.street ?? '';

        print('Latitude: $latitude');
        print('Longitude: $longitude');
        print('Altitude: $altitude');
        print('Country: $country');
        print('City: $city');
        print('Address: $address');
      } else {
        print('No placemarks available');
      }
    } catch (e) {
      print('Error getting location: $e');
    }
  }

  ////////// current date and time //////////
  void cureentdatetime() {
    currentDate = getCurrentFormattedDate(); // "3 June, 2023"
    currentTime = getCurrentFormattedTime(); // "09:05 am"
  }

  String getCurrentFormattedDate() {
    final now = DateTime.now();
    final formatter = DateFormat('d MMMM, y');
    return formatter.format(now);
  }

  String getCurrentFormattedTime() {
    final now = DateTime.now();
    final formatter = DateFormat('hh:mm a');
    return formatter.format(now);
  }

  // Function to format DateTime
  String getCurrentFormattedDateTime() {
    final now = DateTime.now();
    final formatter = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
    return formatter.format(now);
  }

  void currentdate() {
    currentFormattedDateTime = getCurrentFormattedDateTime();
  }

  /////     Check in and Check Out    /////
  Future<void> getcheckStatus() async {
    final loginController = Get.put(LoginApis());

    try {
      final Uri uri = Uri.parse(Apis.status);

      final Map<String, String> parameters = {
        'EmpID': loginController.empID.value.toString(),
      };

      final Uri updatedUri = uri.replace(queryParameters: parameters);

      final http.Response response = await http.get(updatedUri);

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);

        empid = responseData[0]['EmpID'];
        latemin.value = responseData[0]['LateMin'];
        workingHour.value = responseData[0]['WorkingHours'];
        status.value = responseData[0]['Status'];
        isLoading = false;
        update();
      } else {
        print('API response error: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('An error occurred: $e');
    }
  }

///////////// Mark Attendance  //////////////////
  ///////  Apis to Check If Mark and Not attendance mark ///////

  Future<void> checkmarkAttendanceAPI() async {
    final loginController = Get.put(LoginApis());
    print("LOGGEDIN USER EMP ID IS ${loginController.empID.value}");
    try {
      final Uri uri = Uri.parse(Apis.checkmark);

      final Map<String, String> parameters = {
        'EmpID': loginController.empID.value.toString(),
      };

      final Uri updatedUri = uri.replace(queryParameters: parameters);

      final http.Response response = await http.get(updatedUri);

      if (response.statusCode == 200) {
        final responseBody = response.body;

        if (responseBody.contains("Ok")) {
          isAttendanceMarked.value = true;
          update();
          // ignore: use_build_context_synchronously
        } else {}
      } else {
        print('API response error: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('An error occurred: $e');
    }
  }

///////////// Mark Attendance  //////////////////
  ///////  Apis to Get attendance mark ///////

  Future<void> markAttendanceAPI(BuildContext context) async {
    final loginController = Get.put(LoginApis());
    print("response1");
    try {
      var request = http.MultipartRequest(
          'POST',
          Uri.parse(
              '${Apis.markattendance}?EmpID=${loginController.empID.toString()}&currentLatitude=${latitude.toString()}&currentLongitude=${longitude.toString()}&currentAltitude=${altitude.toString()}'));

      if (image != null) {
        request.files
            .add(await http.MultipartFile.fromPath('aaa', image!.path));
      }

      http.StreamedResponse response = await request.send();
      print('status${response.statusCode}');
      print('Response Body:$response');
      print("response2");
      if (response.statusCode == 200) {
        // ignore: unrelated_type_equality_checks

        final responseString = await response.stream.bytesToString();
        if (responseString.contains("Attendance Marked")) {
          // ignore: use_build_context_synchronously
          StatusAlert.show(
            borderRadius: BorderRadius.circular(15),
            backgroundColor: const Color.fromARGB(255, 128, 231, 105),
            context,
            duration: const Duration(seconds: 2),
            title: 'Mark Attendance',
            titleOptions: StatusAlertTextConfiguration(
                // ignore: use_build_context_synchronously
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: white, fontSize: 14, fontWeight: FontWeight.bold)),
            subtitle: '',
            configuration: const IconConfiguration(
              icon: Icons.done,
              color: white,
            ),
            maxWidth: 200.w,
          );
          // showDialog(
          //   context: context,
          //   builder: (BuildContext context) {
          //     return Dialog(
          //       backgroundColor: Colors.transparent,
          //       child: Material(
          //         type: MaterialType.transparency,
          //         child: Center(
          //           child: SvgPicture.asset(
          //             markattendance,
          //           ),
          //         ),
          //       ),
          //     );
          //   },
          // );

          isAttendanceMarked.value = true;
          update();

          // Future.delayed(const Duration(seconds: 2), () {
          //   if (Navigator.of(context).canPop()) {
          //     Navigator.of(context).pop();
          //   }
          // });
        } else if (responseString.contains("Checked Out")) {
          // ignore: use_build_context_synchronously
          StatusAlert.show(
            borderRadius: BorderRadius.circular(15),
            backgroundColor: const Color.fromARGB(255, 235, 185, 109),
            context,
            duration: const Duration(seconds: 2),
            title: 'Check Out',
            titleOptions: StatusAlertTextConfiguration(
                // ignore: use_build_context_synchronously
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: white, fontSize: 14, fontWeight: FontWeight.bold)),
            subtitle: '',
            configuration: const IconConfiguration(
              icon: Icons.done,
              color: white,
            ),
            maxWidth: 200.w,
          );

          isCheckoutMarked.value = true;
          update();

          // Future.delayed(const Duration(seconds: 2), () {
          //   if (Navigator.of(context).canPop()) {
          //     Navigator.of(context).pop();
          //   }
          // });
        }
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      print('Error: $e');

      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred: $e'),
        ),
      );
      throw Exception('An error occurred: $e');
    }
  }

  void showLoadingback() {
    Get.dialog(
      const Center(
        child: AnimationLoader(),
      ),
      barrierDismissible: false,
    );

    // Simulate some loading process
    Future.delayed(const Duration(seconds: 3), () {
      Get.back();
      Get.back();
    });
  }

  void showLocationErrorMessage(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Location Error',
            style: TextStyle(color: blue),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Lottie.asset(
                'assets/images/json1.json', // Replace with the path to your Lottie animation file
              ),
              const SizedBox(height: 16), // Add spacing
              const Text('You are not on the location'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void showLoadingfun(BuildContext context) {
    Get.dialog(
      Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const AnimationLoader(),
          Text(
            "Loading...",
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  color: white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
          )
        ],
      )),
      barrierDismissible: false,
    );

    // Simulate some loading process
    Future.delayed(const Duration(seconds: 3), () {
      Get.back();
    });
  }
}
