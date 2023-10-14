class Apis {
  //// Base URl   ////
  static const baseUrl = 'https://differenttankayak97.conveyor.cloud/';

  /// liginapi  //
  static const logInApi = '${baseUrl}Api/User';

  /// previous 30 days data //
  static const attendacedata = '${baseUrl}Api/AttendanceData';

  /// check attendaus before if mark  //
  static const checkmark = '${baseUrl}Api/AttendanceBetweenTwoDates';

  /// mark Attendance api ///
  static const markattendance = '${baseUrl}Api/MarkAttendance';
  ////  show status  ///
  static const status = '${baseUrl}Api/AttendanceStatus';

  /// last five days data   //
  static const lastfivedays = '${baseUrl}Api/AttendanceData';

  /// all attendance details  ///
  static const allattendancedata = '${baseUrl}Api/AttendanceBetweenTwoDates';
  static const leaverequest = '${baseUrl}Api/LeaveRequest';
}
