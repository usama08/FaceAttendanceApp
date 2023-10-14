import 'dart:convert';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:geoofficeclock/constant/app_colors.dart';
import 'package:geoofficeclock/models/reportalldays.dart';
import 'package:geoofficeclock/models/reporttwodays.dart';
import 'package:geoofficeclock/network_utils/connectivity.dart';
import 'package:geoofficeclock/provider_service/apis_services/login_Apis.dart';
import 'package:geoofficeclock/services/servicepath.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class DatePicker extends ChangeNotifier {
  TextEditingController quotation = TextEditingController();
  final networkcontroller = Get.put(NetworkConnect());
  bool isLoadingTimerActive = false;
  bool isLoading = true;
  bool hasBeenPressed = false;
  bool hasBeenPressed2 = false;

  // ignore: prefer_typing_uninitialized_variables
  String? selectedValue = "Select Leave type";
  String? dumyvalue = "Select Leave type";
  // ignore: prefer_typing_uninitialized_variables
  var firsthalf;
  // ignore: prefer_typing_uninitialized_variables
  var secondhalf;

  void updateControllerValue() {
    // Depending on _hasBeenPressed2, set the value in your controller
    if (!hasBeenPressed) {
      firsthalf = "1st Half";
    } else {
      firsthalf = "";
    }
  }

//////////////////////// ---------------------- reset all values -------------------------//////////////
  void resetValues() {
    formattedFirstfullday;
    formattedLastfullday;
    firsthalf = null;
    hasBeenPressed = false;
    hasBeenPressed2 = false;
    selectedValue = dumyvalue;
    quotation.text = '';
  }
///////////////////// --------------- Update the Page  ------------------//////////////////

  void updateControllerValue2() {
    // Depending on _hasBeenPressed2, set the value in your controller
    if (!hasBeenPressed2) {
      firsthalf = "2nd Half";
    } else {
      firsthalf = "";
    }
  }
////////////////// --------------------- //////////////////////////

  ////////////////////// ----------------------  reset function ------------------ ////////////////////////////

  void resetDates() {
    selectedDate = DateTime.now();
    DateTime firstfullday = DateTime.now();
    DateTime lastfullday = DateTime.now();
    formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
    startto = DateFormat('yyyy-MM-dd').format(selectedDate);
    endto = DateFormat('yyyy-MM-dd').format(selectedDate);
    endDate = DateFormat('yyyy-MM-dd').format(selectedDate);
    formattedFirstfullday = DateFormat('yyyy-MM-dd').format(firstfullday);
    formattedLastfullday = DateFormat('yyyy-MM-dd').format(lastfullday);
    thirtyDaysAgo = selectedDate.subtract(const Duration(days: 30));
    currentTime = DateFormat('HH:mm:a').format(DateTime.now());
    notifyListeners();
  }

  // ignore: prefer_typing_uninitialized_variables
  var currentTime;
  late DateTime selectedDate;
  // ignore: prefer_typing_uninitialized_variables
  var formattedDate;
  // ignore: prefer_typing_uninitialized_variables
  var startto;
  // ignore: prefer_typing_uninitialized_variables
  var endto;
  // ignore: prefer_typing_uninitialized_variables
  var endDate;
  // ignore: prefer_typing_uninitialized_variables
  var currentDate;
  // ignore: prefer_typing_uninitialized_variables
  var currentDateformat;
  // ignore: prefer_typing_uninitialized_variables
  var formattedFirstfullday;
  // ignore: prefer_typing_uninitialized_variables
  var formattedLastfullday;
  // ignore: prefer_typing_uninitialized_variables
  var thirtyDaysAgo;
  DateTime firstfullday = DateTime.now();
  DateTime lastfullday = DateTime.now();
  List<ReportData> reportDataList = [];
  List<Reporttwodays> allreportDataList = [];
  DatePicker() {
    selectedDate = DateTime.now();
    formattedFirstfullday = DateFormat('yyyy-MM-dd').format(firstfullday);
    formattedLastfullday = DateFormat('yyyy-MM-dd').format(lastfullday);
    lastfullday = DateTime.now();
    startto = DateFormat('yyyy-MM-dd').format(selectedDate);
    firstfullday = DateTime.now();
    endto = DateFormat('yyyy-MM-dd').format(selectedDate);
    thirtyDaysAgo = selectedDate.subtract(const Duration(days: 30));
    currentTime = DateFormat('hh:mm a').format(DateTime.now());
    currentDate = DateFormat('yyyy-MM-dd').format(selectedDate);
    currentDateformat = DateFormat('d MMMM, yyyy').format(selectedDate);
    formattedDate = DateFormat('yyyy-MM-dd').format(thirtyDaysAgo);
    endDate = DateFormat('yyyy-MM-dd').format(selectedDate);
    if (currentTime == '12:00 AM') {
      currentTime = '12:00 PM';
    } else if (currentTime == '12:00 PM') {
      currentTime = '12:00 AM';
    }
    notifyListeners();
  }

  Future<void> selectDate({BuildContext? context, type}) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context!,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: customDatePickerTheme(context), // Apply the custom theme
          child: child!,
        );
      },
    );

    if (pickedDate != null && pickedDate != selectedDate) {
      if (type == "start") {
        selectedDate = pickedDate;
        formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
      } else if (type == "enddate") {
        selectedDate = pickedDate;
        endDate = DateFormat('yyyy-MM-dd').format(selectedDate);
      } else if (type == "startto") {
        selectedDate = pickedDate;
        startto = DateFormat('yyyy-MM-dd').format(selectedDate);
      } else if (type == "endto") {
        selectedDate = pickedDate;
        endto = DateFormat('yyyy-MM-dd').format(selectedDate);
      } else if (type == "hrfrom") {
        selectedDate = pickedDate;
        firstfullday = pickedDate;
        formattedFirstfullday = DateFormat('yyyy-MM-dd').format(firstfullday);
      } else if (type == "hrto") {
        selectedDate = pickedDate;
        lastfullday = pickedDate;
        formattedLastfullday = DateFormat('yyyy-MM-dd').format(lastfullday);
      } else {
        selectedDate = pickedDate;
        formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
      }

      notifyListeners();
    }
  }

  ThemeData customDatePickerTheme(BuildContext context) {
    return ThemeData(
      primaryColor: Colors.blue, // Change the primary color
      hintColor: Colors.blueAccent,
      appBarTheme: const AppBarTheme(
          backgroundColor: latestatus), // Change the accent color
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: Colors.black), // Change the text color
        titleMedium: TextStyle(color: Colors.black), // Change the subtext color
      ),
      dialogBackgroundColor:
          searchcolor, // Change the background color of the date picker dialog
      // You can customize more theme properties as needed
    );
  }

/////////// -----------------------   Difference Between two Days ---------------- ////////////
  void calculateDateTimeDifference(
      DateTime firstfullday, DateTime lastfullday) {
    Duration difference = lastfullday.difference(firstfullday);

    print(difference);

    firsthalf = difference.inDays;

    print("dayyyy$firsthalf");
  }

///////////////// --------------------   Variables ------------------ /////////////////////////////
  // ignore: prefer_typing_uninitialized_variables
  var emID;
  // ignore: prefer_typing_uninitialized_variables
  var userName;
  // ignore: prefer_typing_uninitialized_variables
  var latedays;
  // ignore: prefer_typing_uninitialized_variables
  var leaves;
  // ignore: prefer_typing_uninitialized_variables
  var outdoorduty;
  // ignore: prefer_typing_uninitialized_variables
  var presents;
  // ignore: prefer_typing_uninitialized_variables
  var totalAbsent;
  // ignore: prefer_typing_uninitialized_variables
  var totalDays;
  // ignore: prefer_typing_uninitialized_variables
  var workFromHome;

  ////////////////// --------------- apis for get data of date and time ---------------- ////////////////////////
  Future<List<ReportData>> fetchreport() async {
    reportDataList.clear();
    final loginController = Get.put(LoginApis());

    try {
      final Uri uri = Uri.parse(Apis.attendacedata);
      final Map<String, String> parameters = {
        'EmpID': loginController.empID.value.toString(),
        'DateFrom': formattedDate,
        'DateTo': endDate,
      };

      final Uri updatedUri = uri.replace(queryParameters: parameters);

      final http.Response response = await http.get(updatedUri);

      if (response.statusCode == 200) {
        print("myresponsestatus$response");
        final List<dynamic> responseData = json.decode(response.body);
        emID = responseData[0]['EmpID'];
        userName = responseData[0]['FullName'];
        latedays = responseData[0]['LateDays'];
        leaves = responseData[0]['Leaves'];
        outdoorduty = responseData[0]['OutDoorDuty'];
        presents = responseData[0]['Presents'];
        totalAbsent = responseData[0]['TotalAbsent'];
        totalDays = responseData[0]['TotalDays'];
        workFromHome = responseData[0]['WorkFromHome'];
        isLoading = false;
        notifyListeners();
        print("myemmpid$userName");

        return reportDataList; // Return the list of report data
      } else {
        print("myresponse400");
        isLoading = false;
        notifyListeners();
        print('API Error - Status Code: ${response.statusCode}');
        print('API Error - Response Body: ${response.body}');
        throw Exception('API response error: ${response.reasonPhrase}');
      }
    } catch (e) {
      isLoading = false;
      notifyListeners();
      print('Error: $e');
      throw Exception('An error occurred: $e');
    }
  }

  //////////////////////  ------  Another apis for get data of date and time  ------  ////////////////////////
  // ignore: prefer_typing_uninitialized_variables
  var mobileName;
  // ignore: prefer_typing_uninitialized_variables
  var empiduser;
  // ignore: prefer_typing_uninitialized_variables
  var allpresent;
  // ignore: prefer_typing_uninitialized_variables
  var allabsents;
  // ignore: prefer_typing_uninitialized_variables
  var lates;
  // ignore: prefer_typing_uninitialized_variables
  var allworking;
  // ignore: prefer_typing_uninitialized_variables
  var cl;
  // ignore: prefer_typing_uninitialized_variables
  var ml;
  // ignore: prefer_typing_uninitialized_variables
  var el;
  // ignore: prefer_typing_uninitialized_variables
  var cpl;
  // ignore: prefer_typing_uninitialized_variables
  var sl;
  // ignore: prefer_typing_uninitialized_variables
  var wop;
  // ignore: prefer_typing_uninitialized_variables
  var fhl;
  // ignore: prefer_typing_uninitialized_variables
  var shl;
  // ignore: prefer_typing_uninitialized_variables
  var lateMinutes;
  // ignore: prefer_typing_uninitialized_variables
  var workingHours;
  // ignore: prefer_typing_uninitialized_variables
  var leavess;
  Future<List<Reporttwodays>> alldatafetch() async {
    allreportDataList.clear();
    final loginController = Get.put(LoginApis());

    try {
      final Uri uri = Uri.parse(Apis.allattendancedata);
      final Map<String, String> parameters = {
        'EmpID': loginController.empID.value.toString(),
        'DateFrom': startto,
        'DateTo': endto,
      };

      final Uri updatedUri = uri.replace(queryParameters: parameters);

      final http.Response response = await http.get(updatedUri);

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        allpresent = responseData[0]['Presents'];
        allabsents = responseData[0]['TotalAbsent'];
        empiduser = responseData[0]['EmpID'];
        userName = responseData[0]['FullName'];
        lates = responseData[0]['LateDays'];
        leavess = responseData[0]['Leaves'];
        outdoorduty = responseData[0]['OutDoorDuty'];

        totalDays = responseData[0]['TotalDays'];
        workFromHome = responseData[0]['WorkFromHome'];
        cl = responseData[0]['CL'];
        ml = responseData[0]['ML'];
        el = responseData[0]['EL'];
        cpl = responseData[0]['CPL'];
        sl = responseData[0]['SL'];
        wop = responseData[0]['WOP'];
        fhl = responseData[0]['FHL'];
        shl = responseData[0]['SHL'];
        lateMinutes = responseData[0]['LateMinutes'];
        workingHours = responseData[0]['WorkingHours'];

        isLoading = false;
        notifyListeners();
        return allreportDataList;
        // Return the list of report data
      } else {
        throw Exception('API response error: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('An error occurred: $e');
    }
  }

  //////////////////////// -----------  Leave request Apis  ------------- ///////////////////////

  Future<void> makeLeaveRequest(BuildContext context) async {
    final loginController = Get.put(LoginApis());
    print("response1");
    try {
      var request = http.Request(
          'POST',
          Uri.parse(
              '${Apis.leaverequest}?EmpID=${loginController.empID.toString()}&DateFrom=${formattedFirstfullday}&DateTo=${formattedLastfullday}&LeaveDays=${firsthalf.toString()}&LeavePurpose=${quotation.text}&Leavetype=${selectedValue.toString()}'));

      http.StreamedResponse response = await request.send();
      print('status${response.statusCode}');
      print('Response Body:$response');
      print("response2");
      if (response.statusCode == 200) {
        resetDates();
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: greenlight,
          duration: Duration(seconds: 2),
          content: Text('Your Request is Sent'),
        ));
        // ignore: unrelated_type_equality_checks
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
}
