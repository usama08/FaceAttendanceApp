import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geoofficeclock/network_utils/connectivity.dart';
import 'package:geoofficeclock/provider_service/apis_services/login_Apis.dart';
import 'package:geoofficeclock/services/servicepath.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/reportfivedays.dart';

class ReportFivedays extends ChangeNotifier {
  final networkcontroller = Get.put(NetworkConnect());
  SharedPreferences? prefs;
  // ignore: prefer_typing_uninitialized_variables
  var empid;
  bool initialized = false;
  Future<void> initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    empid = prefs?.getInt('empid');

    initialized = true;
  }

///////////load function /////////
  ReportFivedays() {
    fetchfivedayreport();
  }

  //////////  five days attendance report ///////////////
  List<ReportfiveDays> reportDataList = [];
  Future<List<ReportfiveDays>> fetchfivedayreport() async {
    reportDataList.clear();
    final loginController = Get.put(LoginApis());
    print("LOGGEDIN USER EMP ID IS ${loginController.empID.value}");
    try {
      final Uri uri = Uri.parse(Apis.lastfivedays);
      final Map<String, String> parameters = {
        'EmpID': loginController.empID.value.toString(),
      };

      final Uri updatedUri = uri.replace(queryParameters: parameters);

      final http.Response response = await http.get(updatedUri);

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);

        for (var userinfo in responseData) {
          var empid = userinfo['EmpID'];
          var empCode = userinfo['EmpCode'];
          var empName = userinfo['EmpName'];
          var designationID = userinfo['DesignationID'];
          var designationTitle = userinfo['DesignationTitle'];
          var branchId = userinfo['BranchID'];
          var branchTitle = userinfo['BranchTitle'];
          var departmentID = userinfo['DepartmentID'];
          var departmentName = userinfo['DepartmentName'];
          var departmentCode = userinfo['DepartmentCode'];
          var attID = userinfo['AttID'];
          var attTypeID = userinfo['AttTypeID'];
          var leaveID = userinfo['LeaveID'];
          var dutyTime = userinfo['DutyTime'];
          var checkInDateTime = userinfo['CheckInDateTime'];
          var status = userinfo['Status'];
          var checkInDate = userinfo['CheckInDate'];
          var checkInTime = userinfo['CheckInTime'];
          var checkOutTime = userinfo['CheckOutTime'];
          var lateMinutes = userinfo['LateMinutes'];
          var workingMinutes = userinfo['WorkingMinutes'];
          var overtimeMinutes = userinfo['OvertimeMinutes'];
          var checkOutDateTime = userinfo['CheckOutDateTime'];
          var attendedBy = userinfo['AttendedBy'];
          var attendantName = userinfo['AttendantName'];
          var date = userinfo['Date'];
          var dateFrom = userinfo['DateFrom'];
          var dateTo = userinfo['DateTo'];
          var weekDayName = userinfo['WeekDayName'];

          reportDataList.add(ReportfiveDays(
            empId: empid,
            branchTitle: branchTitle,
            checkInDate: checkInDate,
            checkInTime: checkInTime,
            checkOutTime: checkOutTime,
            designationTitle: designationTitle,
            empCode: empCode,
            departmentName: departmentName,
            lateMinutes: lateMinutes,
            empName: empName,
            status: status,
            weekDayName: weekDayName,
            workingMinutes: workingMinutes,
            attId: attID,
            attTypeId: attTypeID,
            attendantName: attendantName,
            attendedBy: attendedBy,
            branchId: branchId,
            checkOutDateTime: checkOutDateTime,
            checkInDateTime: checkInDateTime,
            dateFrom: dateFrom,
            date: date,
            dateTo: dateTo,
            departmentCode: departmentCode,
            dutyTime: dutyTime,
            departmentId: departmentID,
            designationId: designationID,
            leaveId: leaveID,
            overtimeMinutes: overtimeMinutes,
          ));
        }

        return reportDataList; // Return the list of report data
      } else {
        throw Exception('API response error: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('An error occurred: $e');
    }
  }
}
