import 'package:device_info_plus/device_info_plus.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geoofficeclock/controller/shared_preference.dart';
import 'package:geoofficeclock/services/servicepath.dart';
import 'package:geoofficeclock/view/Login/controller/login_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class LoginApis extends GetxController {
  SharedPreferences? prefs;
  var user = Get.put(LoginController());
  bool isLoading = false;
  // ignore: prefer_typing_uninitialized_variables
  var androidDeviceInfo;
  // ignore: prefer_typing_uninitialized_variables
  var iosDeviceInfo;
  // ignore: prefer_typing_uninitialized_variables
  var mobileName;
  // ignore: prefer_typing_uninitialized_variables
  var mobileVersion;
  // ignore: prefer_typing_uninitialized_variables
  var mobileIdentifier;
  // ignore: prefer_typing_uninitialized_variables
  var deviceId;
  // ignore: prefer_typing_uninitialized_variables
  var latitude;
  // ignore: prefer_typing_uninitialized_variables
  var longitude;
  // ignore: prefer_typing_uninitialized_variables
  var altitude;
  // ignore: prefer_typing_uninitialized_variables
  var address;
  // ignore: prefer_typing_uninitialized_variables
  var releaseVersion;
  Future<void> initPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  void onInit() {
    super.onInit();
    initPrefs();
    initDeviceInfo();
    getLocation();
  }

  Future<void> initDeviceInfo() async {
    try {
      final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

      AndroidDeviceInfo androidDeviceInfo;
      IosDeviceInfo iosDeviceInfo;

      if (GetPlatform.isAndroid) {
        androidDeviceInfo = await deviceInfoPlugin.androidInfo;
        mobileName = androidDeviceInfo.model;
        mobileVersion = androidDeviceInfo.version.release;
        mobileIdentifier = androidDeviceInfo.brand;
        deviceId = androidDeviceInfo.id;
      } else if (GetPlatform.isIOS) {
        iosDeviceInfo = await deviceInfoPlugin.iosInfo;
        mobileName = iosDeviceInfo.model;
        mobileVersion = iosDeviceInfo.systemVersion;
        mobileIdentifier = iosDeviceInfo.identifierForVendor;
        deviceId = iosDeviceInfo.identifierForVendor;
      }

      print('Mobile Name: $mobileName');
      print('Mobile Version: $mobileVersion');
      print('Mobile Identifier: $mobileIdentifier');
      print('Device ID: $deviceId');
    } catch (e) {
      print('Error getting device info: $e');
    }
  }

  //// to get app release version  ////////////////////////
  Future<String> getReleaseVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    releaseVersion = await getReleaseVersion();
    print('Release Version: $releaseVersion');
    return packageInfo.version;
  }

// Example usage:

////////////////    Get location ///////////////////////////

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

  RxInt empID = 0.obs;
  RxString username = "".obs;
  RxBool isPhoto = false.obs;
  RxBool isAllow = false.obs;
  RxDouble Latitude = 0.0.obs;
  RxDouble Longitude = 0.0.obs;
  RxDouble Altitude = 0.0.obs;

  Future<void> fetchLoginData(context) async {
    // final SharedPreferenceController _sharedPreferenceController =
    //     SharedPreferenceController();
    var userName = await SharedPref.getUserName();
    var userPass = await SharedPref.getPassword();

    print("USERNAME IS -----$userName");
    print("PASSWORD IS ++++++ $userPass");

    try {
      final Uri uri = Uri.parse(Apis.logInApi);
      final Map<String, String> parameters = {
        'UserName': user.username.text,
        'Password': user.password.text,
        'IsSuccessfull': 'true',
        'MobileName': mobileName,
        'MobileVersion': mobileVersion,
        'MobileIdentifier': mobileIdentifier,
        'IMEINo': deviceId,
        'Location': address.toString(),
        'Latitude': latitude.toString(),
        'Longitude': longitude.toString(),
        'Altitude': altitude.toString(),
        'ReleaseVersion': releaseVersion.toString(),
        'NotificationTokenId': 'test',
        'CreatedHost': 'test',
        'DevAppID': deviceId,
        'IsAuthenticate': 'true',
      };

      final Uri updatedUri = uri.replace(queryParameters: parameters);

      final http.Response response =
          await http.get(updatedUri); // Use http.Response

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        empID.value = responseData[0]['EmpID'];
        username.value = responseData[0]['UserName'];
        isPhoto.value = responseData[0]['IsAllowPhoto'];
        isAllow.value = responseData[0]['IsAllowAttendance'];
        Longitude.value = responseData[0]['Longitude'];
        Latitude.value = responseData[0]['Latitude'];
        Altitude.value = responseData[0]['Altitude'];
        SharedPref.saveLoggedIn(true);
        SharedPref.saveUserName(user.username.text.toString());

        SharedPref.savePassword(user.password.text.toString());
        print("mylongvalue${Longitude.value}");
        update();
      } else {
        throw Exception('API response error: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('An error occurred: $e');
    }
  }
}
