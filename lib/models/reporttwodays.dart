import 'dart:convert';

List<Reporttwodays> reporttwodaysFromJson(String str) =>
    List<Reporttwodays>.from(
        json.decode(str).map((x) => Reporttwodays.fromJson(x)));

String reporttwodaysToJson(List<Reporttwodays> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Reporttwodays {
  int empId;
  String fullName;
  int presentss;
  int workFromHome;
  int leavess;
  int outDoorDuty;
  int lateDayss;
  int totalDays;
  int totalAbsents;
  int cl;
  int ml;
  int el;
  int cpl;
  int sl;
  int wop;
  int fhl;
  int shl;
  int lateMinutes;
  int workingHours;

  Reporttwodays({
    required this.empId,
    required this.fullName,
    required this.presentss,
    required this.workFromHome,
    required this.leavess,
    required this.outDoorDuty,
    required this.lateDayss,
    required this.totalDays,
    required this.totalAbsents,
    required this.cl,
    required this.ml,
    required this.el,
    required this.cpl,
    required this.sl,
    required this.wop,
    required this.fhl,
    required this.shl,
    required this.lateMinutes,
    required this.workingHours,
  });

  factory Reporttwodays.fromJson(Map<String, dynamic> json) => Reporttwodays(
        empId: json["EmpID"],
        fullName: json["FullName"],
        presentss: json["Presents"],
        workFromHome: json["WorkFromHome"],
        leavess: json["Leaves"],
        outDoorDuty: json["OutDoorDuty"],
        lateDayss: json["LateDays"],
        totalDays: json["TotalDays"],
        totalAbsents: json["TotalAbsent"],
        cl: json["CL"],
        ml: json["ML"],
        el: json["EL"],
        cpl: json["CPL"],
        sl: json["SL"],
        wop: json["WOP"],
        fhl: json["FHL"],
        shl: json["SHL"],
        lateMinutes: json["LateMinutes"],
        workingHours: json["WorkingHours"],
      );

  Map<String, dynamic> toJson() => {
        "EmpID": empId,
        "FullName": fullName,
        "Presents": presentss,
        "WorkFromHome": workFromHome,
        "Leaves": leavess,
        "OutDoorDuty": outDoorDuty,
        "LateDays": lateDayss,
        "TotalDays": totalDays,
        "TotalAbsent": totalAbsents,
        "CL": cl,
        "ML": ml,
        "EL": el,
        "CPL": cpl,
        "SL": sl,
        "WOP": wop,
        "FHL": fhl,
        "SHL": shl,
        "LateMinutes": lateMinutes,
        "WorkingHours": workingHours,
      };
}
