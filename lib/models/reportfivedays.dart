// To parse this JSON data, do
//
//     final reportfiveDays = reportfiveDaysFromJson(jsonString);

import 'dart:convert';

List<ReportfiveDays> reportfiveDaysFromJson(String str) =>
    List<ReportfiveDays>.from(
        json.decode(str).map((x) => ReportfiveDays.fromJson(x)));

String reportfiveDaysToJson(List<ReportfiveDays> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ReportfiveDays {
  double empId;
  String empCode;
  String empName;
  double designationId;
  String designationTitle;
  double branchId;
  String branchTitle;
  double departmentId;
  String departmentCode;
  String departmentName;
  double? attId;
  int? attTypeId;
  String status;
  int? leaveId;
  String? dutyTime;
  String? checkInDateTime;
  String? checkInDate;
  String? checkInTime;
  String? checkOutTime;
  int? lateMinutes;
  int? workingMinutes;
  int? overtimeMinutes;
  String? checkOutDateTime;
  double? attendedBy;
  dynamic attendantName;
  String? date;
  String dateFrom;
  String dateTo;
  String weekDayName;

  ReportfiveDays({
    required this.empId,
    required this.empCode,
    required this.empName,
    required this.designationId,
    required this.designationTitle,
    required this.branchId,
    required this.branchTitle,
    required this.departmentId,
    required this.departmentCode,
    required this.departmentName,
    required this.attId,
    required this.attTypeId,
    required this.status,
    required this.leaveId,
    required this.dutyTime,
    required this.checkInDateTime,
    required this.checkInDate,
    required this.checkInTime,
    required this.checkOutTime,
    required this.lateMinutes,
    required this.workingMinutes,
    required this.overtimeMinutes,
    required this.checkOutDateTime,
    required this.attendedBy,
    required this.attendantName,
    required this.date,
    required this.dateFrom,
    required this.dateTo,
    required this.weekDayName,
  });

  factory ReportfiveDays.fromJson(Map<String, dynamic> json) => ReportfiveDays(
        empId: json["EmpID"],
        empCode: json["EmpCode"],
        empName: json["EmpName"],
        designationId: json["DesignationID"],
        designationTitle: json["DesignationTitle"],
        branchId: json["BranchID"],
        branchTitle: json["BranchTitle"],
        departmentId: json["DepartmentID"],
        departmentCode: json["DepartmentCode"],
        departmentName: json["DepartmentName"],
        attId: json["AttID"],
        attTypeId: json["AttTypeID"],
        status: json["Status"],
        leaveId: json["LeaveID"],
        dutyTime: json["DutyTime"],
        checkInDateTime: json["CheckInDateTime"],
        checkInDate: json["CheckInDate"],
        checkInTime: json["CheckInTime"],
        checkOutTime: json["CheckOutTime"],
        lateMinutes: json["LateMinutes"],
        workingMinutes: json["WorkingMinutes"],
        overtimeMinutes: json["OvertimeMinutes"],
        checkOutDateTime: json["CheckOutDateTime"],
        attendedBy: json["AttendedBy"],
        attendantName: json["AttendantName"],
        date: json["Date"],
        dateFrom: json["DateFrom"],
        dateTo: json["DateTo"],
        weekDayName: json["WeekDayName"],
      );

  Map<String, dynamic> toJson() => {
        "EmpID": empId,
        "EmpCode": empCode,
        "EmpName": empName,
        "DesignationID": designationId,
        "DesignationTitle": designationTitle,
        "BranchID": branchId,
        "BranchTitle": branchTitle,
        "DepartmentID": departmentId,
        "DepartmentCode": departmentCode,
        "DepartmentName": departmentName,
        "AttID": attId,
        "AttTypeID": attTypeId,
        "Status": status,
        "LeaveID": leaveId,
        "DutyTime": dutyTime,
        "CheckInDateTime": checkInDateTime,
        "CheckInDate": checkInDate,
        "CheckInTime": checkInTime,
        "CheckOutTime": checkOutTime,
        "LateMinutes": lateMinutes,
        "WorkingMinutes": workingMinutes,
        "OvertimeMinutes": overtimeMinutes,
        "CheckOutDateTime": checkOutDateTime,
        "AttendedBy": attendedBy,
        "AttendantName": attendantName,
        "Date": date,
        "DateFrom": dateFrom,
        "DateTo": dateTo,
        "WeekDayName": weekDayName,
      };
}
