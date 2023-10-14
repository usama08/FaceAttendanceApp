class ReportData {
  final double empID;
  final String fullName;
  final int presents;
  final int workFromHome;
  final int leaves;
  final int outDoorDuty;
  final int lateDays;
  final int totalDays;
  final int totalAbsent;

  ReportData({
    required this.empID,
    required this.fullName,
    required this.presents,
    required this.workFromHome,
    required this.leaves,
    required this.outDoorDuty,
    required this.lateDays,
    required this.totalDays,
    required this.totalAbsent,
  });

  factory ReportData.fromJson(Map<String, dynamic> json) {
    return ReportData(
      empID: json['EmpID'] ?? 0.0,
      fullName: json['FullName'] ?? '',
      presents: json['Presents'] ?? 0,
      workFromHome: json['WorkFromHome'] ?? 0,
      leaves: json['Leaves'] ?? 0,
      outDoorDuty: json['OutDoorDuty'] ?? 0,
      lateDays: json['LateDays'] ?? 0,
      totalDays: json['TotalDays'] ?? 0,
      totalAbsent: json['TotalAbsent'] ?? 0,
    );
  }
}
